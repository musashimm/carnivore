class AddMainToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :main, :boolean
	Article.all.each do |a|
    	puts a.id
        a.main = false
        a.save
    end
  end

  def self.down
    remove_column :articles, :main
  end
end
