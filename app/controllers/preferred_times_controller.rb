class PreferredTimesController < ApplicationController
  before_action :set_preferred_time, only: %i[ show edit update destroy ]

  # GET /preferred_times or /preferred_times.json
  def index
    @preferred_times = PreferredTime.all
  end

  # GET /preferred_times/1 or /preferred_times/1.json
  def show
  end

  # GET /preferred_times/new
  def new
    @preferred_time = PreferredTime.new
  end

  # GET /preferred_times/1/edit
  def edit
  end

  # POST /preferred_times or /preferred_times.json
  def create
    @preferred_time = PreferredTime.new(preferred_time_params)

    respond_to do |format|
      if @preferred_time.save
        format.html { redirect_to preferred_time_url(@preferred_time), notice: "Preferred time was successfully created." }
        format.json { render :show, status: :created, location: @preferred_time }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @preferred_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preferred_times/1 or /preferred_times/1.json
  def update
    respond_to do |format|
      if @preferred_time.update(preferred_time_params)
        format.html { redirect_to preferred_time_url(@preferred_time), notice: "Preferred time was successfully updated." }
        format.json { render :show, status: :ok, location: @preferred_time }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @preferred_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preferred_times/1 or /preferred_times/1.json
  def destroy
    @preferred_time.destroy

    respond_to do |format|
      format.html { redirect_to preferred_times_url, notice: "Preferred time was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preferred_time
      @preferred_time = PreferredTime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def preferred_time_params
      params.fetch(:preferred_time, {})
    end
end
