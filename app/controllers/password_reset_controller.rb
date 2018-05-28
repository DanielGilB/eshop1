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
			flash[:notice] = 'Las intrucciones para resetear su contraseña le han '
			+ ' sido enviadas. Por favor revise su correo.'
			redirect_to :controller => 'user_sessions', :action => 'new'
		else
			@page_title = 'Olvidó su contraseña'
			flash[:notice] = 'No se ha encontrado ningún usuario con esa direccion de correo.'
			render :action => :new
		end
	end

	def edit
		@page_title = 'Actualizar contraseña'
		@user = User.find_using_perishable_token(params[:id])
		unless  @user
			flash[:error] = "Lo siento, no podemos encontrar su cuenta.
							Si no puede usar directamente su URL desde su email
							intente copiarla directamente desde su navegador o
							reinicie el proceso de olvidar contraseña"
			redirect_to :controller => 'user_session', :action => 'new'
		end
	end

	def update
		@user = User.find_by_id(params[:id])
		@user.password = params[:user][:password]
		@user.password_confirmation = params[:user][:password_confirmation]
		if @user.save
			redirect_to :controller => 'user', :action => 'show'
			flash[:notice] = "Contraseña correctamente actualizada."
		else
			@page_title = 'Editar contraseña'
			render :action => 'edit'
		end
	end 
end
