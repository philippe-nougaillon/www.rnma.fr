class MessageMailer < ApplicationMailer
  def notification
    @message = params[:message]
    mail(to: 'contact.rnma@maisonsdesassociations.fr', subject: "Un nouveau message via 'Nous contacter' est arrivé").tap do |message|
      message.mailgun_options = {
        "tag" => [ "contact.rnma@maisonsdesassociations.fr", "Nouveau message"]
      }
    end
  end

  def notification_contact
    @message = params[:message]
    mail(to: @message.email, subject: 'Votre message au RNMA a bien été pris en compte.').tap do |message|
      message.mailgun_options = {
        "tag" => [ @message.email, "Message pris en compte"]
      }
    end
  end
end
