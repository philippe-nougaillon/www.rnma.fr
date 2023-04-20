class AdminController < ApplicationController
  before_action :is_user_authorized

  def index
    @unapproved_users_count = User.where(approved: false).count
    @new_messages_count = Message.nouveau.count

    # Compte combien de nouvelles actualités ont été créées par des membres
    @member_contents_count = 0
    Post.nouveau.where(type_actu: 1).each do |post|
      @member_contents_count += 1 if post.audits.first.user.membre?
    end

  end

  def memo
  end

  def send_weekly_test
    contacts = User.testeurs

    if params[:equipe]
      contacts += User.equipe
      contacts += User.ca

      contacts.each do |contact|
        mailer_response = NewsletterMailer.with(contact_email: contact.email).weekly.deliver_now
        MailLog.create(from: current_user.nom, message_id:mailer_response.message_id, to: contact.email, subject: "Weekly newsletter test")
        flash[:notice] = "Lettre hebdo envoyée à l'équipe"
      end

    else

      mailer_response = NewsletterMailer.with(test_mode: true).weekly.deliver_now
      MailLog.create(from: current_user.nom, message_id:mailer_response.message_id, to: User.testeurs.pluck(:email).join(', '), subject: "Weekly newsletter test")
      flash[:notice] = "Lettre hebdo de TEST envoyée aux testeurs."
    end
    redirect_to admin_index_path
  end

  def admin_lettre_hebdo
    @abonnés = Contact.abonné
  end

  def send_lettre_hebdo
    require 'rake'

    Rake::Task.clear # necessary to avoid tasks being loaded several times in dev mode
    Rails.application.load_tasks # providing your application name is 'sample'
      
    Rake::Task['newsletter:envoyer'].reenable # in case you're going to invoke the same task second time.
    Rake::Task['newsletter:envoyer'].invoke

    redirect_to admin_admin_lettre_hebdo_path, notice: "Lettre hebdo envoyée à tous les abonnés"
  end

  private

  def is_user_authorized
    authorize :admin
  end
end
