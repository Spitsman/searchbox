class AnalyticsController < ApplicationController

  def index
    puts params[:text]
    Analyzer.add(request.ip, params[:text])
  end

  def destroy
    Analyzer.destroy_all
  end

end
