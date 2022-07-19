Dado('que eu tenha um novo login para o keycloak') do

  end
   
  E('eu realizo a autenticação do keycloak') do
    @auth = {
        "client_id": "paciente",
        "client_secret": "abc24cd6-a919-432b-915a-da04d57788c6",
        "grant_type": "password",
        "username": "21644215829",
        "password": "Teste@123"
    }.to_json

@post_auth = Auth.post('/singleLogin/v2/auth' , body: @auth)
puts @post_auth.body



  @auth2 = {
    "client_id": "profissional-saude",
    "client_secret": "34f01a7a-b4f7-4bb2-a586-5e42b27f3792",
    "grant_type": "password",
    "username": "10113542259",
    "password": "Teste@123"
}.to_json

@post_auth2 = Auth.post('/singleLogin/v2/auth' , body: @auth2)
puts @post_auth2.body

end

  Então('eu valido que o sistema retorna o token do keycloak') do
  expect(@post_auth.code).to eql 200
  expect(@post_auth2.code).to eql 200
  end