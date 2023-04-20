namespace :newsletter do
  desc "Envoyer un récap hebdomadaire aux abonnés"
  task envoyer: :environment do
    puts "A"
    contacts = Contact.abonné
    puts contacts.count
    contacts.each do |contact|
      puts contact.email
      mailer_response = NewsletterMailer.with(contact_email: contact.email).weekly.deliver_now
      MailLog.create(from: "Système", message_id:mailer_response.message_id, to: contact.email, subject: "Weekly newsletter")
    end
  end
end