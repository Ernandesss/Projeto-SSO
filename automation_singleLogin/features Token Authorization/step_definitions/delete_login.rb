@body = {
    client_id: "singlelogin",
    grant_type: "client_credentials",
    client_secret: "77f3092d-8fe6-4241-a01b-a5dda39f068e"
  }
  
  @gerar_token = GenerateToken.post('/token', body: @body)
  puts @gerar_token.parsed_response['access_token']
  
  
  @headers = {
    'Content-Type': "application/json",
    'user': "singlelogin-plugin",
    'Authorization': "Bearer #{@gerar_token.parsed_response['access_token']}"
  }


Dado('que eu tenha logins criados em cenários anteriores') do
@username = "41544635001"
@personType = "PROFISSIONAL_SAUDE"
@deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}")
puts @deleteLogin.body

@username = "33434007008"
@personType = "PROFISSIONAL_SAUDE"
@deleteLogin2 = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}")
puts @deleteLogin2.body

@username = "41544635001"
@personType = "PROFISSIONAL_SAUDE"
@deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}")
puts @deleteLogin.body

@username = "41544635001"
@personType = "PROFISSIONAL_SAUDE"
@deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}")
puts @deleteLogin.body

@username = "99904098034"
@personType = "PROFISSIONAL_SAUDE"
@deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}")
puts @deleteLogin.body
end
  
Então('todos logins foram deletados') do

end