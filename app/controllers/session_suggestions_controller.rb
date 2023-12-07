class SessionSuggestionsController < ApplicationController
  before_action :set_session_suggestion, only: %i[ show edit update destroy ]

  # GET /session_suggestions or /session_suggestions.json
  def index
    @session_suggestions = SessionSuggestion.all
  end

  # GET /session_suggestions/1 or /session_suggestions/1.json
  def show
  end

  # GET /session_suggestions/new
  def new
    @session_suggestion = SessionSuggestion.new
  end

  # GET /session_suggestions/1/edit
  def edit
  end

  # POST /session_suggestions or /session_suggestions.json
  def create
    @session_suggestion = SessionSuggestion.new(session_suggestion_params)

    respond_to do |format|
      if @session_suggestion.save
        format.html { redirect_to session_suggestion_url(@session_suggestion), notice: "Session suggestion was successfully created." }
        format.json { render :show, status: :created, location: @session_suggestion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @session_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /session_suggestions/1 or /session_suggestions/1.json
  def update
    respond_to do |format|
      if @session_suggestion.update(session_suggestion_params)
        format.html { redirect_to session_suggestion_url(@session_suggestion), notice: "Session suggestion was successfully updated." }
        format.json { render :show, status: :ok, location: @session_suggestion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @session_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /session_suggestions/1 or /session_suggestions/1.json
  def destroy
    @session_suggestion.destroy

    respond_to do |format|
      format.html { redirect_to session_suggestions_url, notice: "Session suggestion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session_suggestion
      @session_suggestion = SessionSuggestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def session_suggestion_params
      params.fetch(:session_suggestion, {})
    end
end
