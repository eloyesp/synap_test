class CreateJoinTableLeaguePerson < ActiveRecord::Migration
  def change
    create_join_table :leagues, :people do |t|
      # t.index [:league_id, :person_id]
      # t.index [:person_id, :league_id]
    end
  end
end
