class AlteracoesNoteFrequency1 < ActiveRecord::Migration[5.2]
  def change
    add_column :notefrequencies, :f1bnota,:string    
    add_column :notefrequencies, :f1brec,:string   
    add_column :notefrequencies, :f1bfreq,:string      
    add_column :notefrequencies, :f2bnota,:string    
    add_column :notefrequencies, :f2brec,:string   
    add_column :notefrequencies, :f2bfreq,:string
    add_column :notefrequencies, :f3bnota,:string    
    add_column :notefrequencies, :f3brec,:string   
    add_column :notefrequencies, :f3bfreq,:string
    add_column :notefrequencies, :f4bnota,:string    
    add_column :notefrequencies, :f4brec,:string   
    add_column :notefrequencies, :f4bfreq,:string      
    add_column :notefrequencies, :media,:string    
    add_column :notefrequencies, :recfinal,:string   
    add_column :notefrequencies, :resultado,:string 
    add_column :notefrequencies, :concfinal,:string    
    add_column :notefrequencies, :totfreq,:string   
    add_reference :notefrequencies, :team
  end
end

