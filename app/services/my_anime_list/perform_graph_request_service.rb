module MyAnimeList
  class PerformGraphRequestService

    LINK_REGEX = %r{myanimelist.net\/anime\/(\d+)\/}

    def initialize(links)
      @title_ids = fetch_ids(links)
      @raw_titles = []
    end

    # https://myanimelist.net/anime/240/Genshiken
    # r = MyAnimeList::PerformGraphRequestService.new(['https://myanimelist.net/anime/240/Genshiken']).call
    # r = MyAnimeList::PerformGraphRequestService.new(['https://myanimelist.net/anime/66/Azumanga_Daioh']).call
    def call
      start = Time.now
      res = @title_ids.each_with_object([]) do |title_id, result|
        raw_title = MyAnimeList::PerformTitleRequestService.new(title_id).call
        @raw_titles << raw_title
        RawTitle.new(href: nil, mal_id: title_id, body: raw_title).save
      end
      puts "Started at: #{start}, all time: #{(Time.now - start)/ 60.0} mins"
      res
    end

    private

    def get_title_info(id)

    end

    # 66 from https://myanimelist.net/anime/66/Azumanga_Daioh
    def fetch_ids(links)
      # TODO: rescue invalid links
      links.map { |l| l.scan(LINK_REGEX)[0][0] }
    end
  end
end

