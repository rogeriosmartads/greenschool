class Student < ApplicationRecord
  require 'csv' 

   enum status: [ :'Sim', :'Não', :'Nao' ]  
   
   
ransacker :created_at do
  Arel.sql('date(created_at)')
end   
   
   
   
   
 def self.import(file)
    CSV.foreach(file.path, headers: true, encoding: 'iso-8859-1:utf-8', col_sep: ';').with_index do |linha, indice|
     unless (indice == 0)
			if Student.where(idfb: linha[0]).exists?
			   student = Student.where(idfb: linha[0])
			   @student= Student.find(student[0].id)
				@student.update!(idfb: linha[0],code: linha[1], name: linha[2], datebirthday: linha[3], status: linha[4])
			else
				Student.create!(idfb: linha[0],code: linha[1], name: linha[2], datebirthday: linha[3], status: linha[4])
			end
     end
    end
 end    
  
end
