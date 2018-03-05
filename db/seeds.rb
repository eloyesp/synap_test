# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  require 'csv'

  # events are time sensitive, so it makes sense to use time helpers here to
  # make sure that created_at and updated_at are correct

  require 'active_support/testing/time_helpers'

  include ActiveSupport::Testing::TimeHelpers

  participants_csv = Rails.root.join("participants.csv")
  weighins_csv = Rails.root.join("weighins.csv")

  events = Hash.new do |hash, name|
    print 'e'
    hash[name] = Event.find_or_create_by! name: name do |e|
      e.tagline = name
    end
  end

  people = Hash.new do |hash, name|
    print 'p'
    hash[name] = Person.find_or_create_by! name: name
  end

  leagues = Hash.new do |hash, name|
    print 'l'
    hash[name] = League.find_or_create_by! name: name
  end

  puts 'Importing checkins'

  CSV.table(weighins_csv).each do |row|
    # Name,Weight,Event,Time
    # Abigail Anderson,100,Thankgiving 2000,2000-11-30T00:25:57-06:00
    travel_to row[:time].to_date do
      event = events[row[:event]]
      person = people[row[:name]]
      CreateCheckin.call(person, event, row[:weight].to_f, nil)
      print '·'
    end
  end

  CSV.table(participants_csv).each do |row|
    # Name,Event,League,Date
    # Lenny Anderson,Thankgiving 2000,Anderson Family Championship,2000-11-30
    travel_to row[:date].to_date do
      person = people[row[:name]]
      league = leagues[row[:league]]
      person.leagues << league
      print '·'
    end
  end

  puts
end
