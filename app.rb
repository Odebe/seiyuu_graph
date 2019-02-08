# frozen_string_literal: true

require 'sinatra/base'

require 'rom'
require 'rom-sql'
require 'sqlite3'

require_relative './db/db.rb'

require_relative './apps/api.rb'

require 'dotenv'
Dotenv.load

Dir['./services/**/*.rb'].each { |file| require_relative file }

class App < Sinatra::Base
  get '/' do
    'main page, ok'
  end

  use API::App
end
