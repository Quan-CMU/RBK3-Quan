class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password

  before_save {
    self.email = email.downcase
  }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: { case_sensitive: false }

  validates :name, presence: true,
                   length:{
                     maximum:50
                   }

  # VALID_PHONE_REGEX = /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/
  # validates :phone, presence: true,
  #                   format: { 
  #                     with: VALID_PHONE_REGEX,
  #                     message: "- Phone numbers must be in xxx-xxx-xxxx format."  
  #                   }

  validates :name, presence: true,
                    length:{
                      maximum:50
                    }
  class << self
     #return hash digest 
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # return random token
    def User.new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end

