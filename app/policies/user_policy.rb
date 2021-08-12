class UserPolicy < ApplicationPolicy
  def index?
    user.adm?
    
  end  
  
  
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
