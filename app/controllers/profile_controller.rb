class ProfileController < ApplicationController
  def update
  	@profile=current_user.profile
  	@profile.update(profile_params)

  	#byebug
  end

  def edit
  	if current_user.profile.present?
  		@profile=current_user.profile
  	else
  		@profile=Profile.create(user:current_user)
  	end
  	render partial:"router.js.erb",locals:{from: :edit}
  end

  def show
  end
  def image
  	@image=Image.new
    @image.location=params[:file]
    @image.imageable=current_user.profile
    @image.save!
    render partial:"router.js.erb",locals:{from: :image}
  end

  def make_dp
    @image=Image.find(params[:id])
    @image.update(latest:true)
    render partial:"router.js.erb",locals:{from: :make_dp}
  end
  def profile_image_carousel
    @images=current_user.images
    render partial:"router.js.erb",locals:{from: :profile_image_carousel}
  end
  def close_carousel
    render partial:"router.js.erb",locals:{from: :edit}
  end

  def update_bio
    current_user.profile.update_attribute(:bio, params[:update_text])
    render partial:"router.js.erb",locals:{from: :update_bio}
  end
  private 
  	def profile_params
      params.require(:profile).permit(:first_name, :last_name,:dob,:country)
    end
end
