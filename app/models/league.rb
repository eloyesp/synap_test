class League < ActiveRecord::Base
  has_and_belongs_to_many :people do
    def on_event event
      includes(:checkins).where(checkins: { event: event })
    end
  end
end
