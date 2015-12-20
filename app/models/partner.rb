class Partner < ActiveRecord::Base
  validates :xml_url, presence: true
  validates :xml_type, presence: true

  has_many :items, dependent: :delete_all
end
