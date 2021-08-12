class CreateDisciplines < ActiveRecord::Migration[5.2]
  def change
    create_table :disciplines do |t|
      t.string :description
      t.string :idfb

      t.timestamps
    end
  end
end
