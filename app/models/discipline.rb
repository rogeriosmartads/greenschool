class Discipline < ApplicationRecord
   require 'csv' 
   enum status: [ :Sim, :Nao ]  
   
 def self.import(file)
    CSV.foreach(file.path, headers: true, encoding: 'iso-8859-1:utf-8', col_sep: ';').with_index do |linha, indice|
     unless (indice == 0)
			if Discipline.where(idfb: linha[0]).exists?
			   discipline = Discipline.where(idfb: linha[0])
			   @discipline= Discipline.find(discipline[0].id)
				@discipline.update!(idfb: linha[0],description: linha[1], status: linha[2], indice: linha[3], abrev: linha[4])
			else
				Discipline.create!(idfb: linha[0],description: linha[1], status: linha[2], indice: linha[3], abrev: linha[4])
			end
     end
    end
 end    
   


  def deliver
    puts "6666666666666666666666666666666666666"  
    sleep 10 # simulate long newsletter delivery
    puts "666666666666666666666666666666666666"
    sleep 100 # simulate long newsletter delivery
    puts "77777777777777777777777777777777777777"    
    #State.delay(queue: "estado2", priority: 0, run_at: 5.minutes.from_now).deliver(params[:id])
  end  

   
end
