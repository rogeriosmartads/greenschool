class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#  devise :database_authenticatable,
#         :recoverable, :rememberable, :validatable  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, presence: true
  validates :email, presence: true, uniqueness: true 
  
  belongs_to :kind
  enum admin: [ :'Sim', :'Não' ]  
end
