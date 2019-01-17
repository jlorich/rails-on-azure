Rails.application.routes.draw do
  get '/', to: 'ignite#show'
  get '*unmatched_route', to: 'application#route_not_found'
end
