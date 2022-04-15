class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  scope :newest, -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
  validate  :validate_max_size_of_image,
            :validate_content_tpye_of_image
end

private

  def validate_max_size_of_image
    return if self.image.blob.byte_size <= 5*1024*1024

    self.errors.add(:image, :file_maximum)
  end

  def validate_content_tpye_of_image
    return true if options[:content].nil?

    case options[:content]
    when Regexp
      options[:content].match?(blob.content)
    when Array
      options[:content_].include?(blob.content)
    when Symbol
      blob.public_send("#{options[:content]}?")
    else
      options[:content] == blob.content
    end
  end