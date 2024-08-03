curl "https://gitlab.example.com/api/v4/projects/project_id"
https://gitlab.com/practice-group9221502/jenkins-project/-/tree/dev?ref_type=heads

https://gitlab.com/api/v4/projects/practice-group9221502%2Fjenkins-project


This is my personal access token:
glpat-nze5jtYvzsP4UX6vv4qV

glpat-2VpmgDxWJcNfcq5przvF

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

curl --header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" "https://gitlab.example.com/api/v4/groups/80578293/access_tokens"



gldt-opVky54Te17X1pWdsnag


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
short name about the api: get_gitlab_file_list_main
description: This will show all the files in the main branch of the project.
url: https://gitlab.example.com/api/v4/projects/
endpoint: practice-group9221502%2Fjenkins-project/repository/tree
request_param: na
response_success:json data
response_error: Not 

![alt text](image-1.png)


2.
Type of request: GET
short name about the api: get_gitlab_file_list_dev
description: This will show all the files of specific branch of the project. Here the branch is dev
url: https://gitlab.example.com/api/v4/projects/
endpoint: practice-group9221502%2Fjenkins-project/repository/tree?ref=dev
request_param: na
response_success:json data
response_error: Not 

![alt text](image.png)

3. 
Type of request: GET
short name about the api: get_gitlab_file_list_dev
description: To list all the files and folders inside a specific folder within a project's repository
url: https://gitlab.example.com/api/v4/projects/
endpoint: practice-group9221502%2Fjenkins-project/repository/tree?ref=dev&path=path/to/folder
request_param: na
response_success:json data
response_error: Not 


![alt text](image-2.png)

#Dockerfile To get the all dockerfile
curl "https://gitlab.example.com/api/v4/templates/dockerfiles"



4. Create a group access token 

Type of request: POST
short name about the api: create_group_access_token
description: Create a group_access_token
url: https://gitlab.example.com/api/v4/groups/
endpoint: <group_id>/access_tokens
request_param: na
response_success:json data
response_error: Not 

curl --request POST --header "PRIVATE-TOKEN: <your_access_token>" \
--header "Content-Type:application/json" \
--data '{ "name":"test_token", "scopes":["api", "read_repository"], "expires_at":"2021-01-31", "access_level": 30 }' \
"https://gitlab.example.com/api/v4/groups/<group_id>/access_tokens"


eg: 

curl --request POST --header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" \
--header "Content-Type:application/json" \
--data '{ "name":"test_token", "scopes":["api", "read_repository"], "expires_at":"2021-01-31", "access_level": 30 }' \
"https://gitlab.com/api/v4/groups/80578293/access_tokens"

variables : personal_token, group_id, the gitlab url

Type of request: POST
short name about the api: create_project_access_token
description: Create a group access token
url: https://gitlab.com/api/v4/groups
endpoint: 80578293/access_tokens
request_param: data '{ "name":"test_token", "scopes":["api", "read_repository"], "expires_at":"2021-01-31", "access_level": 30 }
response_success:json data
response_error: Not 


5. List all the instance veriable in instance level CI

curl --header "PRIVATE-TOKEN: <your_access_token>" "https://gitlab.example.com/api/v4/admin/ci/variables"

6. Show instance veriable details 

curl --header "PRIVATE-TOKEN: <your_access_token>" "https://gitlab.example.com/api/v4/admin/ci/variables/TEST_VARIABLE_1"

7. Create instance veriable

curl --request POST --header "PRIVATE-TOKEN: <your_access_token>" \
     "https://gitlab.com/api/v4/admin/ci/variables" --form "key=NEW_VARIABLE" --form "value=new value"

8. Update instance veriable

curl --request PUT --header "PRIVATE-TOKEN: <your_access_token>" \
     "https://gitlab.example.com/api/v4/admin/ci/variables/NEW_VARIABLE" --form "value=updated value"

9. List all the active integrations (provide the project id)

GET /projects/:id/integrations

curl --request GET --header "PRIVATE-TOKEN: glpat-dskMa5FWx-Vn5PZznnxD" \
https://gitlab.example.com/api/v4/projects/id/integrations
eg: 
55588747=project-id
curl --request GET --header "PRIVATE-TOKEN: glpat-dskMa5FWx-Vn5PZznnxD" \
https://gitlab.com/api/v4/projects/55588747/integrations

10. To integrate jenkins with gitlab  (Data givings is all are veriable )

curl --request POST \
--header "PRIVATE-TOKEN: YOUR_PRIVATE_TOKEN" \
--header "Content-Type: application/json" \
--data '{
  "jenkins_url": "JENKINS_URL",
  "project_name": "PROJECT_NAME",
  "username": "JENKINS_USERNAME",
  "password": "JENKINS_PASSWORD",
  "build_trigger_token": "BUILD_TRIGGER_TOKEN"
}' \
"https://gitlab.com/api/v4/projects/PROJECT_ID/services/jenkins"


#this build trigger is optional. if it is not required then we can remove that line (if updating the connection use PUT instead of POST)

curl --request POST \
--header "PRIVATE-TOKEN: YOUR_PRIVATE_TOKEN" \
--header "Content-Type: application/json" \
--data '{
  "jenkins_url": "JENKINS_URL",
  "project_name": "PROJECT_NAME",
  "username": "JENKINS_USERNAME",
  "password": "JENKINS_PASSWORD"
}' \
"https://gitlab.com/api/v4/projects/PROJECT_ID/services/jenkins"


11. If yopu wanat to take the ssh keys from the gitlab (403 error indicating permission issue with the token)

curl --header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" \
  "https://gitlab.com/api/v4/keys/1"


12. To add a new ssh key in gitlab (give the personal-access-token, correct ssh key )

curl --request POST \
--header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" \
--header "Content-Type: application/json" \
--data '{
  "title": "My SSH Key",
  "key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCJEzjs2Mds7bQ5mELh8IRJhqyWmTJCrOfV5g4xmS5yELGCjFGPecGCgAKf6m1a3UGudjTsd4/jgtlnD+3EHXRaaKqWFmpSEedaFY+/w+H+IR+uXvhS4Zzu6RN6+RoKEhh5H8rImJ7YiCJpoIbhn8uNiTPCVOngB90fMXqaL01P5cVN87fdpqEb2FgRn1V8KBnsQtNAKs0ttAZ0WkwgoELskIfBTihTkT73qPbcjE3LGtEBwJORTlXbvojXOWE7Xpbp1uYiNxDEGPlCUNo4cwdJZfwEG8at4AoCbCBFlDUYC3cpcTTCS8ADOpkdMrYGQnz0kcL6ZZEzgIqeZlnhkd0b ec2_pemkey.pem",
  "can_push": true
}' \
"https://gitlab.com/api/v4/user/keys"


13. to get the personal access token

curl --header "PRIVATE-TOKEN: <your_access_token>" "https://gitlab.example.com/api/v4/personal_access_tokens"
Eg: 
curl --header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" "https://gitlab.com/api/v4/personal_access_tokens"


14. Creating a personal access token

curl --request POST \
--header "PRIVATE-TOKEN: glpat-nze5jtYvzsP4UX6vv4qV" \
--data "name=MyToken&expires_at=2024-12-31&scopes=api read_repository write_repository" \
"https://gitlab.com/api/v4/user/personal_access_tokens"

Type of request: POST
short name about the api: 
description: To list all the files and folders inside a specific folder within a project's repository
url: https://gitlab.example.com/api/v4/projects/
endpoint: practice-group9221502%2Fjenkins-project/repository/tree?ref=dev&path=path/to/folder
request_param: na
response_success:json data
response_error: Not 


