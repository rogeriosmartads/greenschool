class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user!

  # GET /students
  # GET /students.json
  def index #06/01/2014 6642
    if params[:commit]=="Buscar"
     puts params[:q].values[1]
     @q = Student.ransack(params[:q].try(:merge, m: 'AND'))
     statusapp=Statusapp.last
     if (params[:q].values[0]!=''and params[:q].values[1]!='' and statusapp.name!='Manutenção')
       @student=Student.where('code=? AND datebirthday=?',params[:q].values[0],params[:q].values[1])
       if @student.count==0
         incrementaacessoplataforma(0,1,'est não encontrado')
         #redirect_to welcome_index2_path('est não encontrado')
         redirect_to welcome_index_path
       else
         subqueryboletim(@q,params[:q].values[2])
       end
     elsif statusapp.name=='Manutenção'
      incrementaacessoplataforma(0,1,'app Manutenção') 
      #redirect_to welcome_index2_path('app Manutenção')
      redirect_to welcome_index_path
     else
      incrementaacessoplataforma(0,1,'campos em branco') 
      #redirect_to welcome_index2_path('campos em branco')
      redirect_to welcome_index_path
     end  
    elsif user_signed_in?
      if  current_user.admin?
       @q = Student.ransack(params[:q].try(:merge, m: 'AND'))
       @students = @q.result.all.paginate(page: params[:page], :per_page => 50)
       .order(name: :asc)
      end 
    else
      #redirect_to welcome_index2_path("erro")
      redirect_to welcome_index_path
    end 
  end
  
  def subqueryboletim(j,ano)
    registration=Registration.where('student_id=? AND year=?',@student[0].id,ano)
    registration.each do|reg|
     if (reg.status=='M')and(reg.kind=='NORMAL')
       @registration=reg
     end
    end 
    if @registration.present?
     @team=Team.where('id=? AND year=?',@registration.team.id,ano)
     if @team[0].pesqstatus=='ok'
      teamdiscs=Teamdisc.where('team_id=?',@team[0].id).order(:indice)
      arrayteamdiscs=[]
      teamdiscs.each do |teamdisc|
       if teamdisc.id!=nil  
        arrayteamdiscs.push(teamdisc.discipline_id)
       end 
      end
      incrementaacessoplataforma(1,0,'Ok')
      @disciplines=Discipline.where(id: arrayteamdiscs).order(:indice)
      @q=Notefrequency.where('registration_id=? AND team_id=?',@registration.id,@team[0].id)
      @notefrequencies=@q.joins(:discipline).select('notefrequencies.id, disciplines.description as disc_desc, disciplines.indice as disc_indice,
      notefrequencies.f1bnota,notefrequencies.f1brec,notefrequencies.f1bfreq,notefrequencies.f2bnota,notefrequencies.f2brec,notefrequencies.f2bfreq,
      notefrequencies.f3bnota,notefrequencies.f3brec,notefrequencies.f3bfreq,notefrequencies.f4bnota,notefrequencies.f4brec,notefrequencies.f4bfreq,
      notefrequencies.media,notefrequencies.recfinal,notefrequencies.resultado,notefrequencies.concfinal,notefrequencies.totfreq')
     .where('notefrequencies.id > ?', 0).order('disc_indice ASC')
     else
      incrementaacessoplataforma(0,1,'turma não liberada')
      #redirect_to welcome_index2_path('turma não liberada')
      redirect_to welcome_index_path
     end  
    else
      incrementaacessoplataforma(0,1,'mat não encontrada')
      #redirect_to welcome_index2_path('mat não encontrada')
      redirect_to welcome_index_path
    end  
  end   
  
  def incrementaacessoplataforma(pacessok,pacesserror,preason)
    accessplat=Accessplatform.new
    accessplat.accessok=pacessok
    accessplat.accesserror=pacesserror
    accessplat.reason=preason
    accessplat.pdate=Time.now.strftime("%Y-%m-%d")
    accessplat.save    
  end  
  
  

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def redirect(url, text)
  	redirect_to url, notice: text
  end
  def import
  	if params[:file]
  		Student.import(params[:file])
  		redirect(root_url, "Activity Data imported!")	
  	else
  		redirect(root_url, "Please upload a CSV file")
  	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :code, :datebirthday, :idfb)
    end
end
