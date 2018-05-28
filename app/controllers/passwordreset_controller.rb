class PasswordResetController < ApplicationController
	before_filter :require_no_user

	def new
		@page_title = 'Olvidó su contraseña'
	end

	def create
		@user = User.find_by email: params[:email]
		if @user
			@user.reset_perishable_token!
			Notifier.password_reset_instructions(@user).deliver_now
			flash[:notice] = 'Las intrucciones para resetear su contraseña te han '
			+ ' sido enviadas. Por favor revise su correo.'
			redirect_to :controller => 'user_sessions', :action => 'new'
		else
			@page_title = 'Olvidó su contraseña'
			flash[:notice] = 'No se ha encontrado ningún usuario con esa direccion de correo.'
			render :action => :new
		end
	end
end
