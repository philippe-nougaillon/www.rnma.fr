# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def new_user_waiting_for_approval
    # mail(to: "marie@RNMA.fr", subject: 'Welcome to My Awesome Site')
    AdminMailer.with(user: User.first).new_user_waiting_for_approval
  end
end
