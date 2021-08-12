class AccessplatformsController < ApplicationController
  before_action :set_accessplatform, only: [:show]
  before_action :authenticate_user!

  # GET /accessplatforms
  # GET /accessplatforms.json
  def index
    #@accessplatforms = Accessplatform.all.order(:pdate)
     @q = Accessplatform.ransack(params[:q].try(:merge, m: params[:combinator]))
    @accessplatforms = @q.result.all.paginate(page: params[:page], :per_page => 100)
     .order(pdate: :desc)   
  end
  # GET /accessplatforms/1
  # GET /accessplatforms/1.json
  def show
  end  
=begin
  # GET /accessplatforms/new
  def new
    @accessplatform = Accessplatform.new
  end

  # GET /accessplatforms/1/edit
  def edit
  end

  # POST /accessplatforms
  # POST /accessplatforms.json
  def create
    @accessplatform = Accessplatform.new(accessplatform_params)

    respond_to do |format|
      if @accessplatform.save
        format.html { redirect_to @accessplatform, notice: 'Accessplatform was successfully created.' }
        format.json { render :show, status: :created, location: @accessplatform }
      else
        format.html { render :new }
        format.json { render json: @accessplatform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accessplatforms/1
  # PATCH/PUT /accessplatforms/1.json
  def update
    respond_to do |format|
      if @accessplatform.update(accessplatform_params)
        format.html { redirect_to @accessplatform, notice: 'Accessplatform was successfully updated.' }
        format.json { render :show, status: :ok, location: @accessplatform }
      else
        format.html { render :edit }
        format.json { render json: @accessplatform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accessplatforms/1
  # DELETE /accessplatforms/1.json
  def destroy
    @accessplatform.destroy
    respond_to do |format|
      format.html { redirect_to accessplatforms_url, notice: 'Accessplatform was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
=end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accessplatform
      @accessplatform = Accessplatform.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accessplatform_params
      params.require(:accessplatform).permit(:accessok, :accesserror, :pdate, :reason)
    end
end
