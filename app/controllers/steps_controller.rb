class StepsController < ApplicationController
  before_action :set_step, only: %i[show edit update destroy toggle_completed]

  # GET /steps or /steps.json
  def index
    @steps = policy_scope(Step)
  end

  # GET /steps/1 or /steps/1.json
  def show; end

  # GET /steps/new
  def new
    @step = Step.new(step_params)
    @step.company_id = current_user.company_id
    authorize @step
  end

  # GET /steps/1/edit
  def edit; end

  # POST /steps or /steps.json
  def create
    @step = Step.new(step_params)
    @step.company_id = current_user.company_id
    authorize @step

    respond_to do |format|
      if @step.save
        format.turbo_stream { render :create }
        format.html { redirect_to step_url(@step), notice: "Step was successfully created." }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1 or /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to step_url(@step), notice: "Step was successfully updated." }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_completed
    @step.completed = !@step.completed
    @step.save
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(@step)
        ]
      end
      format.html { redirect_to step_url(@step), notice: "Step was successfully updated." }
      format.json { render :show, status: :ok, location: @step }
    end
  end

  # DELETE /steps/1 or /steps/1.json
  def destroy
    @step.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@step)
        ]
      end
      format.html { redirect_to steps_url, notice: "Step was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_step
    @step = Step.find(params[:id])
    authorize @step
  end

  # Only allow a list of trusted parameters through.
  def step_params
    params.require(:step).permit(:name, :start_date, :end_date, :days, :status, :project_id,
                                 :phase_id, :assigned_to_id, :visible_to_client, :completed,
                                 :details, attachments: [])
  end
end
