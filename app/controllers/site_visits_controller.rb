class SiteVisitsController < ApplicationController
  before_action :set_site_visit, only: %i[edit update destroy]

  # GET /site_visits or /site_visits.json
  def index
    @site_visits = policy_scope(SiteVisit).includes(:project, :phase, :assigned_to)
  end

  # GET /site_visits/1 or /site_visits/1.json
  def show
    @site_visit = SiteVisit.with_attached_attachments.find(params[:id])
    authorize @site_visit
  end

  # GET /site_visits/new
  def new
    @site_visit = SiteVisit.new(site_visit_params)
    @site_visit.company_id = current_user.company_id
    authorize @site_visit
  end

  # GET /site_visits/1/edit
  def edit; end

  # POST /site_visits or /site_visits.json
  def create
    @site_visit = SiteVisit.new(site_visit_params)
    @site_visit.company_id = current_user.company_id
    authorize @site_visit

    respond_to do |format|
      if @site_visit.save
        format.html { redirect_to site_visit_url(@site_visit), notice: "Site visit was successfully created." }
        format.json { render :show, status: :created, location: @site_visit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @site_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_visits/1 or /site_visits/1.json
  def update
    respond_to do |format|
      if @site_visit.update(site_visit_params)
        format.html { redirect_to site_visit_url(@site_visit), notice: "Site visit was successfully updated." }
        format.json { render :show, status: :ok, location: @site_visit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @site_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_visits/1 or /site_visits/1.json
  def destroy
    @site_visit.destroy

    respond_to do |format|
      format.html { redirect_to site_visits_url, notice: "Site visit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_site_visit
    @site_visit = SiteVisit.find(params[:id])
    authorize @site_visit
  end

  # Only allow a list of trusted parameters through.
  def site_visit_params
    params.require(:site_visit).permit(:project_id, :company_id, :phase_id,
                                       :cost, :scheduled_on, :conducted_on, :assigned_to_id, :completed,
                                       :details, attachments: [])
  end
end
