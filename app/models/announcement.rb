class Announcement < ApplicationRecord
	after_create :send_notifications
	def send_notifications
		AnnouncementNotificationJob.perform_later(self)
	end

	def notification_links(notification)
		message = "A new Notification has been Posted"
		path = announcement_path(self)
		return message,path
	end
end
