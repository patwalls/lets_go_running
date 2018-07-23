Rails.application.routes.draw do
  root 'welcome#index'

  post "/log", to: "logs#log"
end
