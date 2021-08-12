class StudentPolicy < ApplicationPolicy
  def index?
    user.adm?
    
  end  
  
  
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
