class WelcomeController < ApplicationController
  
  def index
    @q = Student.ransack(params[:q].try(:merge, m: params[:combinator]))
     flash.now[:notice] = "Digite matrícula e data de nascimento do aluno"
    #@students = @q.result.all.paginate(page: params[:page], :per_page => 30)
  end
  
  
  def index2
    puts params[0]
    puts 'teteettete'
    @q = Student.ransack(params[:q].try(:merge, m: params[:combinator]))
     flash.now[:notice] = params[0]
    #@students = @q.result.all.paginate(page: params[:page], :per_page => 30)
  end  
  
  
  
  
end
