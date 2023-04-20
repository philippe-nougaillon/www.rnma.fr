class PostMailer < ApplicationMailer
  def send_new_member_post_notification
    mail(to: 'marie.lauwers@maisonsdesassociations.fr', 
      subject: "Une nouvelle actualité vient d'être créée par un membre !").tap do |message|
        message.mailgun_options = {
          "tag" => [ "marie.lauwers@maisonsdesassociations.fr", "Nouvelle actualité d'un membre"]
        }
      end
  end
end
