class DisciplinesController < ApplicationController
  before_action :set_discipline, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  #before_action :set_disciplines, only:[:index]

  # GET /disciplines
  # GET /disciplines.json
  def index
    @q = Discipline.ransack(params[:q].try(:merge, m: params[:combinator]))
    @disciplines = @q.result.all.paginate(page: params[:page], :per_page => 10)
     .order(description: :asc)
  end

  # GET /disciplines/1
  # GET /disciplines/1.json
  def show
    #calculate_totals
  end

  # GET /disciplines/new
  def new
    @discipline = Discipline.new
  end

  # GET /disciplines/1/edit
  def edit
  end

  # POST /disciplines
  # POST /disciplines.json
  def create
    @discipline = Discipline.new(discipline_params)

    respond_to do |format|
      if @discipline.save
        format.html { redirect_to @discipline, notice: 'Discipline was successfully created.' }
        format.json { render :show, status: :created, location: @discipline }
      else
        format.html { render :new }
        format.json { render json: @discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disciplines/1
  # PATCH/PUT /disciplines/1.json
  def update
    respond_to do |format|
      if @discipline.update(discipline_params)
        format.html { redirect_to @discipline, notice: 'Discipline was successfully updated.' }
        format.json { render :show, status: :ok, location: @discipline }
      else
        format.html { render :edit }
        format.json { render json: @discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disciplines/1
  # DELETE /disciplines/1.json
  def destroy
    @discipline.destroy
    respond_to do |format|
      format.html { redirect_to disciplines_url, notice: 'Discipline was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def redirect(url, text)
  	redirect_to url, notice: text
  end
  def import
  	if params[:file]
  	  #delayjobapipostestrede(params[:file])
  		Discipline.import(params[:file])
  	redirect(root_url, "Activity Data imported!")	
  	else
  		redirect(root_url, "Please upload a CSV file")
  	end
  end
  
   def delayjobapipostestrede(part1)
      disc1=Discipline.first
      disc=Discipline.find(disc1.id)
      #2.minutes.from_now
      #disc.delay(run_at: 1.minute.from_now).deliver
      disc.delay.import1(part1)
   end 



   def calculate_totals
    Discipline.find_each  do |discipline|
    # add .delay method to add it to background process. In case of     mail sending remove the .deliver method to make it work.
    d=Delayed::Job.all
    puts d.count
    discipline.delay.deliver
    #flash[:notice] = "Mail delivered"
    #redirect_to root_path
    puts 'okkkkkkk'
    d=Delayed::Job.all
    puts d.count    
    end
   end  




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discipline
      @discipline = Discipline.find(params[:id])
    end
    
    def set_disciplines
      @disciplines = Discipline.all
    end    

    # Never trust parameters from the scary internet, only allow the white list through.
    def discipline_params
      params.require(:discipline).permit(:description, :idfb,:indice,:abrev,:status)
    end
end
