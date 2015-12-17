class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :xml_url, null: false
      t.string :xml_type, null: false
      t.timestamps null: false
    end
  end
end
