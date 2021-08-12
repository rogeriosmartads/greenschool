class AlteracoesTurma < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :kind,:integer
    add_column :teams, :status,:integer     
  end
end
