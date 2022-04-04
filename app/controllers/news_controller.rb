class NewsController < ApplicationController
  def index
  	associated_timeline_posts = Enabler.news_feed(current_user).includes(:enable).order(created_at: :desc)
    unassociated_timeline_posts = Event.where(open:true).includes(:enabler).map(&:enabler)
    total = (associated_timeline_posts + unassociated_timeline_posts).uniq
    @timeline_posts = Kaminari.paginate_array(total).page(params[:page]).per(10)
  	render partial: 'news.js.erb', locals:{from: :index}
  end
end
