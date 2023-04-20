Rails.application.routes.draw do

  resources :sibs
  mount Thredded::Engine => '/forum'

  get 'membres/index'
  get 'membres/maison'
  get 'membres/espace_personnel'
  resources :slideshow_images
  resources :typologies
  resources :categories
  resources :partenaires

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :evenements do
    member do
      post :publier
      post :promouvoir
      post :archiver
      delete :delete_image_attachment
      get :duplicate
    end
  end
  
  resources :posts do
    member do
      post :publier
      post :promouvoir
      post :archiver
      delete :delete_vignette_attachment
      delete :delete_poster_attachment
    end
  end
  
  resources :publications do
    member do
      post :publier
      post :archiver
    end
  end

  resources :projets do
    member do
      post :publier
      post :archiver
      delete :delete_photo_attachment
      delete :delete_document_attachment
    end
  end

  resources :contacts do
    collection do
      get :unsubscribe
      post :action
      post :do_action
    end
  end
  
  resources :adhesions do
    member do
      post :complet
      post :valider
      post :resilier
      post :archiver
      post :renouveler
    end
  end

  resources :ressources do
    member do
      post :valider
      post :publier
      post :partager
      post :promouvoir
      post :archiver
    end
  end

  resources :cotisations
  resources :audits
  resources :actions
  resources :maisons
  resources :users do
    member do
      get :accepter
      get :refuser
    end
  end

  resources :messages do
    member do
      get :traiter
      get :archiver
    end
  end

  resources :documents

  resources :mail_logs, only: %i[ index show ]

  get 'pages/welcome'

  get 'actualites',         to: 'pages#posts',            as: :actualites
  get 'agenda',             to: 'pages#evenements',       as: :agenda
  get 'les_maisons',        to: 'pages#maisons',          as: :les_maisons
  get 'les_ressources',     to: 'pages#ressources',       as: :les_ressources
  get 'nos_publications',   to: 'pages#publications',     as: :nos_publications
  get 'le_reseau',          to: 'pages#reseau',           as: :le_reseau
  get 'recherche',          to: 'pages#recherche',        as: :recherche
  get 'newsletter',         to: 'pages#newsletter',       as: :newsletter
  get 'mentions_legales',   to: 'pages#mentions_légales', as: :mentions_legales
  get 'centre_ressources',  to: 'pages#ressources',       as: :centre_ressources
  get 'nos_actions',        to: 'pages#projets',          as: :nos_actions

  get 'admin/index'
  get 'admin/memo'
  get 'admin/send_weekly_test'
  get 'admin/admin_lettre_hebdo'
  get 'admin/send_lettre_hebdo'

  root 'pages#welcome'
end
