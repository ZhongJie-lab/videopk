import requests
rooturl = "https://glacial-hollows-47187.herokuapp.com"
failedRes = requests.get(rooturl+"/api/v1/battles.json")
print(failedRes.text)
loginRes = requests.post(rooturl+ "/users/sign_in.json", params={'appid':'app123', 'appsecret':'333', 'email':'admin@test.com', 'password':'123456'})
print(loginRes.text)
auth_token = loginRes.json()['authentication_token']
successRes = requests.get(rooturl+ "/api/v1/battles.json", params={'appid':'app123', 'appsecret':'333', 'user_email':'admin@test.com', 'user_token':auth_token})
print(successRes.text)
