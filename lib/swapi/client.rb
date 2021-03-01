require 'net/http'

module Swapi
  class Client
    def initialize(url)
      @url = URI.parse(fix_url(url))
    end

    attr_reader :url

    def fetch
      response = Net::HTTP.get(@url)
      JSON.parse(response)
    end

    private

    def fix_url(url)
      return url.gsub('http', 'https') if !url.starts_with?('https') && url.starts_with?('http')

      url
    end
  end
end