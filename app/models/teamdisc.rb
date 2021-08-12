class Teamdisc < ApplicationRecord
  require 'csv' 
  belongs_to :team
  belongs_to :discipline
  
 def self.import(file)
    CSV.foreach(file.path, headers: true, encoding: 'iso-8859-1:utf-8', col_sep: ';').with_index do |linha, indice|
     unless (indice == 0)
      team = Team.where(idfb: linha[0])
      disc = Discipline.where(idfb: linha[1])
      if team.exists?
        # se turma existe
        if disc.exists? 
         # se disc existe
          if Teamdisc.where(team_id: team[0].id,discipline_id: disc[0].id,indice: linha[2]).exists?          
			     @teamdisc = Teamdisc.where(team_id: linha[0],discipline_id: linha[1])
			     #@teamdisc= Teamdisc.find(teamdisc[0],teamdisc[1])
			     #puts @teamdisc[0]
			     #puts @teamdisc[1]
			     if @teamdisc[0]!=nil 
			      @teamdisc[0].update!(team_id: team[0].id,discipline_id: disc[0].id,indice: linha[2]) 
			     end
          else
           # se turmadisc não existe
           Teamdisc.create!(team_id: team[0].id,discipline_id: disc[0].id, indice: linha[2]) 			     
          end  
        end 
      end 
     end
    end
 end  
 
  

  
end
