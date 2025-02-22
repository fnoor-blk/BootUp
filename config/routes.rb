 Rails.application.routes.draw do
  	resources :announcement do
				
  	end
  	get 'news/index',as:'news'
	require 'sidekiq/web'
	authenticate :user, lambda { |u| u.roles.include? :admin } do
		mount Sidekiq::Web => '/sidekiq'
	end
	mount Ckeditor::Engine => '/ckeditor'
	mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
	resources :notifications,except: [:new, :create, :edit, :update, :destroy, :show] do 
		collection do
			post 'seen',to:'notifications#seen'
		end
	end

	resources :friendship do
		collection do
			get 'allUsers'
			get 'blockedUsers'
			get 'pendingUsers'
		end
		member do 
			get 'showUser'
			get 'addFriend'
			post 'decision/:status/:received_from',to:'friendship#decision',as:"decision"
			post 'block'
			post 'unblock'
			post 'unfriend'
		end
	end

	resources :comments,except: [:index,:new, :create, :edit, :update, :destroy, :show]do
		collection do
			get 'index/:id',to:'comments#index',as: :all
		end
		member do
			get 'new',to:'comments#new', as: :new
			post 'create',to:'comments#create', as: :create
		end
	end
	resources :communities do
		collection do
			get 'public',to:'communities#public'
			get 'private',to:'communities#private_club'
			get 'owned',to:'communities#owned_club'
			post 'toggle_club_admin'
		end
		member do 
			post 'join',to:'communities#join_public'
			post 'requested',to:'communities#ask_private'
			post 'approve_invite/:invitee_id/:status/:invitation',to:'communities#approve_invite',as:"accept_member_into"
			get 'posts'
			get 'members'
			get 'boss'
			get 'invitations'
		end
	end
	 
	resources :profile, except: [:new, :create, :edit, :update, :destroy, :index] do
		collection do
		  patch 'update'
		  get 'edit'
		  post 'update_bio'
		  get "profile_image_carousel",as:"profile_carousel"
		  post "image",as:'image_upload'
		  get 'close_carousel',as:"close_carousel"
		  post 'dp/:id',to:'profile#make_dp',as:"make_profile_image"
		  get "cover_image_carousel",as:"cover_carousel"
		  post "cover_image",as:'cover_image_upload'
		  get 'close_carousel_cover',as:"close_carousel_cover"
		  post 'cover/:id',to:'profile#make_cover',as:"make_cover_image"
		end
	end

	resources :preferences do
		collection do
		  get 'change_panel_color'
		  get 'toggle_background_image'
		  get 'toggle_right_panel'
		  get 'set_background_image'
		end
	end

	resources :blogs do
	end

	resources :events do
		
	end
	
	devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}
	root "communities#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
