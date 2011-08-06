class Article < ActiveRecord::Base
	belongs_to :category
	has_many :comments, :dependent => :destroy 
	validates_presence_of :title,:body,:category_id
	#validates_uniqueness_of :title
	#before_save :generate_permalink, :only => 'create'
	
	# 	protected
	# 	def generate_permalink
	# 		self.permalink = title.downcase.gsub(/\W/,'-').gsub(/-+/,'-')
	# 	end
end
