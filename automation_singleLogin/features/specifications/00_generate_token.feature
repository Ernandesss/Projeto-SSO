#language: pt
@post
Funcionalidade: Generate Token

    - Eu, como SSO
    - Desejo gerar  Bearer Token
    - Para seguir com o processo de automação


Cenario: Gerar token JWT para autorizar os demais serviços
    Dado que eu gere um bearer token
    Então os demais serviços podem consumir