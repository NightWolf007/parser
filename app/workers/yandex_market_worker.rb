class YandexMarketWorker < AbstractWorker
  def document(io)
    Nokogiri::XML io
  end

  def items(doc)
    doc.css('item').map do |item|
      {
        available_in_store: item.attr('available'),
        partner_item_id: item.attr('id'),
        title: item.css('title').text
      }
    end
  end
end
