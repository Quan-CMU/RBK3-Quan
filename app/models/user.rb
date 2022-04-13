class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many :microposts, dependent: :destroy
  has_many_attached :photos
  
  has_secure_password

  before_save {
    self.email = email.downcase
  }
  before_create :create_activation_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: { case_sensitive: false }

  validates :name, presence: true,
                   length:{
                     maximum:50
                   }

  PASSWORD_MIN_LENGTH = 6
  validates :password, presence: true,
                       length: {minimum: PASSWORD_MIN_LENGTH},
                       allow_nil: true
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

  def authenticated?(attribute, token)
    digest = self.send(attribute)
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # kich hoat tai khoan
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # kich hoat gui email
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end
  
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def feed
    microposts
  end
  private

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end

