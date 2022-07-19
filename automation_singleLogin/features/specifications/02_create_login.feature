#language: pt
@post
Funcionalidade: Create Login

    - Eu, como SSO
    - Desejo Não permitir criar mais de um login por persona
    - Para Não cadastrar username diferente para o mesmo person_ID (ID MDM) e person_type.


Cenario: Não deixar criar mais de um login por persona
    Dado que eu crie um login de uma persona com sucesso 
    Quando eu faço o checkAccount
    E eu crio um novo login com mesmo ID MDM e username diferente
    Então o sistema Não permite e exibe erro tratado
    Quando eu deletar o login
    Então eu valido que o login foi deletado
    
