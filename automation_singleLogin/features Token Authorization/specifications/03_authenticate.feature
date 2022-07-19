#language: pt
@post
Funcionalidade: Authenticate

    - Eu, como SSO
    - Desejo fazer a autenticação do login criado
    - Para seguir com o processo de automação
#before - antes (gera token)

Cenario: Realizar a autenticação
    Dado que eu crie um novo login de uma persona com sucesso 
    Quando eu faço o checkAccount e gero o token
    E realizo a autenticação
    Então eu valido que o sistema autentica o login criado

#after - depois (deletar o login)