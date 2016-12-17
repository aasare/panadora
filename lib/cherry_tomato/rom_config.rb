module CherryTomato
  class ROMConfig
    attr_reader :container

    def initialize
      rom_config = ROM::Configuration.new(:sql, load_db_settings)
      @container = ROM.container(rom_config)
    end

    def repository(repository_name)
      repository_name.new(@container)
    end

    private

    def load_db_settings
      if ENV['RACK_ENV'] == 'production'
        ENV['DATABASE_URL']
      else
        user = ENV['DB_USER']
        password = ENV['DB_PASSWORD']
        host = ENV['DB_HOST']
        dbname = ENV['DB_DATABASE']

        "postgres://#{host}/#{dbname}?user=#{user}&password=#{password}"
      end
    end
  end
end
