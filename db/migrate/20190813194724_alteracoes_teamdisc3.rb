class AlteracoesTeamdisc3 < ActiveRecord::Migration[5.2]
  def change
    add_column :teamdiscs, :indice,:integer
  end
end
