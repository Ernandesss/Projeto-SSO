# Chamando todas as dependencias do projeto
require 'cucumber'
require "faker"
require "rspec"
require "httparty"
require "httparty/request"
require "httparty/response/headers"
require "json"

# esta lendo o arquivo yml dentro de support/config/
# ai vai depender do de como esta configurado o ambiente no cucumber.yml
CONFIG = YAML.load_file(File.dirname(__FILE__) + "/config/#{ENV["AMBIENTE"]}.yml")

# esta lendo todos os arquivos que teminem com _services na pasta service
# require_relative '../services/create_login_services.rb'
Dir[File.join(File.dirname(__FILE__),
    '../services/*_services.rb')].each { |file| require_relative file }