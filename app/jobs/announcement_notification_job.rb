class AnnouncementNotificationJob < ApplicationJob
  queue_as :urgent

  def perform(announcement)
    actor = User.find(announcement.user_id)
  	recipients=User.all
      recipients.each do |u|
        Notification.create!(actor:actor,recipient_id:u.id,notifiable:announcement,action:"A new Announcement has been Posted")
      end
  end
end
