module GenerateToken
  include HTTParty
  base_uri "https://id-hml.dasa.com.br/auth/realms/Funcionarios/protocol/openid-connect"
  format :json
  default_options.update(verify: false)
  headers 'Content-Type': "application/x-www-form-urlencoded",
          'Tests':  "var jsonData = pm.response.json();",
          'Tests':  "pm.globals.set(Bearer 'access_token', jsonData.access_token);"
end