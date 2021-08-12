class Arquivo < ApplicationRecord
require 'csv' 	

	def self.upload_arquivo(arquivo, diretorio)
	  FileUtils.mkdir(diretorio) unless File.exists?(diretorio)
	  arquivo.each do |arquiv|
	  	File.open(File.join(diretorio, arquiv.original_filename), "wb") { |f| f.write(arquiv.read) }
	  puts 'antes chamada'
	  import(diretorio+'/'+arquiv.original_filename,arquiv.original_filename)
	  puts 'depois chamada'	
	  remover_arquivos
	  puts 'depois remover'
	  end

	end

	def self.download_arquivo(diretorio)
		Zip::File.open(diretorio+'.zip', Zip::File::CREATE) do |arquivo_zip|
      Dir.chdir diretorio
      Dir.glob("**/*").reject { |e| File.directory?(e) }.each do |arquivo|
        puts "Adicionando #{arquivo}"
        #arquivo_zip.add(arquivo.sub(diretorio + '/', ''), arquivo)
        #dá erro
      end
		end
	end

	def self.remover_arquivos
		# exec("find #{Rails.root}/arquivos -name '*.zip' -mtime +1 -delete") #Tempo em Horas (2 Horas)
	#	exec("find #{Rails.root}/arquivos -name '*.csv' -cmin +1 -delete") #Tempo em Minutos (60 Minutos)
	 if Dir.exist?("arquivos")
   FileUtils.rm_rf("arquivos")     
  end
   FileUtils.mkdir_p("arquivos")
	  puts 'teste remover_arquivos'
	end
	
	
	
 def self.import(file,nomearquivo)
   puts 'teste arquivo '+file
   puts 'nomearquivo '+nomearquivo
   if nomearquivo=='DISCNOTASCEMAC.csv'
   begin
     importDISCNOTASCEMAC(file)
   end
   elsif (nomearquivo=='STUDENT1NOTASCEMAC.csv')or(nomearquivo=='STUDENT2NOTASCEMAC.csv')
     importSTUDENTNOTASCEMAC(file)
   elsif nomearquivo=='TURMAS2019NOTASCEMAC.csv'
     importTURMAS2019NOTASCEMAC(file)
   elsif nomearquivo=='TEAMDISCNOTASCEMAC.csv'
     importTEAMDISCNOTASCEMAC(file)   
   elsif nomearquivo=='REGISTRATIONNOTASCEMAC.csv'
     importREGISTRATIONNOTASCEMAC(file)      
   elsif nomearquivo=='NOTASFREQUENCIANOTASCEMAC.csv'
     importNOTASFREQUENCIANOTASCEMAC(file) 
   end
 end
 
 
  def self.importDISCNOTASCEMAC(file)
    CSV.foreach(file, headers: true, encoding: 'iso-8859-1:utf-8', col_sep: ';').with_index do |linha, indice|
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
  
  def self.importSTUDENTNOTASCEMAC(file)
    CSV.foreach(file, headers: true, encoding: 'iso-8859-1:utf-8', col_sep: ';').with_index do |linha, indice|
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
  
 def self.importTURMAS2019NOTASCEMAC(file)
    CSV.foreach(file, headers: true, encoding: 'iso-8859-1:utf-8', col_sep: ';').with_index do |linha, indice|
     unless (indice == 0)
			if Team.where(idfb: linha[1]).exists?
			   team = Team.where(idfb: linha[1])
			   @team= Team.find(team[0].id)
				@team.update!(description: linha[0], idfb: linha[1], kind: linha[2], status: linha[3], year: linha[4])
			else
				Team.create!(description: linha[0], idfb: linha[1], kind: linha[2], status: linha[3], year: linha[4])
			end
     end
    end
 end 
 
 
  def self.importTEAMDISCNOTASCEMAC(file)
    CSV.foreach(file, headers: true, encoding: 'iso-8859-1:utf-8', col_sep: ';').with_index do |linha, indice|
     unless (indice == 0)
      team = Team.where(idfb: linha[0])
      disc = Discipline.where(idfb: linha[1])
       if team.exists?
        # se turma existe
        if disc.exists? 
         # se disc existe      
          if Teamdisc.where(team_id: team[0].id,discipline_id: disc[0].id).exists? 
            @teamdisc = Teamdisc.where(team_id: linha[0],discipline_id: linha[1])
             if @teamdisc.exists?
			     #puts @teamdisc[0]
			     #puts @teamdisc[1]
			             @teamdisc[0].update!(team_id: team[0].id,discipline_id: disc[0].id,indice: linha[2])        
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
  
 #ID;IDTURMA;IDALUNO;TIPOTURMA;STATUS;ANO 
 def self.importREGISTRATIONNOTASCEMAC(file)
    CSV.foreach(file, headers: true, encoding: 'iso-8859-1:utf-8', col_sep: ';').with_index do |linha, indice|
     unless (indice == 0)
      team = Team.where(idfb: linha[1])
      student = Student.where(idfb: linha[2])
      if team.exists?
        # se turma existe
        if student.exists? 
         # se student existe
         #puts linha[1]
        # puts team[0].id
         #puts student[0].id
         #puts linha[2]
         #puts 'status'+linha[4]
         #puts linha[5]
         #puts indice
          if Registration.where(idfb: linha[0]).exists?
            @registration=Registration.where(idfb: linha[0])
			    # puts @registration[0]
			     #puts @registration[1]
			         @registration[0].update!(team_id: team[0].id,student_id: student[0].id,kind: linha[3],status:linha[4],year:linha[5])
          else
           # se turmadisc não existe
          # puts linha[0]
           #puts team[0].id
           #puts student[0].id
           Registration.create!(idfb:linha[0],team_id: team[0].id,student_id: student[0].id,kind: linha[3],
                                status:linha[4],year:linha[5]) 			     
          end  
        end 
      end 
     end
    end
 end 
 
  def self.importNOTASFREQUENCIANOTASCEMAC(file)
   CSV.foreach(file, headers: true, encoding: 'iso-8859-1:utf-8', col_sep: ';').with_index do |linha, indice|
    unless (indice == 0)
     registration = Registration.where(idfb: linha[1])
     discipline = Discipline.where(idfb: linha[2])
     team = Team.where(idfb: linha[3])
     if team.exists?
      # se turma existe
       if registration.exists? 
        # se registration existe
        if discipline.exists? 
         # se discipline existe 
         @notefreq=Notefrequency.where(idfb: linha[0],team_id: team[0].id,discipline_id: discipline[0].id,registration_id: registration[0].id)
          if @notefreq.exists?          
			         #@notefreq = Notefrequency.where(idfb: linha[1],team_id: team[0].id,discipline_id: discipline[0].id)
           @notefreq[0].update!(idfb: linha[0],team_id: team[0].id,discipline_id: discipline[0].id,registration_id: registration[0].id,
                      f1bnota: linha[4],
                      f1brec: linha[5],
                      f1bfreq: linha[6],
                      f2bnota: linha[7],
                      f2brec: linha[8],
                      f2bfreq: linha[9],
                      f3bnota: linha[10], 
                      f3brec: linha[11],
                      f3bfreq: linha[12],
                      f4bnota: linha[13],
                      f4brec: linha[14],
                      f4bfreq: linha[15],
                      media: linha[16],
                      recfinal: linha[17],
                      resultado: linha[18],
                      concfinal: linha[19],
                      totfreq: linha[20]) 		


			               
          else
           # se notefreq não existe
           Notefrequency.create!(idfb: linha[0],team_id: team[0].id,discipline_id: discipline[0].id,
                      registration_id: registration[0].id,
                      f1bnota: linha[4],
                      f1brec: linha[5],
                      f1bfreq: linha[6],
                      f2bnota: linha[7],
                      f2brec: linha[8],
                      f2bfreq: linha[9],
                      f3bnota: linha[10], 
                      f3brec: linha[11],
                      f3bfreq: linha[12],
                      f4bnota: linha[13],
                      f4brec: linha[14],
                      f4bfreq: linha[15],
                      media: linha[16],
                      recfinal: linha[17],
                      resultado: linha[18],
                      concfinal: linha[19],
                      totfreq: linha[20]) 			     
          end  
        end 
       end 
     end
    end
   end 
  end   
	

end