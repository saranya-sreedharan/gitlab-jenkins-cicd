curl "https://gitlab.example.com/api/v4/projects/project_id"
https://gitlab.com/practice-group9221502/jenkins-project/-/tree/dev?ref_type=heads

https://gitlab.com/api/v4/projects/practice-group9221502%2Fjenkins-project


This is my personal access token:
glpat-nze5jtYvzsP4UX6vv4qV

#1. list all the files in the project repository in the main branch
curl --header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" \
     "https://gitlab.com/api/v4/projects/practice-group9221502%2Fjenkins-project/repository/tree" | jq





#2. List all the files in the project repository in the dev branch

curl --header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" \
     "https://gitlab.com/api/v4/projects/practice-group9221502%2Fjenkins-project/repository/tree?ref=dev" | jq

#3. To list all the files and folders inside a specific folder within a project's repository

curl --header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" \
     "https://gitlab.com/api/v4/projects/practice-group9221502%2Fjenkins-project/repository/tree?ref=dev&path=path/to/folder" | jq

eg:

curl --header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" \
     "https://gitlab.com/api/v4/projects/practice-group9221502%2Fjenkins-project/repository/tree?ref=dev&path=assets" | jq


#4. if you want to pull the project as a zip file using curl: 
curl --header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" \
     "https://gitlab.com/api/v4/projects/practice-group9221502%2Fjenkins-project/repository/archive.zip" \
     --output jenkins-project.zip


#This is the curl command to access the project token, (project id, token - check before executing)

curl --header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" "https://gitlab.example.com/api/v4/projects/55588747/access_tokens"






Type of request: GET
short name about the api: get_gitlab_access_token
description: This will collect the access token and we can use in the CICD pipeline
url: https://gitlab.example.com/api/v4/projects/
endpoint: 55588747/access_tokens
request_param: na
response_success:
response_error: Not 


1. 
Type of request: GET
short name about the api: get_gitlab_file_list_dev
description: This will show all the files of specific branch of the project. Here the branch is dev
url: https://gitlab.example.com/api/v4/projects/
endpoint: practice-group9221502%2Fjenkins-project/repository/tree?ref=dev
request_param: na
response_success:json data
response_error: Not 












3