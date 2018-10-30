Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'top_headlines', to: "alexa_skill_headlines#top_headlines"
end
