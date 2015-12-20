require 'open-uri'

class AbstractWorker
  include Sidekiq::Worker

  def perform(url, partner_id)
    self.items(document(open(url))).each do |item_params|
      old_item = Item.find_by partner_id: partner_id, partner_item_id: item_params[:partner_item_id]
      if old_item
        old_item.update_attributes item_params
      else
        item_params[:id] = SecureRandom.hex 6
        item_params[:partner_id] = partner_id
        Item.create item_params
      end
    end
  end

  # must return parsed document
  def document(io)
  end

  # must return array of hashs with fields:
  # title
  # partner_item_id
  # available_in_store
  def items(doc)
  end
end
