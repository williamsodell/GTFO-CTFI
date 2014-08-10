class AddSiteToCountdowns < ActiveRecord::Migration
  def change
    add_column :countdowns, :site, :string
  end
end