class PaymentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_cached_role?(:super)
        scope.all
      elsif user.has_cached_role?(:team_lead)
        scope.where(company_id: user.company_id)
      else
        scope.joins(project: :project_accesses)
             .merge(ProjectAccess.for(user, %w[Client Accountant]))
      end
    end
  end

  def index?
    user.has_cached_role?(:super) || user.has_cached_role?(:team_lead)
  end

  def show?
    if user.has_cached_role?(:super) || (user.has_cached_role?(:team_lead) && user.company_id == record.company_id)
      true
    else
      Payment.joins(project: :project_accesses)
             .where("project_accesses.user_id=?", user.id)
             .where(id: record.id).present?
    end
  end

  def create?
    user.has_cached_role?(:super) || (user.has_cached_role?(:team_lead) && user.company_id == record.company_id)
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def edit?
    create?
  end

  def destroy?
    create?
  end
end
