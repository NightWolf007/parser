class Item < ActiveRecord::Base
  self.primary_key = 'id'

  validates :id, presence: true
  validates :partner_id, presence: true
  validates :available_in_store, :inclusion => { :in => [true, false] }
  validates :partner_item_id, presence: true

  belongs_to :partner
end
