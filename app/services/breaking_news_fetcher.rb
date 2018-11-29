# frozen_string_literal: true

class BreakingNewsFetcher
  include Service
  include HTTParty

  base_uri 'newsapi.org'

  # 'in' for India
  DEFAULT_COUNTRY = 'in'

  def initialize(country)
    country ||= DEFAULT_COUNTRY
    @options = { query: { country: country,
                          apiKey: ENV['NEWAPI_ORG_API_KEY'] } }
  end

  def call
    top_headlines
  end

  private

  def top_headlines
    response = self.class.get('/v2/top-headlines', @options)
    format_response_for_skill(response.parsed_response)
  end

  # Format response for Alexa skill
  def format_response_for_skill(raw_response)
    articles = raw_response.fetch('articles', [])
    formatted_articles = []
    articles.each do |article|
      formatted_articles << format_article(article)
    end
    formatted_articles
  end

  def format_article(raw_article)
    {
      uid: SecureRandom.uuid,
      updateDate: raw_article.fetch('publishedAt'),
      titleText: raw_article.fetch('title'),
      mainText: raw_article.fetch('title'),
      redirectionUrl: raw_article.fetch('url')
    }
  end
end
