class ExpressesController < ApplicationController
  before_action :set_express, only: [:show, :edit, :update, :destroy]

  # GET /expresses
  # GET /expresses.json
  def index
    @expresses = Express.all
  end

  # GET /expresses/1
  # GET /expresses/1.json
  def show
  end

  # GET /expresses/new
  def new
    @express = Express.new
  end

  # GET /expresses/1/edit
  def edit
  end

  # POST /expresses
  # POST /expresses.json
  def create
    @express = Express.new(express_params)

    respond_to do |format|
      if @express.save
        format.html { redirect_to @express, notice: 'Express was successfully created.' }
        format.json { render action: 'show', status: :created, location: @express }
      else
        format.html { render action: 'new' }
        format.json { render json: @express.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expresses/1
  # PATCH/PUT /expresses/1.json
  def update
    respond_to do |format|
      if @express.update(express_params)
        format.html { redirect_to @express, notice: 'Express was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @express.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expresses/1
  # DELETE /expresses/1.json
  def destroy
    @express.destroy
    respond_to do |format|
      format.html { redirect_to expresses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_express
      @express = Express.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def express_params
      params[:express]
    end
end
