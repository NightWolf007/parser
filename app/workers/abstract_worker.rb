require 'open-uri'

class AbstractWorker
  include Sidekiq::Worker

  def perform(url, partner_id)
    self.items(document(open(url))).each do |item|
      item[:id] = SecureRandom.hex 10
      item[:partner_id] = partner_id
      Item.create item
    end
  end

  def document(io)
  end

  def items(doc)
  end
end
