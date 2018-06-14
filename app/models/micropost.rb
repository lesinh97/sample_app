class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.post_lenght}
  validate :picture_size
  scope :odering, ->{order(created_at: :desc)}
  scope :feed, ->(following_ids, id){where "user_id IN (?) OR user_id = ?", following_ids, id}
  mount_uploader :picture, PictureUploader

  private

  def picture_size
    return unless picture.size > Settings.max_picture_size.megabytes
    errors.add :picture, I18n.t("picture_out_size")
  end
end
