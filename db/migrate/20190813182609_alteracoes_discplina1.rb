class AlteracoesDiscplina1 < ActiveRecord::Migration[5.2]
  def change
    add_column :disciplines, :abrev,:string
    add_column :disciplines, :indice,:integer     
  end
end
