class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :content
      t.timestamps
      t.integer :user_id
    end
  end
end
# config.active_record.default_timezone = :local
