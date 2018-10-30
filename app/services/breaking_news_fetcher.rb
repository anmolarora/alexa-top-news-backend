# frozen_string_literal: true

class BreakingNewsFetcher
  include Service
  include HTTParty

  base_uri 'newsapi.org'

  # 'in' for India
  DEFAULT_COUNTRY = 'in'

  def initialize
    @options = { query: { country: DEFAULT_COUNTRY,
                 apiKey: ENV['NEWAPI_ORG_API_KEY'] } }
  end

  def call
    top_headlines
  end

  private

  def top_headlines
    self.class.get('/v2/top-headlines', @options)
  end
end
