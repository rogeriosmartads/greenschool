class CreateStatusapps < ActiveRecord::Migration[6.0]
  def change
    create_table :statusapps do |t|
      t.string :name

      t.timestamps
    end
  end
end
