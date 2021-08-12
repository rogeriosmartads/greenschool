class Team < ApplicationRecord
   require 'csv'
    
   enum status: [ :Sim, :Nao ] 
   enum pesqstatus: [ :'ok', :'nok' ]
   enum kind: [ :NORMAL, :CONTRATURNO,:PROGRES_PARCIAL ]  
   enum year: [ :'2011', :'2012',:'2013',:'2014',:'2015',:'2016',:'2017',:'2018',:'2019',:'2020',:'2021',:'2022']  
   validates :status, :kind, :year, :idfb, :description, presence: true

 def self.import(file,tyear)
    CSV.foreach(file.path, headers: true, encoding: 'iso-8859-1:utf-8', col_sep: ';').with_index do |linha, indice|
     unless (indice == 0)
			if Team.where(idfb: linha[1]).exists?
			   team = Team.where(idfb: linha[1],year:tyear)
			   @team= Team.find(team[0].id)
				#@team.update!(description: linha[0], idfb: linha[1], kind: linha[2], status: linha[3], year:getindiceenumyear(tyear))
				@team.update!(description: linha[0], idfb: linha[1], kind: linha[2], status: linha[3], year:tyear)
			else
				#Team.create!(description: linha[0], idfb: linha[1], kind: linha[2], status: linha[3], year:getindiceenumyear(tyear))
				Team.create!(description: linha[0], idfb: linha[1], kind: linha[2], status: linha[3], year:tyear,pesqstatus:1)
			end
     end
    end
 end 
 
def self.getindiceenumyear(pyear)
 count=0
 years=[ :'2011', :'2012',:'2013',:'2014',:'2015',:'2016',:'2017',:'2018',:'2019',:'2020',:'2021',:'2022'] 
 years.each do |yea|
  if pyear.to_s==yea.to_s
   break
  end 
   count=count+1 
 end
 count
end    
 
 
end
