class User < ApplicationRecord
  has_secure_password
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: { case_sensitive: false }
  validates :name, presence: true,
                   length:{
                     maximum:5
                   }
  # VALID_PHONE_REGEX = /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/
  # validates :phone, presence: true,
  #                   format: { 
  #                     with: VALID_PHONE_REGEX,
  #                     message: "- Phone numbers must be in xxx-xxx-xxxx format."  
  #                   }

  def downcase_email
    self.email.downcase!
  end
end

