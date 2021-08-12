class Addindiceregistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :indice,:integer 
  end
end
