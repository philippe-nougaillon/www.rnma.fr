# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.rnma.fr"
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add le_reseau_path, :priority => 0.9
  add les_maisons_path, :priority => 0.9
  add nos_actions_path, :priority => 0.9
  add actualites_path, :priority => 0.9
  add agenda_path, :priority => 0.9
  add les_ressources_path, :priority => 0.9

  # Post.find_each do |post|
  #   add post_path(post), :lastmod => post.updated_at
  # end

  # Evenement.find_each do |evenement|
  #   add evenement_path(evenement), :lastmod => evenement.updated_at
  # end

  # Projet.find_each do |projet|
  #   add projet_path(projet), :lastmod => projet.updated_at
  # end

  # Ressource.find_each do |ressource|
  #   add ressource_path(ressource), :lastmod => ressource.updated_at
  # end
  
end
