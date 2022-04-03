class Announcement < ApplicationRecord
	after_create :send_notifications
	attr_accessor :announcer
	def send_notifications
		recipients=User.all
		puts "number of recipients #{recipients.count}"
  		recipients.each do |u|
    		Notification.create(actor:self.announcer,recipient_id:u,notifiable:u,action:"A new Announcement has been Posted")
    	end
	end

	def notification_links(notification)
		message = "#{notification.actor.display_name} #{notification.action} #{notification.notifiable.name}"
		path = announcement_show_path(self)
		return message,path
	end
end
