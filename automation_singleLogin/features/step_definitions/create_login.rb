Dado('que eu crie um login de uma persona com sucesso') do
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


@bodyV3 = {
  userName: "33434007008",
  password: "Teste*123",
  personType: "PROFISSIONAL_SAUDE",
  contact: {
  id: 1261781
},
person: {
   id: 4159982,
   name: "SSO Hml Prof",
   cpf: "33434007008"
},
contactToSendToken: "EMAIL",
brand: "NAV",
platform: "NAV_PRO"
}.to_json

@post_createLoginV3 = CreateLogin.post('/singleLogin/v3/createLogin' , body: @bodyV3)
puts @post_createLoginV3.body
end


Quando('eu faço o checkAccount') do
  @checkAccount = {
    "userName": "41544635001",
    "personType": "PROFISSIONAL_SAUDE",
    "token": "123456"
  }.to_json

@put_checkAccount = CheckAccount.put('/singleLogin/v1/checkAccount' , body: @checkAccount)
puts @put_checkAccount.body

end

Quando('eu crio um novo login com mesmo ID MDM e username diferente') do
  @body2 = {
    userName: "06034337070",
    password: "Teste*123",
    personType: "PROFISSIONAL_SAUDE",
      contact: {
      email: "dasa.nav1x@gmail.com"
    },
      person: {
      id: 4142737,
      name: "Cecília Espinheira Teste MDM",
      cpf: "07509099609"
    },
    contactToSendToken: "EMAIL",
    brand: "NAV",
    platform: "NAV_PRO"
  }.to_json

@post_createLogin = CreateLogin.post('/singleLogin/v2/createLogin' , body: @body2)
puts @post_createLogin.body


@bodyV3y = {
  userName: "33434007008",
  password: "Teste*123",
  personType: "PROFISSIONAL_SAUDE",
  contact: {
  id: 1261781
},
person: {
   id: 4159982,
   name: "SSO Hml Prof",
   cpf: "33434007008"
},
contactToSendToken: "MOBILE",
brand: "NAV",
platform: "NAV_PRO"
}.to_json

@post_createLoginV3 = CreateLogin.post('/singleLogin/v3/createLogin' , body: @bodyV3y)
puts @post_createLoginV3.body
end


Então('o sistema Não permite e exibe erro tratado') do
  if "#{ENV["AMBIENTE"]}"=="homol"
    expect(@post_createLogin.code).to eql 404
    expect(@post_createLogin.parsed_response['message']).to eql ' Health care Practitioner not found in MDM - cpf: 06034337070'
    expect(@post_createLogin.parsed_response['error']).to eql 'NOT_FOUND'

    expect(@post_createLoginV3.code).to eql 422
    expect(@post_createLoginV3.parsed_response['message']).to eql 'Unsaved login data Contact to send token is: MOBILE. But contact mobile is missing for this account!'
    expect(@post_createLoginV3.parsed_response['error']).to eql 'UNPROCESSABLE_ENTITY'
  end #end do if
end #end do teste

Quando('eu deletar o login') do
  @username = "41544635001"
  @personType = "PROFISSIONAL_SAUDE"
  @deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}")
  puts @deleteLogin.body


  @username = "33434007008"
  @personType = "PROFISSIONAL_SAUDE"
  @deleteLogin2 = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}")
  puts @deleteLogin2.body
end


#cucumber feature/specifications/create_login/02_delete_login.feature
Então('eu valido que o login foi deletado') do
expect(@deleteLogin.code).to eql 200
end