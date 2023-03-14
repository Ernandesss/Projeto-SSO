# Dado('que eu gere um bearer token') do
#     @body = {
#         client_id: "singlelogin",
#         grant_type: "client_credentials",
#         client_secret: "77f3092d-8fe6-4241-a01b-a5dda39f068e"
#       }
      
#       @gerar_token = GenerateToken.post('/token', body: @body)
#       puts @gerar_token.parsed_response['access_token']
      
      
#       @headers = {
#         'Content-Type': "application/json",
#         'user': "singlelogin-plugin",
#         'Authorization': "Bearer #{@gerar_token.parsed_response['access_token']}"

#       } 
#   end
  
#   Então('os demais serviços podem consumir') do
#     expect(@gerar_token.code).to eql 200

#   end