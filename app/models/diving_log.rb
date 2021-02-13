class DivingLog < ApplicationRecord
  belongs_to :user
  default_scope -> { order(entry_time: :desc) }
  validates :user_id, presence: true
  validates :dive_number, presence: true
  validates :address, presence: true
  validates :entry_time , presence: true
  validates :exit_time , presence: true
  validates :entry_bar , presence: true
  validates :exit_bar , presence: true
  validates :ave_depth , presence: true
  validates :max_depth , presence: true

  mount_uploaders :images, ImageUploader
  serialize :images, JSON #develop, test環境でSQLiteを使用しているため
  geocoded_by :address
  before_validation :geocode, if: :address_changed?

end
