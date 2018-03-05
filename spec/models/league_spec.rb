require 'spec_helper'

describe League do
  describe "people.on_event" do
    let(:league) { FactoryBot.create :league }
    let(:event) { FactoryBot.create :event }

    it "list league people that checked in the given event" do
      checked_in = FactoryBot.create :person, leagues: [league]
      CreateCheckin.call checked_in, event, 110, nil
      not_checked_in = FactoryBot.create :person, leagues: [league]
      not_on_league = FactoryBot.create :person
      CreateCheckin.call checked_in, event, 110, nil

      people = league.people.on_event(event)
      expect(people).to include(checked_in)
      expect(people).not_to include(not_checked_in)
      expect(people).not_to include(not_on_league)
    end
  end
end
