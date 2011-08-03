class AddKeywordsToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :keywords, :string
  end

  def self.down
    remove_column :articles, :keywords
  end
end
