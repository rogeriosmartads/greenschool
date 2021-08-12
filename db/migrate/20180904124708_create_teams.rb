class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :description
      t.integer :year
      t.string :idfb

      t.timestamps
    end
  end
end
