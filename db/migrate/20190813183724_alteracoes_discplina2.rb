class AlteracoesDiscplina2 < ActiveRecord::Migration[5.2]
  def change
    add_column :disciplines, :status,:integer
  end
end
