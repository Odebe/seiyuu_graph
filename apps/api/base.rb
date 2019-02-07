# frozen_string_literal: true

module API
  class Base < Sinatra::Base
    before do
      content_type 'application/json'
    end
  end
end
