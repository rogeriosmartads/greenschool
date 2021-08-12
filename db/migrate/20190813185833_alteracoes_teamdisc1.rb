class AlteracoesTeamdisc1 < ActiveRecord::Migration[5.2]
  def change
    remove_column :teamdiscs, :idfb
    add_column :teamdiscs, :idfbturma,:string
    add_column :teamdiscs, :idfbdisc,:string     
  end
end
