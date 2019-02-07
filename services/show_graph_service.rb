# frozen_string_literal: true

class ShowGraphService
  def initialize(params)
    @id = params.fetch('id')
  end

  def call
    { id: @id, status: 'complete', data: [], completed_at: Time.now }.to_json
  end
end
