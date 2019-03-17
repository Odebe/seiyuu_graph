class SaveGraphRequestService
  LINK_REGEX = %r{myanimelist.net\/anime\/\d+\/\w+\z}

  def initialize(params)
    @params = params
  end

  def call
    prepare_links!
    validate_links!
    ActiveRecord::Base.transaction do
      graph_request.save!
      title_requests.each { |tr| tr.graph_request = graph_request }.each(&:save!)
    end
    
    Dry::Monads.Success(graph_request)
  rescue => error
    Rails.logger.error "error: #{error.message}, backtrace: #{error.backtrace}"
    Dry::Monads.Failure(error)
  end

  private

  def graph_request
    @_graph_request ||= GraphRequest.new
  end

  def title_requests
    @title_requests ||= links.map { |link| TitleRequest.new(mal_id: nil, href: link) }
  end

  def validate_links!
    # TODO: more complex validation
    raise 'invalid links' unless links.all? do |link|
      URI::DEFAULT_PARSER.make_regexp.match(link) && LINK_REGEX.match(link)
    end
  end

  def prepare_links!
    @_links = links.split("\n").map(&:strip)
  end

  def links
    @_links ||= @params[:graph_request][:links]
  end
end
