# frozen_string_literal: true

module API
  class GraphApp < API::Base
    get '/graph/:id' do
      ShowGraphService.new(params).call
    end

    post '/graph/' do
      CreateGraphService.new.call
    end
  end
end
