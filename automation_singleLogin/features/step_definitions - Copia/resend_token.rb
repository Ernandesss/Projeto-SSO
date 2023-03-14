Dado('que eu gere um authorize access token') do
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

E('que eu crie um login para reenvio de token') do
  @body = {
    userName: "99904098034",
    password: "Teste*123",
    personType: "PROFISSIONAL_SAUDE",
    contact: {
    email: "automacao.pipeline@gmail.com",
    mobile: "11986399002"
  },
  person: {
     id: 4153752,
     name: "Automação Pipeline",
     cpf: "99904098034"
  },
  contactToSendToken: "EMAIL",
  brand: "NAV",
  platform: "NAV_PRO"
}.to_json

@post_createLogin = CreateLogin_KnowToken.post('/singleLogin/v2/createLogin' , body: @body, headers: @headers)
puts @post_createLogin.body
end

E('erro três vezes o token enviado para expirar') do
  @checkAccount1 = {
    "userName": "99904098034",
    "personType": "PROFISSIONAL_SAUDE",
    "token": "123457"
  }.to_json

@put_checkAccount1 = CheckAccount.put('/singleLogin/v1/checkAccount' , body: @checkAccount1, headers: @headers)
puts @put_checkAccount1.body

@checkAccount2 = {
  "userName": "99904098034",
  "personType": "PROFISSIONAL_SAUDE",
  "token": "123457"
}.to_json

@put_checkAccount2 = CheckAccount.put('/singleLogin/v1/checkAccount' , body: @checkAccount2, headers: @headers)
puts @put_checkAccount2.body

@checkAccount3 = {
  "userName": "99904098034",
  "personType": "PROFISSIONAL_SAUDE",
  "token": "123457"
}.to_json

@put_checkAccount3 = CheckAccount.put('/singleLogin/v1/checkAccount' , body: @checkAccount3, headers: @headers)
puts @put_checkAccount3.body
end

E('faço a chamada do resend token para recuperar o login') do
  @resend = {
    "userName": "99904098034",
    "personType": "PROFISSIONAL_SAUDE",
    "contactToSendToken": "EMAIL",
    "brand": "NAV",
    "templateName": "",
    "params": {}
  }.to_json

@post_resend = ResendToken.post('/sso/v1/login/token/resend' , body: @resend , headers: @headers)
puts @post_resend.body
end

Quando('insiro os dados corretamente') do
  @checkAccount4 = {
    "userName": "99904098034",
    "personType": "PROFISSIONAL_SAUDE",
    "token": "123456"
  }.to_json

@put_checkAccount4 = CheckAccount.put('/singleLogin/v1/checkAccount' , body: @checkAccount4, headers: @headers)
puts @put_checkAccount4.body
end

Então('eu valido as mensagens de retorno e que o login foi recuperado com sucesso') do
expect(@put_checkAccount1.code).to eql 406
expect(@put_checkAccount1.parsed_response['message']).to eql 'Token is not valid!, 1 unsuccessful attempts were made to verify the created login'
expect(@put_checkAccount1.parsed_response['error']).to eql 'NOT_ACCEPTABLE'
  
expect(@put_checkAccount2.code).to eql 406
expect(@put_checkAccount2.parsed_response['message']).to eql 'Token is not valid!, 2 unsuccessful attempts were made to verify the created login'
expect(@put_checkAccount2.parsed_response['error']).to eql 'NOT_ACCEPTABLE'
  
expect(@put_checkAccount3.code).to eql 403
expect(@put_checkAccount3.parsed_response['message']).to eql 'Token is expired!, 3 unsuccessful attempts were made to verify the created login'
expect(@put_checkAccount3.parsed_response['error']).to eql 'FORBIDDEN'
  
expect(@put_checkAccount4.code).to eql 200

end