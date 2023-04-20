class AdminMailer < ApplicationMailer

  def new_user_waiting_for_approval
    @user = params[:user]
    mail(to: 'marie.lauwers@maisonsdesassociations.fr',
          cc: 'p-edacquet@hotmail.fr, philippe.nougaillon@gmail.com',
          subject: "#{@user.prénom} #{@user.nom} (#{@user.maison.nom}) est en attente d'approbation").tap do |message|
            message.mailgun_options = {
              "tag" => [ "marie.lauwers@maisonsdesassociations.fr", "Attente approbation"]
            }
          end
  end

  def user_approved
    @user = params[:user]
    mail(to: @user.email, subject: "Votre demande de création de compte a été acceptée.").tap do |message|
      message.mailgun_options = {
        "tag" => [ @user.email, "Utilisateur accepté"]
      }
    end
  end

  def user_not_approved
    @user = params[:user]
    mail(to: @user.email, subject: "Votre demande de création de compte a été refusée.").tap do |message|
      message.mailgun_options = {
        "tag" => [ @user.email, "Utilisateur refusé"]
      }
    end
  end

  def user_unsubscribed
    @contact = params[:contact]
    mail(to: User.testeurs.pluck(:email).join(','), subject: "Un contact s'est désabonné")
  end
end
