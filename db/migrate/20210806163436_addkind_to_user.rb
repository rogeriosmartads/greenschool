class AddkindToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :kind
    remove_column :kinds, :code
  end
end
