class Countdown < ActiveRecord::Base
	validates_uniqueness_of :name, :case_sensitive => false
	before_save :before_save

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ':placeholder'
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :image, :attachment_presence => true
	validates_with AttachmentPresenceValidator, :attributes => :image
	validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 10.megabytes

	def before_save
		name.downcase!
	end
	
	def tweets
		client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
			config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
		end

		i = 0

		begin
			client.search("\##{hashtag}", :result_type => "recent").take(25).collect do |tweet|
				{:name => "#{tweet.user.screen_name}", :text => "#{tweet.text}"}
			end
		rescue Twitter::Error => error
			i += 1
			retry if i < 2
			[]
		end
	end
end
