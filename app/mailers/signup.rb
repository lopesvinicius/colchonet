class Signup < ActionMailer::Base

	default from: 'viniciuslopeslps@gmail.com'

	def confirm_email(user)
		@user = user
		
		@confirmation_link = confirmation_url({
			token: @user.confirmation_token
		})

		mail({
			to: user.email,
			bcc: ['sign ups <viniciuslopeslps@gmail.com>'],
			subject: 'Colcho.net - Confirme seu email'
		})
	end

end