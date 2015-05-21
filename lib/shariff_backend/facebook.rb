require 'httpclient'
require 'json'

module ShariffBackend
  # Retrieves Facebook Share Count via Graph API
  module Facebook
    def self.count(url)
      query_url = 'https://api.facebook.com/method/links.getStats?urls=' \
                  "\"#{url}\"&format=json"
      encoded = URI.escape(query_url)
      response = HTTPClient.new.get(encoded)
      parse(response) if response.ok?
    end

    def self.parse(response)
      json = JSON.parse(response.body)
      json.first['share_count'] if json.is_a?(Array)
    end
  end
end
