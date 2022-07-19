#language: pt
@post
Funcionalidade: Resend Token

    - Eu, como SSO
    - Desejo fazer o reenvio de token
    - Para cobrir todos os processos de automação

Cenario: Gerar o token de reset de senha para recuperar o login
    Dado que eu crie um login para reenvio de token
    E erro três vezes o token enviado para expirar
    E faço a chamada do resend token para recuperar o login
    E insiro os dados corretamente
    Então eu valido as mensagens de retorno e que o login foi recuperado com sucesso
