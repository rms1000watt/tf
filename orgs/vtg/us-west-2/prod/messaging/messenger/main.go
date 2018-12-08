package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strings"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ses"
)

var (
	slackWebhookURL string
	svcSES          *ses.SES

	charSet = "UTF-8"
)

// Message is incoming from the website
type Message struct {
	Name    string `json:"name"`
	Email   string `json:"email"`
	Subject string `json:"subject"`
	Message string `json:"message"`
}

// Handler processes the API Gateway proxy request
func Handler(request events.APIGatewayProxyRequest) (res events.APIGatewayProxyResponse, err error) {
	fmt.Println("Start")
	defer fmt.Println("Done")

	msg := Message{}
	if err = json.Unmarshal([]byte(request.Body), &msg); err != nil {
		fmt.Println("Failed unmarshalling input:", err)
		return
	}

	fmt.Println("Email:", msg.Email)
	fmt.Println("Message:", msg.Message)

	slack(msg)
	if err = email(msg); err != nil {
		fmt.Println("Failed sending email:", err)
		return
	}

	res = events.APIGatewayProxyResponse{
		Body:       `{"success":true}`,
		StatusCode: http.StatusOK,
		Headers: map[string]string{
			"Access-Control-Allow-Origin": "*",
		},
	}

	return
}

func slack(msg Message) {
	name := trunc(msg.Name, 16)
	email := trunc(msg.Email, 64)
	subject := trunc(msg.Subject, 16)
	message := trunc(msg.Message, 4000)
	msgStr := fmt.Sprintf("Name=%s Email=%s Subject=%s Message=%s", name, email, subject, message)

	buf := bytes.NewBufferString(fmt.Sprintf(`{"text":"%s","username":"Message Bot","icon_emoji":":robot_face:"}`, msgStr))
	if _, err := http.Post(slackWebhookURL, "application/json", buf); err != nil {
		fmt.Println("Failed posting to slack:", err)
	}
}

func email(msg Message) (err error) {
	in := ses.SendEmailInput{
		Destination: &ses.Destination{
			ToAddresses: []*string{
				aws.String("chad@valkyriebrands.com"),
				aws.String("dale@valkyriebrands.com"),
				aws.String("hello@valkyriebrands.com"),
			},
		},
		Message: &ses.Message{
			Subject: &ses.Content{
				Charset: aws.String(charSet),
				Data:    aws.String(msg.Subject),
			},
			Body: &ses.Body{
				Text: &ses.Content{
					Charset: aws.String(charSet),
					Data:    aws.String(msg.Message),
				},
			},
		},
		ReplyToAddresses: []*string{
			aws.String(msg.Email),
		},
		Source: aws.String("0.valkyriebrands@gmail.com"),
	}

	_, err = svcSES.SendEmail(&in)
	return
}

func trunc(s string, l int) (out string) {
	if len(s) <= l {
		out = s
		return
	}

	out = s[:l]
	return
}

func env() (err error) {
	kvs := map[string]*string{
		"SLACK_WEBHOOK_URL": &slackWebhookURL,
	}

	for k, v := range kvs {
		*v = os.Getenv(k)
		if strings.TrimSpace(*v) == "" {
			err = fmt.Errorf("%s env var not defined", k)
			return
		}
	}

	return
}

func main() {
	if err := env(); err != nil {
		fmt.Println("Failed getting env vars")
		return
	}

	sess := session.New()
	svcSES = ses.New(sess)
	lambda.Start(Handler)
}
