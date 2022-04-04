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

	def moderate_post_permission(post,timeline)
		return (post.enabler.author == current_user) ? true : ((timeline.timeable_type=="Club") ? ((timeline.timeable.owner == current_user.id) ? true : timeline.timeable.has_admin?(current_user) ? true : false ): (timeline.timeable_id==current_user.id ? true : false))
	end

	def get_enabler_obj_path(enabler_obj, action)
		case enabler_obj.class.to_s
		when "Blog"
			if action == 'open'
				return blog_path(enabler_obj)
			elsif action == 'edit'
				return edit_blog_path(enabler_obj)
			end
		when "Event"
			if action == 'open'
				return event_path(enabler_obj)
			elsif action == 'edit'
				return edit_event_path(enabler_obj)
			end
		end	
	end
end
