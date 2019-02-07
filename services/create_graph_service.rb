# frozen_string_literal: true

class CreateGraphService
  def call
    id = rand(10)
    { id: id, status: 'processing', link: "http://localhost:9292/graph/#{id}" }.to_json
  end
end
