class AlteracoesRegistrations1 < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :status,:integer 
    add_column :registrations, :kind,:integer     
  end
end
