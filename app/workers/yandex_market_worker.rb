class YandexMarketWorker < AbstractWorker

  # must return parsed document
  def document(io)
    Nokogiri::XML io
  end

  # must return array of hashs with fields:
  # title
  # partner_item_id
  # available_in_store
  def items(doc)
    doc.css('item').map do |item|
      {
        title: item.css('title').text,
        partner_item_id: item.attr('id'),
        available_in_store: item.attr('available')
      }
    end
  end
end
