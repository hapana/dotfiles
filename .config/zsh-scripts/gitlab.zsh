# glr main
#glr () {
#  local instance
#  curl --header "Private-Token: $GITLAB_MAIN_API_TOKEN" \
#    https://gitlab.com/api/v4/groups/LUSHDigital/subgroups
#}
#
#ge () {
#  local project
#  local project=$1
#  curl --request POST --header "PRIVATE-TOKEN: $GITLAB_FSA_API_TOKEN" \
#    https://gitlab.frontendserviceaccount.com/api/v4/projects/$project/export
#}
