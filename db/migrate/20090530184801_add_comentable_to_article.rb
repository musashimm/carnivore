class AddComentableToArticle < ActiveRecord::Migration
  def self.up
	add_column :articles, :comentable, :boolean
  end

  def self.down
	remove_column :articles, :comentable
  end
end
