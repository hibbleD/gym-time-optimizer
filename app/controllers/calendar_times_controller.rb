class CalendarTimesController < ApplicationController
  before_action :set_calendar_time, only: %i[ show edit update destroy ]

  # GET /calendar_times or /calendar_times.json
  def index
    @calendar_times = CalendarTime.all
  end

  # GET /calendar_times/1 or /calendar_times/1.json
  def show
  end

  # GET /calendar_times/new
  def new
    @calendar_time = CalendarTime.new
  end

  # GET /calendar_times/1/edit
  def edit
  end

  # POST /calendar_times or /calendar_times.json
  def create
    @calendar_time = CalendarTime.new(calendar_time_params)

    respond_to do |format|
      if @calendar_time.save
        format.html { redirect_to calendar_time_url(@calendar_time), notice: "Calendar time was successfully created." }
        format.json { render :show, status: :created, location: @calendar_time }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @calendar_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendar_times/1 or /calendar_times/1.json
  def update
    respond_to do |format|
      if @calendar_time.update(calendar_time_params)
        format.html { redirect_to calendar_time_url(@calendar_time), notice: "Calendar time was successfully updated." }
        format.json { render :show, status: :ok, location: @calendar_time }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @calendar_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendar_times/1 or /calendar_times/1.json
  def destroy
    @calendar_time.destroy

    respond_to do |format|
      format.html { redirect_to calendar_times_url, notice: "Calendar time was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar_time
      @calendar_time = CalendarTime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def calendar_time_params
      params.fetch(:calendar_time, {})
    end
end
