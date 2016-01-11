class AddPushedToMainSiteOnArticles < ActiveRecord::Migration
  def change
    add_column :articles, :pushed_to_main_site, :boolean, :default => false
  end
end
