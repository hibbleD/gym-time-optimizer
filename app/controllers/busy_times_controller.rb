class BusyTimesController < ApplicationController
  before_action :set_busy_time, only: %i[ show edit update destroy ]

  # GET /busy_times or /busy_times.json
  def index
    @busy_times = BusyTime.all
  end

  def show
    api_key = ENV['GOOGLE_MAPS_API_KEY']
    gym_place_id = "ChIJ3RSaYE_LD4gRts0TShMrFjc"

    # Define a cache key based on the current date
    cache_key = "busy_times_#{Date.current}"

    # Check if the cache exists and is still valid
    if Rails.cache.exist?(cache_key)
      # If the cache is valid, retrieve the data from the cache
      result = Rails.cache.read(cache_key)
    else
      # If the cache is not valid, make the API call

      result = `python3 get_busy_times.py #{api_key} #{gym_place_id}`

      # Store the result in the cache with an expiration time (e.g., 24 hours)

      Rails.cache.write(cache_key, result, expires_in: (24.hours / 5).to_i)

      # Process the result as needed

      parsed_result = JSON.parse(result)

      # Extract relevant information
      @hourly_busy_times = parsed_result["hourly_busy_times"]
      @busyness_level = parsed_result["busyness_level"]
    end

    private

    def parse_result(result)
      # Process the result as needed
      # For example, you can split the output into lines and access specific values
      lines = result.split("\n")
      hourly_busy_times = lines[1]
      busyness_level = lines[3]
      busyness_label = lines[5]

      # Use the parsed data as needed
      puts "Hourly Busy Times: #{hourly_busy_times}"
      puts "Busyness Level: #{busyness_level}"
      puts "Busyness Label: #{busyness_label}"
    end
  end

  # GET /busy_times/new
  def new
    @busy_time = BusyTime.new
  end

  # GET /busy_times/1/edit
  def edit
  end

  # POST /busy_times or /busy_times.json
  def create
    @busy_time = BusyTime.new(busy_time_params)

    respond_to do |format|
      if @busy_time.save
        format.html { redirect_to busy_time_url(@busy_time), notice: "Busy time was successfully created." }
        format.json { render :show, status: :created, location: @busy_time }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @busy_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /busy_times/1 or /busy_times/1.json
  def update
    respond_to do |format|
      if @busy_time.update(busy_time_params)
        format.html { redirect_to busy_time_url(@busy_time), notice: "Busy time was successfully updated." }
        format.json { render :show, status: :ok, location: @busy_time }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @busy_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /busy_times/1 or /busy_times/1.json
  def destroy
    @busy_time.destroy

    respond_to do |format|
      format.html { redirect_to busy_times_url, notice: "Busy time was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_busy_time
   @busy_time = BusyTime.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  #def busy_time_params
  #  params.fetch(:busy_time, {})
  #end
end
