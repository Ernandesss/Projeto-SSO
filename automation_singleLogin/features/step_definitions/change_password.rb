Dado('que eu crie um login para reset de senha') do
    @body = {
        userName: "41544635001",
        password: "Teste*123",
        personType: "PROFISSIONAL_SAUDE",
        contact: {
        email: "esteirateste@gmail.com",
        mobile: "11959253822"
      },
      person: {
         id: 4142737,
         name: "Teste Esteira",
         cpf: "41544635001"
      },
      contactToSendToken: "EMAIL",
      brand: "NAV",
      platform: "NAV_PRO"
    }.to_json
  
@post_createLogin = CreateLogin.post('/singleLogin/v2/createLogin' , body: @body)
puts @post_createLogin.body
  
end
  
E('faço o checkAccount para reset de senha') do
    @checkAccount = {
        "userName": "41544635001",
        "personType": "PROFISSIONAL_SAUDE",
        "token": "123456"
    }.to_json

@put_checkAccount = CheckAccount.put('/singleLogin/v1/checkAccount' , body: @checkAccount)
puts @put_checkAccount.body
 
end
  
E('gero token de reset de senha') do
    @message = { 
        "userName": "41544635001",
        "personType": "PROFISSIONAL_SAUDE",
        "contactToSendToken": "EMAIL",
        "brand": "NAV",
        "templateName": "",
        "params": {}
    }.to_json

@post_message = MessageChangePassword.post('/singleLogin/v1/messageChangePassword' , body: @message)
puts @post_message.body
end
   
E('erro três vezes para expirar o token') do
    @changePassword = {
        userName: "41544635001",
        personType: "PROFISSIONAL_SAUDE",
        token: "12345x",
        newPassword: "Teste@123"
    }.to_json

@put_changePassword = ChangePassword.put('/singleLogin/v1/changePassword' , body: @changePassword)
puts @put_changePassword.body

@changePassword2 = {
    userName: "41544635001",
    personType: "PROFISSIONAL_SAUDE",
    token: "12345y",
    newPassword: "Teste@123"
}.to_json

@put_changePassword2 = ChangePassword.put('/singleLogin/v1/changePassword' , body: @changePassword2)
puts @put_changePassword2.body

@changePassword3 = {
    userName: "41544635001",
    personType: "PROFISSIONAL_SAUDE",
    token: "12345w",
    newPassword: "Teste@123"
}.to_json

@put_changePassword3 = ChangePassword.put('/singleLogin/v1/changePassword' , body: @changePassword3)
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
expect(@put_changePassword3.parsed_response['message']).to eql 'Token is expired!, 3 unsuccessful attempts were made to change the login password'
expect(@put_changePassword3.parsed_response['error']).to eql 'NOT_ACCEPTABLE'
end
  
E('gero novamente o token e insiro corretamente os dados') do
    
    @message4 = { 
        "userName": "41544635001",
        "personType": "PROFISSIONAL_SAUDE",
        "contactToSendToken": "EMAIL",
        "brand": "NAV",
        "templateName": "",
        "params": {}
    }.to_json

@post_message4 = MessageChangePassword.post('/singleLogin/v1/messageChangePassword' , body: @message4)
puts @post_message.body
end
  
  
Quando('faço o reset de senha') do
    @changePassword4 = {
        userName: "41544635001",
        personType: "PROFISSIONAL_SAUDE",
        token: "123456",
        newPassword: "Teste@123"
    }.to_json
    
    @put_changePassword4 = ChangePassword.put('/singleLogin/v1/changePassword' , body: @changePassword4)
    puts @put_changePassword4.body
    
end
  
  
Então('valido que o sistema retorna sucesso') do
expect(@put_changePassword4.code).to eql 200

@username = "41544635001"
@personType = "PROFISSIONAL_SAUDE"
@deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}")
puts @deleteLogin.body

end