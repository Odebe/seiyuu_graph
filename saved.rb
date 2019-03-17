module MyAnimeList
  class FetchOneTitleInfo
    def initialize(id)
      @id = id
    end

    def call
      puts "Processing title with id=#{@id}"

      title_info = process_request { MalParser::Entry::Anime.call(@id) }

      puts 'sleeping'
      sleep 3

      puts 'gettings characters first'

      short_stuff_info = process_request { MalParser::Entry::Characters.new(@id, :anime).call }
      title_info.merge(characters: get_characters(short_stuff_info[:characters]))

      # process_request do
      #   @title_info ||= MalParser::Entry::Anime.call(@id)
      #   puts "sleeping"
      #   sleep 1
      #   puts 'gettings characters first'
      #   @characters_ids ||= MalParser::Entry::Characters.new(@id, :anime).call
      #   @title_info.merge(characters: get_characters)
      # end
    end

    private

    def get_characters(chars)
      chars.map do |c|
        puts "Porcessing char with id=#{c[:id]}"
        char_info = process_request { MalParser::Entry::Character.call(c[:id]) }
        char_info[:seyu] = get_seiyuus(char_info[:seyu])
        char_info
      end
    end

    def get_seiyuus(seiyuus)
      seiyuus.map do |s|
        puts "processing seiyuu with id=#{s[:id]}"
        process_request { MalParser::Entry::Person.call(s[:id]) }
      end
    end

    def process_request
      sleep 1
      yield
    rescue Net::OpenTimeout => exception
      t = rand(5..10)
      puts "error: #{exception}, reconnection after #{t} seconds"
      sleep t
      retry
    end
  end
end


module MyAnimeList
  class FetchTitlesInfo

    LINK_REGEX = %r{myanimelist.net\/anime\/(\d+)\/}

    def initialize(links)
      @title_ids = fetch_ids(links)
    end

    # https://myanimelist.net/anime/240/Genshiken
    # r = MyAnimeList::FetchTitlesInfo.new(['https://myanimelist.net/anime/240/Genshiken']).call
    # r = MyAnimeList::FetchTitlesInfo.new(['https://myanimelist.net/anime/66/Azumanga_Daioh']).call
    def call
      start = Time.now
      res = @title_ids.map do |title_id|
        MyAnimeList::FetchOneTitleInfo.new(title_id).call
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
