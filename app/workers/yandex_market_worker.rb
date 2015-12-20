class YandexMarketWorker < AbstractWorker

  def document(io)
    Nokogiri::XML io
  end

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
