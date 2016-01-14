class User < ActiveRecord::Base
	EMAIL_REGEX = /\A[^@]+@([^@\.]+\.)+[^@\.]+\Z/

	validates_format_of :email, with: EMAIL_REGEX
	validates_presence_of :email, :full_name, :location
	validates_length_of :bio, minimum: 30, allow_blank: false
	validates_uniqueness_of :email

	has_secure_password
end
