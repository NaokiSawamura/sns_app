class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string      :name
      t.text        :text
      t.text        :image
      t.timestamps  null: true
    end
  end
end
