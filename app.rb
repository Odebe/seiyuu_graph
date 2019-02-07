# frozen_string_literal: true

require 'sinatra/base'
require_relative './apps/api.rb'

Dir['./services/**/*.rb'].each { |file| require_relative file }

class App < Sinatra::Base
  get '/' do
    'main page, ok'
  end

  use API::App
end
