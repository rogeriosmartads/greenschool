class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy,:altpesqstatus]
  before_action :authenticate_user!
  
  # GET /teams
  # GET /teams.json
  def index
    @q = Team.ransack(params[:q].try(:merge, m: params[:combinator]))
    @teams = @q.result.all.paginate(page: params[:page], :per_page => 30)
     .order(description: :asc)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def altpesqstatus
  puts params
  puts @team.description
  if @team.pesqstatus=='ok'
    @team.pesqstatus='nok'
  elsif @team.pesqstatus=='nok'
    @team.pesqstatus='ok'
  end
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        #format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        #format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end  
  

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def redirect(url, text)
  	redirect_to url, notice: text
  end
  def import
  	if params[:file]and params[:tyear]
  		Team.import(params[:file],params[:tyear])
  		redirect(root_url, "Activity Data imported!")	
  	else
  		redirect(root_url, "Please upload a CSV file")
  	end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:description, :year, :idfb,:kind,:status,:pesqstatus)
    end
   
   def teamaltpesqstatus_params
     params.require(:team).permit(:pesqstatus)
   end   
    
end
