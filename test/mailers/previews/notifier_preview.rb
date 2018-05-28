# Preview all emails at http://localhost:3000/rails/mailers/notifier
class NotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifier/pasword_reset_instructions
  def pasword_reset_instructions
    Notifier.pasword_reset_instructions
  end

end
