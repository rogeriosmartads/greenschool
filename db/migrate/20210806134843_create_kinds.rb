class CreateKinds < ActiveRecord::Migration[6.1]
  def change
    create_table :kinds do |t|
      t.string :name
      t.integer :code
      t.integer :status

      t.timestamps
    end
  end
end
