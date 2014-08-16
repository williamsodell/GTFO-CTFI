class AddAttachmentImageToCountdowns < ActiveRecord::Migration
  def self.up
  	remove_column :countdowns, :image
  	
    change_table :countdowns do |t|
      t.attachment :image
    end
  end
end
