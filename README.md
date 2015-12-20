# Parser
Test project xml parser.
You must have installed and runned PostgreSQL and Redis servers.
Redis server needed for gem sidekiq.

Before run this project you should run followed instructions from the project folder:
```
bundle install
rake db:create
rake db:migrate
```

For run this project you should run followed instructions from the project folder:
```
rails server
bundle exec sidekiq
```

That will run server on port 3000.
Main project page is {your_ip}:3000.

Project has very simple interface.
For creating new partner click on "New partner" link.
Also you can show, edit and remove each partner by links near each row of the partners table.

After creating or updating partner, server runs background process for parsing file by gem sidekiq.

For creating new formats you should create new file in app/workers directory.
Then in this file describe new class {YourClassName}Worker and inherit it from AbstractWorker class.
This class must override methods "document" and "items".
Method "document" has StringIO io variable and must return parsed doc.
Method "items" has your parsed doc variable and must return array of hashes with fields:
- :title
- :partner_item_id
- :available_in_store

Example of new format class for xml.
```
class XmlWorker < AbstractWorker

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
```

Example of new format class for json.
```
class JsonWorker < AbstractWorker

  def document(io)
    JSON.load io
  end

  def items(doc)
    doc['items'].map do |item|
      {
        title: item['title'],
        partner_item_id: item['id'],
        available_in_store: item['available']
      }
    end
  end
end
```
After that you can use {YourClassName} as xml_type when creating and updating partner.

Results of parsed items you can see on show page of each partner or in PostgreSQL database in table "items".
