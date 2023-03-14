Dado('que eu gere o access token de autorização para os demais serviços') do
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
  
E('que eu crie um login para reset de senha') do
    @body = {
        userName: "41154948838",
        password: "Teste*123",
        personType: "PROFISSIONAL_SAUDE",
        contact: {
        id: 1282466
    },
      person: {
         id: 4204870,
         name: "Prof Saude Otp Adriel",
         cpf: "99904098034"
      },
      contactToSendToken: "EMAIL",
      brand: "NAV",
      platform: "NAV_PRO"
    }.to_json
  
@post_createLogin = CreateLogin.post('/singleLogin/v3/createLogin' , body: @body, headers: @headers)
puts @post_createLogin.body   
end
  
E('faço o checkAccount para reset de senha') do
    @checkAccount = {
        "userName": "41154948838",
        "personType": "PROFISSIONAL_SAUDE",
        "token": "123456"
    }.to_json

@put_checkAccount = CheckAccount.put('/singleLogin/v1/checkAccount' , body: @checkAccount, headers: @headers)
puts @put_checkAccount.body    
end
  
E('gero token de reset de senha') do
    @message = { 
        "userName": "41154948838",
        "personType": "PROFISSIONAL_SAUDE",
        "contactToSendToken": "EMAIL",
        "contact": {"id":1282466},    
        "brand": "NAV",
        "templateName": "",
        "params": {}
    }.to_json

@post_message = MessageChangePassword.post('/singleLogin/v2/messageChangePassword' , body: @message, headers: @headers)
puts @post_message.body    
end
  
E('erro três vezes para expirar o token') do
    @changePassword = {
        userName: "41154948838",
        personType: "PROFISSIONAL_SAUDE",
        token: "12345x",
        newPassword: "Teste*123"
    }.to_json

@put_changePassword = ChangePassword.put('/singleLogin/v1/changePassword' , body: @changePassword, headers: @headers)
puts @put_changePassword.body

@changePassword2 = {
    userName: "41154948838",
    personType: "PROFISSIONAL_SAUDE",
    token: "12345y",
    newPassword: "Teste*123"
}.to_json

@put_changePassword2 = ChangePassword.put('/singleLogin/v1/changePassword' , body: @changePassword2, headers: @headers)
puts @put_changePassword2.body

@changePassword3 = {
    userName: "41154948838",
    personType: "PROFISSIONAL_SAUDE",
    token: "12345w",
    newPassword: "Teste*123"
}.to_json

@put_changePassword3 = ChangePassword.put('/singleLogin/v1/changePassword' , body: @changePassword3, headers: @headers)
puts @put_changePassword3.body   
end
  
E('valido mensagem de token expirado') do
expect(@put_changePassword.code).to eql 406
expect(@put_changePassword.parsed_response['message']).to eql 'Token is not valid!, 1 unsuccessful attempts were made to change the login password'
expect(@put_changePassword.parsed_response['error']).to eql 'NOT_ACCEPTABLE'
    
expect(@put_changePassword2.code).to eql 406
expect(@put_changePassword2.parsed_response['message']).to eql 'Token is not valid!, 2 unsuccessful attempts were made to change the login password'
expect(@put_changePassword2.parsed_response['error']).to eql 'NOT_ACCEPTABLE'
    
expect(@put_changePassword3.code).to eql 406
expect(@put_changePassword3.parsed_response['message']).to eql 'Token is not valid!, 3 unsuccessful attempts were made to change the login password'
expect(@put_changePassword3.parsed_response['error']).to eql 'NOT_ACCEPTABLE'    
end
  
E('gero novamente o token e insiro corretamente os dados') do
    @message4 = { 
        "userName": "41154948838",
        "personType": "PROFISSIONAL_SAUDE",
        "contactToSendToken": "EMAIL",
        "contact": {"id":1282466},    
        "brand": "NAV",
        "templateName": "",
        "params": {}
    }.to_json

@post_message4 = MessageChangePassword.post('/singleLogin/v2/messageChangePassword' , body: @message4, headers: @headers)
puts @post_message.body    
end
  
Quando('faço o reset de senha') do
    @changePassword4 = {
        userName: "41154948838",
        personType: "PROFISSIONAL_SAUDE",
        token: "123456",
        newPassword: "Teste*123"
    }.to_json
    
    @put_changePassword4 = ChangePassword.put('/singleLogin/v1/changePassword' , body: @changePassword4, headers: @headers)
    puts @put_changePassword4.body    
end
  
Então('valido que o sistema retorna sucesso') do
expect(@put_changePassword4.code).to eql 200  

@username = "41154948838"
@personType = "PROFISSIONAL_SAUDE"
@deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}", headers: @headers)
puts @deleteLogin.body
end