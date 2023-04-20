class User < ApplicationRecord
  audited

  belongs_to :maison, optional: true
  has_one_attached :photo

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :rememberable
  devise :database_authenticatable, 
         :registerable,
         :recoverable,
         :validatable,
         :trackable
        #  :lockable
        #  :confirmable
         #:timeoutable

  validates :nom, :prénom, presence: true
  scope :equipe, -> { where(admin: true)
                      .where.not(fonction: nil)
                      .where.not(fonction: "")
                      .reorder(:poids) }

  scope :ca, -> { where(fonction: "CA")
                  .reorder(:poids) }

  scope :testeurs, -> { where(email: [
      "p-edacquet@hotmail.fr", 
      "philippe.nougaillon@gmail.com",
      "marie.lauwers@maisonsdesassociations.fr"
      ]) 
    }

  default_scope { order('users.id DESC') }

  after_create :send_admin_mail

  validates :nom, uniqueness: true

  # Approbation
  def active_for_authentication? 
    super && approved? 
  end 
  
  def inactive_message 
    approved? ? super : :not_approved
  end

  def send_admin_mail
    mailer_response = AdminMailer.with(user: self).new_user_waiting_for_approval.deliver_now
    MailLog.create(from: "Système", message_id: mailer_response.message_id, to: 'marie.lauwers@maisonsdesassociations.fr', subject: "Attente approbation")
  end

  # def after_confirmation
  #   UserMailer.welcome_email(self).deliver_now
  # end

  # Pas déplaçable dans le décorator, prénom_nom est appelé dans la config du forum
  def prénom_nom
    "#{self.prénom} #{self.nom}"
  end

  # Retourne soit la maison saisie par l'utilisateur lors de son inscription, 
  # soit par, rapprochement avec l'email, à la maison qui l'a comme contact, 
  # TODO: renommer la fonction
  def mda
    if self.maison_id
      self.maison
    elsif contact = Contact.find_by("LOWER(email) = ?", self.email.downcase)
      if contact.maison_id
        Maison.unscoped.find(contact.maison_id)
      end
    end
  end

  def membre?
    !self.admin?
  end

  def testeur?
    User.testeurs.include?(self)
  end

  def gravatar_hash
    "http://www.gravatar.com/avatar/" + Digest::MD5.hexdigest(self.email)
  end
end
