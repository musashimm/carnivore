class Comment < ActiveRecord::Base
	belongs_to :article
	validates_presence_of :author,:body
	validates_length_of :author, :maximum=>30
	validates_length_of :body, :maximum=>400
	apply_simple_captcha
end
