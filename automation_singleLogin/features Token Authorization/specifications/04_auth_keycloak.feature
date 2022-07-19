#language: pt
@post
Funcionalidade: Auth Keycloak

    - Eu, como SSO
    - Desejo fazer a autenticação do keycloak
    - Para seguir com o processo de automação

Cenario: Gerar o token do Keycloak
    Dado que eu tenha um novo login para o keycloak
    E eu realizo a autenticação do keycloak
    Então eu valido que o sistema retorna o token do keycloak
