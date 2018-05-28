require File.dirname(__FILE__) + '/../test_helper'

class NotifierTest < ActionMailer::TestCase
  test "pasword_reset_instructions" do
  	@user=User.create(:name=>'GeorgeJackson',
  					:login=>'George',
  					:email=>'salkerps3@gmail.com',
					:password=>'silver',
					:password_confirmation=>'silver')
    mail = Notifier.pasword_reset_instructions(@user)
    assert_equal "Pasword reset instructions", mail.subject
    assert_equal ["salkerps3@gmail.com"], mail.to
    assert_equal ["INEs Music"], mail.from
    assert_match "Querido #{@user.name}:",mail.body.encoded
	@edit_password_reset_url =
		"http://localhost:3000/password_reset/edit?id=#{@user.perishable_token}"
	@link =
		"<ahref=\"#{@edit_password_reset_url}\">#{@edit_password_reset_url}"
	assert_match @link, mail.body.encoded
  end
end
