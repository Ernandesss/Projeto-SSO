#language: pt
@post
Funcionalidade: Change Password

    - Eu, como SSO
    - Desejo fazer o reset de senha
    - Para cobrir todos os processos de automação

Cenario: Gerar o token de reset de senha e trocar a senha
    Dado que eu crie um login para reset de senha
    E faço o checkAccount para reset de senha
    E gero token de reset de senha
    E erro três vezes para expirar o token
    E valido mensagem de token expirado
    E gero novamente o token e insiro corretamente os dados
    Quando faço o reset de senha
    Então valido que o sistema retorna sucesso
