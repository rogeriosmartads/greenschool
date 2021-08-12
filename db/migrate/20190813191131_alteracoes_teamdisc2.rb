class AlteracoesTeamdisc2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :teamdiscs, :idfbdisc
    remove_column :teamdiscs, :idfbturma
  end
end
