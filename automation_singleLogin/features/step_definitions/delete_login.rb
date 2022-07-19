Dado('que eu tenha logins criados em cenários anteriores') do
  @username = "41544635001"
  @personType = "PROFISSIONAL_SAUDE"
  @deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}")
  puts @deleteLogin.body
  
  @username = "33434007008"
  @personType = "PROFISSIONAL_SAUDE"
  @deleteLogin2 = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}")
  puts @deleteLogin2.body
  
  @username = "99904098034"
  @personType = "PROFISSIONAL_SAUDE"
  @deleteLogin = DeleteLogin.delete("/sso/v1/login/deleteLoginByUsernameAndPersonType/#{@username}/#{@personType}")
  puts @deleteLogin.body
  end
    
  Então('todos logins foram deletados') do
  
  end