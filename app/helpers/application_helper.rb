module ApplicationHelper
	def profile_display_image(user)
		user_profile=user.profile_image
	    user_profile=user_profile.empty? ? asset_path("default_logos/default_profile.png") : user_profile
	end

	def cover_display_image(user)
		user_cover=user.cover_image
	    user_cover=user_cover.empty? ? "https://ununsplash.imgix.net/photo-1431578500526-4d9613015464?fit=crop&fm=jpg&h=300&q=75&w=400" : user_cover
	end
	
	def bio_display user
		(user.profile.bio.nil?) ? "My Bio" : user.profile.bio
	end
end
