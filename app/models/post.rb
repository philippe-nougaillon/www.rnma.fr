class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :titre, use: :slugged

  include Workflow
  include WorkflowActiverecord

  include PgSearch::Model
  multisearchable against: [:titre, :chapeau],
                  if: :searchable?

  audited

  has_one_attached :vignette
  has_one_attached :poster
  has_rich_text :contenu

  default_scope -> { order(created_at: :desc) }

  paginates_per 20

  enum type_actu: [ :Réseau, :Territoires, :Secteur ]

  scope :réseau, -> { where(type_actu: 0) }
  scope :territoires, -> { where(type_actu: 1) }
  scope :secteur, -> { where(type_actu: 2) }
  scope :dernière_quinzaine, -> { where(created_at: 15.days.ago..Date.tomorrow) }

  after_create :send_new_member_post_notification, if: Proc.new { self.audits.first.user.membre? }

  # WORKFLOW
  NOUVEAU  = 'nouveau'
  PUBLIE   = 'publié'
  PROMU   = 'promu'
  ARCHIVE  = 'archivé'

  scope :nouveau, -> { where(workflow_state: NOUVEAU )}
  scope :publié, -> { where(workflow_state: PUBLIE ).or(where(workflow_state: PROMU))}
  scope :promu, -> { where(workflow_state: PROMU )}

  workflow do
    state NOUVEAU, meta: { style: 'is-info' } do
      event :publier, transitions_to: PUBLIE
    end

    state PUBLIE, meta: { style: 'is-success' } do
      event :archiver, transitions_to: ARCHIVE
      event :promouvoir, transitions_to: PROMU
    end

    state PROMU, meta: { style: 'is-warning' } do
      event :archiver, transitions_to: ARCHIVE
    end

    state ARCHIVE, meta: { style: 'is-secondary' } do 
      event :publier, transitions_to: PUBLIE
    end
  end

  # pour que le changement se voit dans l'audit trail
  def persist_workflow_state(new_value)
    self[:workflow_state] = new_value
    save!
  end

  def searchable?
    (self.workflow_state >= PUBLIE) && !(self.membres)
  end

  private

  def send_new_member_post_notification
    mailer_response = PostMailer.send_new_member_post_notification.deliver_now
    MailLog.create(from: "Système", message_id: mailer_response.message_id, to: 'marie.lauwers@maisonsdesassociations.fr', subject: "Nouvelle actualité d'un membre")
  end

end
