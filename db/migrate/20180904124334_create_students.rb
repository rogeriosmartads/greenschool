class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :code
      t.string :datebirthday
      t.string :idfb

      t.timestamps
    end
  end
end
