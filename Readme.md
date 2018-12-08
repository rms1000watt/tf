# tf

## Create New Org

Manually edit `orgs/create-org.sh` then run:

```bash
ORG_NAME=rms1000watt AWS_PROFILE=personal AWS_REMOTE_STATE_REGION=us-west-2 ./create-org.sh
```

## Create New App

```bash
cd orgs
./create-app.sh rms1000watt us-west-2 prod messaging
./create-app.sh rms1000watt global global website
```
