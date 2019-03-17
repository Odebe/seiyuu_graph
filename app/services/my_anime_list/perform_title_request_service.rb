module MyAnimeList
  class PerformTitleRequestService
    def initialize(mal_id)
      @mal_id = mal_id
    end

    def call
      puts "Processing title with mal_id=#{@mal_id}"

      title_info = process_request { MalParser::Entry::Anime.call(@mal_id) }

      puts 'sleeping'
      sleep 3

      puts 'gettings characters first'

      short_stuff_info = process_request { MalParser::Entry::Characters.new(@mal_id, :anime).call }
      title_info.merge(characters: get_characters(short_stuff_info[:characters]))
    end

    private

    def get_characters(chars)
      chars.map do |c|
        puts "Porcessing char with d=#{c[:id]}"
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
      t = rand(5..7)
      puts "error: #{exception}, reconnection after #{t} seconds"
      sleep t
      retry
    end
  end
end