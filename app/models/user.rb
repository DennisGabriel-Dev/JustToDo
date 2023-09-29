class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :password_validate

  def password_validate
    unless password =~ /^(?=.*[A-Za-z])(?=.*\d).{8,}$/
        errors.add :password, "A senha deve conter pelo menos um número e ter no mínimo 8 caracteres"
        # Somente para testar no console
        puts "A senha deve conter pelo menos um número e ter no mínimo 8 caracteres"
    end
  end
end
