# Preview all emails at http://localhost:3000/rails/mailers/notifier
class NotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifier/pasword_reset_instructions
  def pasword_reset_instructions
  	User.first.reset_perishable_token!
    Notifier.password_reset_instructions(User.first)
  end

end
