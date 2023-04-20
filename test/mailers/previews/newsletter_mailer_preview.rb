# Preview all emails at http://localhost:3000/rails/mailers/newsletter_mailer
class NewsletterMailerPreview < ActionMailer::Preview

  def weekly
    NewsletterMailer.with(test_mode: true).weekly
  end

end
