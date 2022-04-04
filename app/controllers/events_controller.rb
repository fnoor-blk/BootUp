class EventsController < ApplicationController
	before_action :set_event, only: [:edit,:update,:delete,:show]
	before_action :set_timeline, only: [:new,:create]

	def new
		@event=Event.new
		render partial: 'events_router.js.erb', locals:{from: :new}
	end

	def create
		@event=Event.new(event_params)
		@event.timeline=@timeline
		@event.author=current_user
		@event.save
		render partial:"events_router.js.erb",locals:{from: :create,notice:"event '#{@event.title}' Created",type:"success"}
	end

	def edit
		@timeline=@event.enabler.timeline
		render partial: 'events_router.js.erb', locals:{from: :edit}
	end

	def update
		@event.update(event_params)
		render partial:"events_router.js.erb",locals:{from: :update,notice:"event '#{@event.title}' Updated",type:"warning"}

	end

	def delete
	end

	def show
		render partial: 'events_router.js.erb', locals:{from: :show}
	end

	private

	def set_event
		@event= Event.find params[:id]
	end

	def set_timeline
		@timeline= Timeline.find params[:timeline_id]
	end

	def event_params
		params.require(:event).permit(:title, :description, :till, :when, :open)
	end
end
