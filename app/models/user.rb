class User < ActiveRecord::Base
	EMAIL_REGEX = /\A[^@]+@([^@\.]+\.)+[^@\.]+\Z/

	scope :confirmed, -> { where.not(confirmed_at: nil) }
	
	validates_format_of :email, with: EMAIL_REGEX
	validates_presence_of :email, :full_name, :location
	validates_length_of :bio, minimum: 30, allow_blank: false
	validates_uniqueness_of :email

	has_secure_password

	before_create do |user|
		user.confirmation_token = SecureRandom.urlsafe_base64
	end
	def confirm!
		return if confirmed?
		
		self.confirmed_at = Time.current
		self.confirmation_token = ''
		save!
	end

	def confirmed?
		confirmed_at.present?
	end

	def self.authenticate(email, password)
		user = confirmed.find_by(email: email)
		if user.present?
			user.authenticate(password)
		end
	end
end
