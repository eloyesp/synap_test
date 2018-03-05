class LeaguesController < ApplicationController
  def index
    event = Event.last
    @leagues = event.leagues
  end

  def show
    @league = League.find params[:id]
    @event = Event.last
  end
end
