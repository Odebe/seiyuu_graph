# frozen_string_literal: true

require_relative './api/base.rb'
require_relative './api/graph_app.rb'

require_relative '../db/db.rb'

module API
  class App < Sinatra::Base
    configure do
      DB.setup
    end

    use API::GraphApp
  end
end
