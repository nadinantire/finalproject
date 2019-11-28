class GarelleysController < ApplicationController
  before_action :set_garelley, only: [:show, :edit, :update, :destroy]

  # GET /garelleys
  # GET /garelleys.json
  def index
    @garelleys = Garelley.all
  end

  # GET /garelleys/1
  # GET /garelleys/1.json
  def show
  end

  # GET /garelleys/new
  def new
    @garelley = Garelley.new
  end

  # GET /garelleys/1/edit
  def edit
  end

  # POST /garelleys
  # POST /garelleys.json
  def create
    @garelley = Garelley.new(garelley_params)

    respond_to do |format|
      if @garelley.save
        format.html { redirect_to @garelley, notice: 'Garelley was successfully created.' }
        format.json { render :show, status: :created, location: @garelley }
      else
        format.html { render :new }
        format.json { render json: @garelley.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /garelleys/1
  # PATCH/PUT /garelleys/1.json
  def update
    respond_to do |format|
      if @garelley.update(garelley_params)
        format.html { redirect_to @garelley, notice: 'Garelley was successfully updated.' }
        format.json { render :show, status: :ok, location: @garelley }
      else
        format.html { render :edit }
        format.json { render json: @garelley.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /garelleys/1
  # DELETE /garelleys/1.json
  def destroy
    @garelley.destroy
    respond_to do |format|
      format.html { redirect_to garelleys_url, notice: 'Garelley was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garelley
      @garelley = Garelley.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def garelley_params
      params.require(:garelley).permit(:name, :image)
    end
end
