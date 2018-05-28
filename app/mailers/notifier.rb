class Notifier < ActionMailer::Base
  default from: 'INEs music'

  def password_reset_instructions(user)
    @user = user
    @subject = 'Reinicio de contraseña.'
    @sent_on = Time.now
    #default host is defined in development.rb configuration file
    @edit_password_reset_url = url_for :controller => 'password_reset', :action => 'edit'
    @edit_password_reset_url += "?id=#{user.perishable_token}"
    mail to: user.email
  end
end
