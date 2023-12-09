# Docker - Cloudflare IP List (watcher)

Small Docker image based on Alpine Linux that will allow you to update a list of IPs based on their hostnames

## Usage (docker run)
```
docker run \
    -e ACCOUNT_ID=[YOUR_ACCOUNT_ID] \
    -e LIST_ID=[YOUR_LIST_ID] \
    -e TOKEN=[YOUR_TOKEN] \
    -e HOSTNAMES="docker.com example.com" \
    -e CHECK_INTERVAL_SECONDS=60 \
    trebsoj/docker-cloudflare-ip-list

```
In fields HOSTNAMES and CHECK_INTERVAL_SECONDS in the previous code they are only examples.

## Usage (docker compose)
```
name: cloudflare-list-ip
services:
    cloudflare-list-ip:
        image: trebsoj/cloudflare-list-ip:latest
        restart: always
        environment:
            - ACCOUNT_ID=[YOUR_ACCOUNT_ID]
            - LIST_ID=[YOUR_LIST_ID]
            - TOKEN=[YOUR_TOKEN]
            - HOSTNAMES="docker.com example.com"
            - CHECK_INTERVAL_SECONDS=60

```
In fields HOSTNAMES and CHECK_INTERVAL_SECONDS in the previous code they are only examples.

## Environments
- Required `ACCOUNT_ID` : Your CloudFlare account ID.
- Required `LIST_ID` : List ID that you want to update.
- Required `TOKEN` : Your CloudFlare scoped API token.
- Required `HOSTNAMES` : List of hostnames, separated by a white space.
- Required `CHECK_INTERVAL_SECONDS` : Seconds between check.

## Create new API token

To create a CloudFlare API token for your DNS zone go to https://dash.cloudflare.com/profile/api-tokens and follow these steps:

1. Click Create Token
2. Provide the token a name, for example, docker-cloudflare-ip-list
3. Grant the token the following permissions:
   - Permissions - Account Filter Lists - Edit
   - Account Resources - All accounts
   - Continue to summary
4. Complete the wizard and copy the generated token into the TOKEN variable for the container.

## Create new list
To create a new list in Cloudflare follow these steps:
1. Go to List Menu:
   ![List menu](/images/create-new-list-01.png)
2. Set Type=IP.
3. Set name of list.
4. Save.

## Get Account and List ID
We can easily obtain these 2 identifiers from the browser's URL.

In the previous menu, if you click on the list edition:
![List menu](/images/create-new-list-02.png)

The browser URL will look something like this:


- `https://dash.cloudflare.com/`***ACCOUNT_ID***`/configurations/lists/`***LIST_ID***