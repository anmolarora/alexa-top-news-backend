# frozen_string_literal: true

class AlexaSkillHeadlinesController < ApplicationController
  def top_headlines
    render json: BreakingNewsFetcher.call
  end
end
