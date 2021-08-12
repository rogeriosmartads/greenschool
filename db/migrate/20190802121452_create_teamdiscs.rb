class CreateTeamdiscs < ActiveRecord::Migration[5.2]
  def change
    create_table :teamdiscs do |t|
      t.references :team, foreign_key: true
      t.references :discipline, foreign_key: true
      t.string :idfb

      t.timestamps
    end
  end
end
