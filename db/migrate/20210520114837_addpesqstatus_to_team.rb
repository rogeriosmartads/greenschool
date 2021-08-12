class AddpesqstatusToTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :pesqstatus,:integer
  end
end
