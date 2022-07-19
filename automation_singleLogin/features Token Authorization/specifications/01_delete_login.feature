#language: pt
@post
Funcionalidade: Delete

    - Eu, como SSO
    - Desejo deletar login criado
    - Para seguir com o processo de automação


Cenario: Deletar logins criados em cenários anteriores
    Dado que eu tenha logins criados em cenários anteriores
    Então todos logins foram deletados