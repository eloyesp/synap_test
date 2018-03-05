class LeaguesController < ApplicationController
  def index
    @leagues = League.all
  end

  def show
    @league = League.find params[:id]
    @event = Event.last
  end
end
