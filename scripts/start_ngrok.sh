if [[ $NGROK_AUTHTOKEN == "" ]]; then
  echo "No auth token provided"
  exit 1
fi

NGROK_REGION_REGEX="^(us|eu|au|ap|sa|jp|in)$"
[[ $NGROK_REGION =~ $NGROK_REGION_REGEX ]] && NGROK_REGION=$NGROK_REGION || NGROK_REGION="us"
echo "Detected ngrok region $NGROK_REGION"

ngrok config add-authtoken $NGROK_AUTHTOKEN
echo $NGROK_REGION > /tmp/ngrok_region
ngrok tcp 25565 --region=$NGROK_REGION
