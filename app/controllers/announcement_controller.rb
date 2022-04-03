class AnnouncementController < ApplicationController
  before_action :set_announcement, only: [:show]
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
  	@announcement.user_id = current_user.id
  	@announcement.save
  	index()
  end

  def show
    render partial:"announcement_router.js.erb",locals:{from: :show}
  end


  private

  def set_announcement
    @announcement= Announcement.find params[:id]
  end

  def annnouncement_params
    params.require(:announcement).permit(:title, :content)
  end
end
