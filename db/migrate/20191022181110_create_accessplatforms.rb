class CreateAccessplatforms < ActiveRecord::Migration[5.2]
  def change
    create_table :accessplatforms do |t|
      t.integer :accessok
      t.integer :accesserror
      t.date :pdate
      t.string :reason

      t.timestamps
    end
  end
end
