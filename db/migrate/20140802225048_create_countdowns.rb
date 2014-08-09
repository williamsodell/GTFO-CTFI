class CreateCountdowns < ActiveRecord::Migration
  def change
    create_table :countdowns do |t|
      t.string :twitter_id
      t.string :name
      t.string :image
      t.string :hashtag
      t.datetime :start_date
      t.datetime :end_date
      t.string :title
      t.text :start_description
      t.text :end_description

      t.timestamps
    end
    add_index :countdowns, :twitter_id
    add_index :countdowns, :name
  end
end
