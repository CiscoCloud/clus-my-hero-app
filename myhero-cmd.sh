#! /bin/bash

[ -z "$MANTL_CONTROL" ] && echo "Please run 'source myhero_setup' to set Environment Variables" && exit 1;
[ -z "$MANTL_USER" ] && echo "Please run 'source myhero_setup' to set Environment Variables" && exit 1;
[ -z "$MANTL_PASSWORD" ] && echo "Please run 'source myhero_setup' to set Environment Variables" && exit 1;
[ -z "$MANTL_DOMAIN" ] && echo "Please run 'source myhero_setup' to set Environment Variables" && exit 1;
[ -z "$DEPLOYMENT_NAME" ] && echo "Please run 'source myhero_setup' to set Environment Variables" && exit 1;



function _myhero_list_apps() {
  curl -k -X GET -u $MANTL_USER:$MANTL_PASSWORD https://$MANTL_CONTROL:$MANTL_PORT/marathon/v2/apps?label=app-grp==my-hero \
  -H "Content-type: application/json" \
  -d @$DEPLOYMENT_NAME-app.json \
  | python -m json.tool
}
alias myhero_list_apps=_myhero_list_apps


function _myhero_get_app() {
  curl -k -X GET -u $MANTL_USER:$MANTL_PASSWORD https://$MANTL_CONTROL:$MANTL_PORT/marathon/v2/apps/$DEPLOYMENT_NAME/web \
  -H "Content-type: application/json" \
  -d @$DEPLOYMENT_NAME-app.json \
  | python -m json.tool
}
alias myhero_get_app=_myhero_get_app

function _myhero_scale_up_web() {

  SERVICES_INSTANCE=$(curl -k -X GET -u $MANTL_USER:$MANTL_PASSWORD https://$MANTL_CONTROL:$MANTL_PORT/marathon/v2/apps/$DEPLOYMENT_NAME/web \
  -H "Content-type: application/json" \
  -d @$DEPLOYMENT_NAME-app.json \
  | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["app"]["instances"]';)

  echo "You have $SERVICES_INSTANCE instnace running, please enter number of instance to scale (e.g. integer > $SERVICES_INSTANCE)"
  read sacle_to_instance

  curl -k -X PUT -u $MANTL_USER:$MANTL_PASSWORD https://$MANTL_CONTROL:$MANTL_PORT/marathon/v2/apps/$DEPLOYMENT_NAME/web -H "Content-type: application/json" -d '{"instances":'$sacle_to_instance'}' | python -m json.tool
}
alias myhero_scale_up_web=_myhero_scale_up_web


function _myhero_scale_down_web() {

  SERVICES_INSTANCE=$(curl -k -X GET -u $MANTL_USER:$MANTL_PASSWORD https://$MANTL_CONTROL:$MANTL_PORT/marathon/v2/apps/$DEPLOYMENT_NAME/web \
  -H "Content-type: application/json" \
  -d @$DEPLOYMENT_NAME-app.json \
  | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["app"]["instances"]';)

  echo "You have $SERVICES_INSTANCE instnace running, please enter number of instance to scale down (e.g. integer < $SERVICES_INSTANCE)"
  read sacle_to_instance

  curl -k -X PUT -u $MANTL_USER:$MANTL_PASSWORD https://$MANTL_CONTROL:$MANTL_PORT/marathon/v2/apps/$DEPLOYMENT_NAME/web -H "Content-type: application/json" -d '{"instances":'$sacle_to_instance'}' | python -m json.tool
}
alias myhero_scale_down_web=_myhero_scale_down_web
