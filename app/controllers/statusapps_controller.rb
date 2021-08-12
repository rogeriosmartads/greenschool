class StatusappsController < ApplicationController
  before_action :set_statusapp, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /statusapps
  # GET /statusapps.json
  def index
    @statusapps = Statusapp.all
  end

  # GET /statusapps/1
  # GET /statusapps/1.json
  def show
  end

  # GET /statusapps/new
  def new
    @statusapp = Statusapp.new
  end

  # GET /statusapps/1/edit
  def edit
  end

  # POST /statusapps
  # POST /statusapps.json
  def create
    @statusapp = Statusapp.new(statusapp_params)

    respond_to do |format|
      if @statusapp.save
        format.html { redirect_to @statusapp, notice: 'Statusapp was successfully created.' }
        format.json { render :show, status: :created, location: @statusapp }
      else
        format.html { render :new }
        format.json { render json: @statusapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statusapps/1
  # PATCH/PUT /statusapps/1.json
  def update
    respond_to do |format|
      if @statusapp.update(statusapp_params)
        format.html { redirect_to @statusapp, notice: 'Statusapp was successfully updated.' }
        format.json { render :show, status: :ok, location: @statusapp }
      else
        format.html { render :edit }
        format.json { render json: @statusapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statusapps/1
  # DELETE /statusapps/1.json
  def destroy
    @statusapp.destroy
    respond_to do |format|
      format.html { redirect_to statusapps_url, notice: 'Statusapp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statusapp
      @statusapp = Statusapp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def statusapp_params
      params.require(:statusapp).permit(:name)
    end
end
