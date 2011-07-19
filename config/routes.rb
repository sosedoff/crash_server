CrashServer::Application.routes.draw do
  root :to         => 'apps#index'
  post 'exception' => 'apps#exception'
  
  resources :apps do
    match 'generate_key' => 'apps#generate_key', :as => 'generate_key'
    
    resources :crashes do
      match 'close' => 'crashes#close', :as => 'close'
    end
  end
end