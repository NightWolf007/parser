require 'open-uri'

class YandexMarketWorker
  include Sidekiq::Worker

  def perform(url, partner_id)
    self.items(document(open(url))).each do |item|
      item[:partner_id] = partner_id
      Item.create item
    end
  end

  def document(io)
    Nokogiri::XML io
  end

  def items(doc)
    doc.css('item').map do |item|
      {
        id: item.attr('id'),
        available_in_store: item.attr('available'),
        partner_item_id: item.attr('id'),
        title: item.css('title').text
      }
    end
  end
end
