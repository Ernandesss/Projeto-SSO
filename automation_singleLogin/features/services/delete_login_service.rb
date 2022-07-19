module DeleteLogin
    include HTTParty
    base_uri CONFIG["base_uri"]
    format :json
    default_options.update(verify: false)

end