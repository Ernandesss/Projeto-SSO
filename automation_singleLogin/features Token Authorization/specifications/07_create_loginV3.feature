#language: pt
@post
Funcionalidade: Create Login V3

    - Eu, como SSO
    - Desejo validar que a nova versão do create login não exibe os dados de contato


Cenario: Validar que a nova versão do create login
    Dado que eu crie um login na nova versão
    Quando eu faço o checkAccount do login na nova versão
    Então eu valido que o login foi criado com sucesso na V3