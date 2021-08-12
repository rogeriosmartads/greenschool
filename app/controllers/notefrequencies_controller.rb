class NotefrequenciesController < ApplicationController
  #before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: [:indexstudent]
  before_action :set_student,only:[:showstudent,:show]
  before_action :set_notefrequency,only:[:edit,:update,:show]
  before_action :authenticate_user!
  
  
  def indexstudent
    puts @team.id
    puts @team.description
    puts @team.year
    arraystud=[]
    registrations=Registration.select(:student_id).where(team_id:@team.id)
    puts registrations.count
    registrations.each do |reg|
     arraystud.push(reg.student_id) 
    end  
    puts arraystud.count
    @students=Student.where("id IN (?)", arraystud)
  end   
  
  
  # GET /teams
  # GET /teams.json
  def index
   if params[:q].present?
     q=params[:q] 
    if q[:year_eq].present?
     years=[ :'2011', :'2012',:'2013',:'2014',:'2015',:'2016',:'2017',:'2018',:'2019',:'2020',:'2021',:'2022']  
     pyear= years[q[:year_eq].to_i]
     puts pyear
     puts 'present'
     @q = Notefrequency.ransack(params[:q].try(:merge, m: params[:combinator]))
     #@notefrequencies = @q.result.all.paginate(page: params[:page], :per_page => 30).order(id: :asc)
     #auxindex(@q,pyear)
     subquery(@q,pyear)
    else  
     puts 'não presente'  
     @q = Notefrequency.ransack(params[:q].try(:merge, m: params[:combinator]))
     @notefrequencies = @q.result.all.paginate(page: params[:page], :per_page => 30).order(team_id: :asc)
    end
   else  
     puts 'não presente'  
     @q = Notefrequency.ransack(params[:q].try(:merge, m: params[:combinator]))
     @notefrequencies = @q.result.all.paginate(page: params[:page], :per_page => 30).order(team_id: :asc)
   end
    
  end
  
  def subquery(j,pyear)
#j.result.joins(:team).select('notefrequencies.id, notefrequencies.name , teams.name as team_name,notefrequencies.codmes')
#    .where('notefrequencies.id > ?', 0).paginate(:page => params[:page], :per_page => 50).order('team_name,notefrequencies.name ASC')
    @teams=Team.where(year:pyear)
    @teams_id=Team.select(:id).where(year:pyear)
    puts 'qqqqqqqqqqqqqq'
    puts @teams_id.count
    puts 'eeeeeeeeeeeeeeeee'
    @notefrequencies = j.result.select('notefrequencies.team_id').distinct.where(year:pyear).where("team_id IN (?)",@teams_id)
    .paginate(page: params[:page], :per_page => 30)
  end   
  
  
=begin
  
  def auxindex(j,pyear)
    puts pyear
    @teams=Team.where(year:pyear)
    @teams_id=Team.select(:id).where(year:pyear)
    puts @teams.count
    puts j.result.count
      j.result.where("team_id IN (?)",@teams_id)
    puts j.result.count
    @notefrequencies = j.result.all.paginate(page: params[:page], :per_page => 30).order(id: :asc)
  end
=end 
  # GET /notefrequencies/1
  # GET /notefrequencies/1.json
  def show
    
  end

  def showstudent
    
  end  
  # GET /notefrequencies/1/edit
  def edit
   
  end 

  # PATCH/PUT /notefrequencies/1
  # PATCH/PUT /notefrequencies/1.json
  def update
    respond_to do |format|
      if @notefrequency.update(notefrequencies_params)
        puts @notefrequency.id
        puts @notefrequency.year
        puts @notefrequency.f1bnota
        
        pyear=9 
        format.html { redirect_to "/notefrequencies?q%5Byear_eq%5D="+pyear.to_s, notice: 'Notefrequency was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end


  def redirect(url, text)
  	redirect_to url, notice: text
  end

  def import
  	if params[:file]
  		Notefrequency.import(params[:file])
  		redirect(root_url, "Activity Data imported!")	
  	else
  		redirect(root_url, "Please upload a CSV file")
  	end
  end   

private
    # Use callbacks to share common setup or constraints between actions.
    def notefrequencies_params
      params.require(:notefrequency).permit(:f1bnota,:f1brec,:f1bfreq, :f2bnota,:f2brec,:f2bfreq, :f3bnota,:f3bfreq,:f3brec,:f4bnota,:f4brec,:f4bfreq,
      :media, :recfinal, :resultado, :concfinal, :totfreq)
    end    
    
def getindiceyear(pyears,pyear)
 count=0
 #years=[ :'2011', :'2012',:'2013',:'2014',:'2015',:'2016',:'2017',:'2018',:'2019',:'2020',:'2021',:'2022'] 
 pyears.each do |yea|
  if pyear.to_s==yea.to_s
   break
  end 
   count=count+1 
 end
 count
end  

    def set_student
      @team = Team.find(params[:other]) 
      @student = Student.find(params[:id])
      registration=Registration.where(student_id:@student.id,team_id:@team.id,year:@team.year,kind:0,status:0)
      if registration.present?
       @registration=Registration.find(registration[0].id)
       @team=Team.find(@registration.team_id)
     @q=Notefrequency.where('registration_id=? AND team_id=?',@registration.id,@team.id)
     @notefrequencies=@q.joins(:discipline).select('notefrequencies.id, disciplines.description as disc_desc, disciplines.indice as disc_indice,
     notefrequencies.f1bnota,notefrequencies.f1brec,notefrequencies.f1bfreq,notefrequencies.f2bnota,notefrequencies.f2brec,notefrequencies.f2bfreq,
     notefrequencies.f3bnota,notefrequencies.f3brec,notefrequencies.f3bfreq,notefrequencies.f4bnota,notefrequencies.f4brec,notefrequencies.f4bfreq,
     notefrequencies.media,notefrequencies.recfinal,notefrequencies.resultado,notefrequencies.concfinal,notefrequencies.totfreq')
    .where('notefrequencies.id > ?', 0).order('disc_indice ASC')       
      end 
    end


    def set_team
      @team = Team.find(params[:id])
    end
    
    def set_notefrequency
      @notefrequency = Notefrequency.find(params[:id])
    end       

end
