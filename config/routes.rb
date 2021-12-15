Rails.application.routes.draw do
  get 'postres/index' => 'postres#index'
  get 'postres/leer/:url', to: 'postres#leer'
  get 'postres/crear' => 'postres#crear'
  get 'postres/actualizar/:id' => 'postres#actualizar'
  post 'postres/insertar' => 'postres#insertar'
  post 'postres/editar/:id', to: 'postres#editar'
  post 'postres/eliminar/:id', to: 'postres#eliminar'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
