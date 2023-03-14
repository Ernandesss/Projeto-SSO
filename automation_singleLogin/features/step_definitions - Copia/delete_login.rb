Dado('que eu gere o token Keycloack para autorizar os serviços') do
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
end
  
Dado('deleto todos os logins criados em cenários anteriores') do
    @username = "41544635001"
    @personType = "PROFISSIONAL_SAUDE"
    @deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}", headers: @headers)
    puts @deleteLogin.body
    
    @username = "33434007008"
    @personType = "PROFISSIONAL_SAUDE"
    @deleteLogin2 = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}", headers: @headers)
    puts @deleteLogin2.body
    
    @username = "99904098034"
    @personType = "PROFISSIONAL_SAUDE"
    @deleteLogin3 = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}", headers: @headers)
    puts @deleteLogin3.body 

    @username = "41154948838"
    @personType = "PROFISSIONAL_SAUDE"
    @deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}", headers: @headers)
    puts @deleteLogin.body

end
  
Então('eu valido que todos logins foram deletados') do
# expect(@deleteLogin.code).to eql 200
expect(@deleteLogin2.code).to eql 200
expect(@deleteLogin3.code).to eql 200
end