class AlteracoesTurma1 < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :team,:string
  end
end
