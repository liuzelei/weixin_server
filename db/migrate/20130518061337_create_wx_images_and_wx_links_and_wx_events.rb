class CreateWxImagesAndWxLinksAndWxEvents < ActiveRecord::Migration
  def up
    create_table :wx_images do |t|
      t.references :weixin_user
      t.string :pic_url
      t.timestamps
    end
    create_table :wx_links do |t|
      t.references :weixin_user
      t.string :title
      t.text :description
      t.string :url
      t.timestamps
    end
    create_table :wx_events do |t|
      t.references :weixin_user
      t.string :event
      t.string :event_key
      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
