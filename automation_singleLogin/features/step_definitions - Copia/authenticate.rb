Dado('que eu gere o Authorize token') do
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

Dado('que eu crie um novo login de uma persona com sucesso') do
  @body = {
    userName: "41544635001",
    password: "Teste*123",
    personType: "PROFISSIONAL_SAUDE",
    contact: {
    email: "esteirateste@gmail.com"
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

@post_createLogin = CreateLogin.post('/singleLogin/v2/createLogin' , body: @body, headers: @headers)
puts @post_createLogin.body
end

Quando('eu faço o checkAccount e gero o token') do
  @checkAccount = {
    "userName": "41544635001",
    "personType": "PROFISSIONAL_SAUDE",
    "token": "123456"
  }.to_json
@put_checkAccount = CheckAccount.put('/singleLogin/v1/checkAccount' , body: @checkAccount, headers: @headers)
puts @put_checkAccount.body 
end

Quando('realizo a autenticação') do
  @authenticate = {
    "client_id": "profissional-saude",
    "client_secret": "34f01a7a-b4f7-4bb2-a586-5e42b27f3792",
    "userName": "41544635001",
    "password": "Teste*123",
    "personType": "PROFISSIONAL_SAUDE"
  }.to_json

@post_authenticate = Authenticate.post('/singleLogin/v2/authenticate' , body: @authenticate, headers: @headers)
puts @post_authenticate.body   

@authenticate2 = {
  "userName": "21644215829",
  "personType": "PACIENTE",
  "password": "Teste@123",
  "platform": "NAV"
}.to_json

@post_authenticate2 = Authenticate.post('/singleLogin/v2/authenticate' , body: @authenticate2, headers: @headers)
puts @post_authenticate2.body
end

Então('eu valido que o sistema autentica o login criado') do
expect(@post_authenticate.code).to eql 200
expect(@post_authenticate2.code).to eql 200

@username = "41544635001"
@personType = "PROFISSIONAL_SAUDE"
@deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}", headers: @headers)
puts @deleteLogin.body
end


