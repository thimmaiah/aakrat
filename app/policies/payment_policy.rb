class PaymentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_cached_role?(:super)
        scope.all
      elsif user.has_cached_role?(:team_lead)
        scope.where(company_id: user.company_id)
      else
        Payment.none
      end
    end
  end

  def index?
    user.has_cached_role?(:super) || user.has_cached_role?(:team_lead)
  end

  def show?
    user.has_cached_role?(:super) || (user.has_cached_role?(:team_lead) && user.company_id == record.company_id)
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
