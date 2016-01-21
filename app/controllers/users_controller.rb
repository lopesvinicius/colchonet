class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		set_user
	end
	
	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			Signup.confirm_email(@user).deliver

			redirect_to @user, notice: 'Successfully registered!'
		else
			render action: :new
		end
	end

	def edit
		set_user
	end

	def update
		set_user

		if @user.update(user_params)
			redirect_to @user,
			notice: 'Succesfully changed!'
		else
			render action: :edit		
		end	
	end

	def destroy
		set_user
	    @user.destroy
	    redirect_to @user,
			notice: 'Succesfully deleted!'
 	end

 	private
 	def set_user
 		@user = User.find(params[:id])
 	end

	private
	def user_params
		params.
			require(:user).
			permit(:email, :full_name, :location, :password, :password_confirmation, :bio)
	end
end