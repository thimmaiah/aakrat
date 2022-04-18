class PaymentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_cached_role?(:super)
        scope.all
      else
        scope.where(company_id: user.company_id)
      end
    end
  end

  def index?
    true
  end

  def show?
    user.has_cached_role?(:super) || (user.company_id == record.company_id)
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
    false
  end
end
