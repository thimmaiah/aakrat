class PhasePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_cached_role?(:super)
        scope.all
      elsif user.has_cached_role?(:team_lead) || user.has_cached_role?(:team_member)
        scope.where(company_id: user.company_id)
      elsif user.has_cached_role?(:client)
        scope.joins(project: :project_accesses).visible_to_client
             .merge(ProjectAccess.for(user, %w[Client]))
      else
        scope.joins(project: :project_accesses)
             .merge(ProjectAccess.for(user, %w[Contractor Accountant]))

      end
    end
  end

  def index?
    true
  end

  def dashboard?
    true
  end

  def search?
    true
  end

  def show?
    if user.has_cached_role?(:super) || user.company_id == record.company_id
      true
    else
      # If the user is a Client then the phase must be visible
      Phase.joins(project: :project_accesses).visible_to_client
           .merge(ProjectAccess.for(user, %w[Client]))
           .or(
             # If user is a Contractor or Accountant then he can view
             Phase.joins(project: :project_accesses)
                  .merge(ProjectAccess.for(user, %w[Contractor Accountant]))
           )
           .where(id: record.id).present?
    end
  end

  def create?
    user.has_cached_role?(:team_lead) && user.company_id == record.company_id
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def toggle_completed?
    update?
  end

  def add_note?
    user.company_id == record.company_id
  end
end
