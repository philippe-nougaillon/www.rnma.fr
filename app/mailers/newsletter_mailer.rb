class NewsletterMailer < ApplicationMailer

  def weekly
    @posts = Post.dernière_quinzaine.promu
    @events = Evenement.promu.reorder(:debut)
    @ressources = Ressource.promue.fraiche
    @forum_topics_reseau = Thredded::Topic.joins(:messageboard)
                              .where("thredded_topics.updated_at > (now() - interval '7 days')")
                              .where("thredded_messageboards.name = 'ALLO RESEAU ?!'")
    @forum_topics_vie_asso = Thredded::Topic.joins(:messageboard)
                              .where("thredded_topics.updated_at > (now() - interval '7 days')")
                              .where("thredded_messageboards.name = 'Commission Vie Asso'")
    @forum_topics_equipages = Thredded::Topic.joins(:messageboard)
                              .where("thredded_topics.updated_at > (now() - interval '7 days')")
                              .where("thredded_messageboards.name ILIKE 'équipage%'")

    @forum_topics = Thredded::Topic.joins(:messageboard)
                    .where("thredded_topics.updated_at > (now() - interval '7 days')")
                    .where.not("thredded_messageboards.name = 'ALLO RESEAU ?!'")
                    .where.not("thredded_messageboards.name = 'Commission Vie Asso'")
                    .where.not("thredded_messageboards.name ILIKE 'équipage%'")
    @test_mode = params[:test_mode]
    @contact_email = params[:contact_email]

    if @test_mode
      mail(to: User.testeurs.pluck(:email), subject: "RNMA - TEST Lettre hebdomadaire").tap do |message|
        message.mailgun_options = {
          "tag" => [ "testeurs", "test weekly newsletter"]
        }
      end
    else
      mail(to: @contact_email, subject: "RNMA - Lettre hebdomadaire").tap do |message|
        message.mailgun_options = {
          "tag" => [ @contact_email, "Weekly newsletter"]
        }
      end
    end
  end

end
