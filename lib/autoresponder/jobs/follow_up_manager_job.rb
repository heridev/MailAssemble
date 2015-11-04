module Autoresponder
  module Jobs
    class FollowUpManagerJob

      def initialize(email_list_id)
        @email_list_id = email_list_id
      end

      def send_email_notification(follow_up_id, subscriber_id, scheduled_id)
        manager = Autoresponder::FollowUpSchedulerManager.new(@email_list_id)
        manager.process_follow_up(follow_up_id, subscriber_id, scheduled_id)
      end

      handle_asynchronously :send_email_notification, queue: 'notifications'

      def send_first_email_notification(subscriber_id)
        manager = Autoresponder::FollowUpSchedulerManager.new(@email_list_id)
        manager.process_first_follow_up(subscriber_id)
      end

      handle_asynchronously :send_first_email_notification, queue: 'notifications'

    end
  end
end

