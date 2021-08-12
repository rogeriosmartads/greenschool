class AlteracoesTurma2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :team
  end
end
