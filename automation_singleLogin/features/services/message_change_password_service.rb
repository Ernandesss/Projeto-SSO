module MessageChangePassword
    include HTTParty
    base_uri CONFIG["base_uri"]
    format :json
    default_options.update(verify: false)
    headers 'Content-Type': "application/json",
            'user': "singlelogin-plugin",
            'Known-Token': "0"
            #'Authorization': "Bearer 'access_token'"
  end
  