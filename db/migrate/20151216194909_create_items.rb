class CreateItems < ActiveRecord::Migration
  def change
    create_table :items, id: false do |t|
      t.string :id, null: false
      t.belongs_to :partner, null: false, index: true
      t.boolean :available_in_store, null: false, default: false
      t.string :partner_item_id, null: false
      t.string :title, default: nil
    end

    add_index :items, :id, unique: true
  end
end
