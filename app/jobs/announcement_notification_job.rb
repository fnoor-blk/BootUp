class AnnouncementNotificationJob < ApplicationJob
  queue_as :urgent

  def perform(announcement)
  	recipients=User.all
  	recipients.each do |u|
    	Notification.create(actor:announcement.announcer,recipient_id:u,notifiable:u,action:"A new Announcement has been Posted")
    end
  end
end
