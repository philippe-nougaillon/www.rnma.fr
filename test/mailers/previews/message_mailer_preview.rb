# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview
  def notification
    # mail(to: "marie@RNMA.fr", subject: 'Welcome to My Awesome Site')
    MessageMailer.with(message: Message.first).notification
  end
  def notification_contact
    # mail(to: "marie@RNMA.fr", subject: 'Welcome to My Awesome Site')
    MessageMailer.with(message: Message.first).notification_contact
  end
end
