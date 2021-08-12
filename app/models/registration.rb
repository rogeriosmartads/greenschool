class Registration < ApplicationRecord

   require 'csv'
    
   enum status: [ :'M', :'(TF)',:'(TC/TF)',:'(Aband)' ]  
   enum kind: [ :NORMAL, :CONTRATURNO ]  
   enum year: [ :'2011', :'2012',:'2013',:'2014',:'2015',:'2016',:'2017',:'2018',:'2019',:'2020',:'2021',:'2022']    
  
  belongs_to :student
  belongs_to :team
  

 #ID;IDTURMA;IDALUNO;TIPOTURMA;STATUS;ANO 
 def self.import(file,tyear)
    CSV.foreach(file.path, headers: true, encoding: 'iso-8859-1:utf-8', col_sep: ';').with_index do |linha, indice|
     unless (indice == 0)
      team = Team.where(idfb: linha[1])
      student = Student.where(idfb: linha[2])
      if team.exists?
        # se turma existe
        if student.exists? 
         # se student existe
          if Registration.where(team_id: team[0].id,student_id: student[0].id,kind: linha[3],
			                            status:linha[4],year:tyear).exists?          
			     registration = Registration.where(idfb:linha[0],team_id: team[0].id,student_id: student[0].id,kind: linha[3],
                                           status:linha[4],year:tyear)
			     @registration= Registration.find(registration[0].id)
			     #puts @registration[0]
			     #puts @registration[1]
			     @registration.update!(idfb:linha[0],team_id: team[0].id,student_id: student[0].id,kind: linha[3],
                                           status:linha[4],year:tyear)        
          else
           # se turmadisc não existe
           puts linha[0]
           puts team[0].id
           puts student[0].id
           Registration.create!(idfb:linha[0],team_id: team[0].id,student_id: student[0].id,kind: linha[3],
                                status:linha[4],year:tyear) 			     
          end  
        end 
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
