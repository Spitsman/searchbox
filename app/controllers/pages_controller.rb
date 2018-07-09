class PagesController < ApplicationController

  def index
  end

  def analytics
    @analytics = Analyzer.get_analytics
  end

end
