class NotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_cached_role?(:super)
        scope.all
      elsif user.has_cached_role?(:team_lead) || user.has_cached_role?(:team_member)
        scope.where(company_id: user.company_id)
      else
        scope.none
      end
    end
  end

  def index?
    user.has_cached_role?(:super) || user.has_cached_role?(:team_lead) || user.has_cached_role?(:team_member)
  end

  def dashboard?
    true
  end

  def search?
    true
  end

  def show?
    user.has_cached_role?(:super) || user.company_id == record.company_id
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
end
