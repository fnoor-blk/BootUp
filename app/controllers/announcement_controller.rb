class AnnouncementController < ApplicationController

  def index
  	@announcements = Announcement.all.page(params[:page]).per(10)
  	render partial:"announcement_router.js.erb",locals:{from: :index}
  end

  def new
  	@announcement = Announcement.new
  	render partial:"announcement_router.js.erb",locals:{from: :new}
  end
  def create
  	@announcement = Announcement.new(annnouncement_params)
  	@announcement.announcer = current_user
  	@announcement.save
  	index()
  end

  def show
  end


  private

  def set_announcement
    @blog= Blog.find params[:id]
  end

  def annnouncement_params
    params.require(:announcement).permit(:title, :content)
  end
end
