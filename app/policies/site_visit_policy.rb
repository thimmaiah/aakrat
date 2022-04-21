class SiteVisitPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_cached_role?(:super)
        scope.all
      elsif user.has_cached_role?(:team_lead)
        scope.where(company_id: user.company_id)
      elsif user.has_cached_role?(:team_member)
        scope.where(assigned_to_id: user.id)
      else
        scope.joins(project: :project_accesses)
             .merge(ProjectAccess.for(user, %w[Client Contractor]))
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
      SiteVisit.joins(project: :project_accesses)
               .where("project_accesses.user_id=?", user.id)
               .where(id: record.id).present?
    end
  end

  def create?
    (user.has_cached_role?(:team_lead) && user.company_id == record.company_id) ||
      record.project.client?(user)
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

  def clone?
    update?
  end

  def clone_phases?
    update?
  end

  def destroy?
    update?
  end
end
