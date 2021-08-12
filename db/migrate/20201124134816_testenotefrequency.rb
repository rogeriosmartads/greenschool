class Testenotefrequency < ActiveRecord::Migration[6.0]
  def change
    add_column :notefrequencies, :year,:integer 
  end
end
