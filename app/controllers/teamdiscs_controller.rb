class TeamdiscsController < ApplicationController
  before_action :set_teamdisc, only: [:show, :edit, :update, :destroy]
  before_action :set_teams, only: [:new,:edit]
  before_action :set_disciplines, only: [:new,:edit]
  before_action :authenticate_user!

  # GET /teamdiscs
  # GET /teamdiscs.json
  def index
    @q = Teamdisc.ransack(params[:q].try(:merge, m: params[:combinator]))
    @teamdiscs = @q.result.all.paginate(page: params[:page], :per_page => 50)
     .order(team_id: :asc)
  end

  # GET /teamdiscs/1
  # GET /teamdiscs/1.json
  def show
  end

  # GET /teamdiscs/new
  def new
    @teamdisc = Teamdisc.new
  end

  # GET /teamdiscs/1/edit
  def edit
  end

  # POST /teamdiscs
  # POST /teamdiscs.json
  def create
    @teamdisc = Teamdisc.new(teamdisc_params)

    respond_to do |format|
      if @teamdisc.save
        format.html { redirect_to @teamdisc, notice: 'Teamdisc was successfully created.' }
        format.json { render :show, status: :created, location: @teamdisc }
      else
        format.html { render :new }
        format.json { render json: @teamdisc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teamdiscs/1
  # PATCH/PUT /teamdiscs/1.json
  def update
    respond_to do |format|
      if @teamdisc.update(teamdisc_params)
        format.html { redirect_to @teamdisc, notice: 'Teamdisc was successfully updated.' }
        format.json { render :show, status: :ok, location: @teamdisc }
      else
        format.html { render :edit }
        format.json { render json: @teamdisc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teamdiscs/1
  # DELETE /teamdiscs/1.json
  def destroy
    @teamdisc.destroy
    respond_to do |format|
      format.html { redirect_to teamdiscs_url, notice: 'Teamdisc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
  def redirect(url, text)
  	redirect_to url, notice: text
  end
  def import
  	if params[:file]
  		Teamdisc.import(params[:file])
  		redirect(root_url, "Activity Data imported!")	
  	else
  		redirect(root_url, "Please upload a CSV file")
  	end
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teamdisc
      @teamdisc = Teamdisc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teamdisc_params
      params.require(:teamdisc).permit(:team_id, :discipline_id,:indice)
    end

    def set_teams
      @teams = Team.all
    end
    def set_disciplines
      @disciplines = Discipline.all
    end    
end
