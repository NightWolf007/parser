class JsonWorker < AbstractWorker

  def document(io)
    JSON.load io
  end

  def items(doc)
    doc['items'].each do |item|
      {
        title: item['title'],
        partner_item_id: item['id'],
        available_in_store: item['available']
      }
    end
  end
end
