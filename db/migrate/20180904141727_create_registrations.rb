class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.references :student, foreign_key: true
      t.references :team, foreign_key: true
      t.integer :year
      t.string :idfb

      t.timestamps
    end
  end
end
