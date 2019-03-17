class GraphRequestController < ApplicationController
  def index
    @graph_requests = GraphRequest.all
  end

  def show
    @graph_request = GraphRequest.find(params[:id])
    @title_requests = @graph_request.title_requests
  end

  def create
    result = SaveGraphRequestService.new(params).call
    if result.success?
      redirect_to result.value!
    else
      redirect_to root_path, flash: { error: result.failure.to_s }
    end
  end
end
