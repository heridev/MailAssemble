namespace :autoresponder do

  # Let's execute this rake each 10 minutes
  desc 'Sends pending follow ups each 10 minutes'
  task :send_scheduled_follow_ups => :environment do
    timezone_now = Time.zone.now
    starting_with = timezone_now - 7.minutes
    finishing_with = timezone_now + 7.minutes

    scheduled_followups = FollowUpSchedule.where(run_at: starting_with..finishing_with)
                                          .where(state: 'created')
                                          .includes(:follow_up)

    scheduled_followups.find_each do |scheduled|
      manager = Autoresponder::Jobs::FollowUpManagerJob.new(scheduled.follow_up.email_list.id)
      manager.send_email_notification(scheduled.follow_up_id, scheduled.subscriber_id, scheduled.id)
    end
  end

  # Let's run this rake each 30 minutes in case that the previous
  # scheduler or cron job fails we can send those this time.
  desc 'Sends old follow ups'
  task :send_oldest_follow_ups => :environment do
    timezone_now = Time.zone.now
    starting_with = timezone_now - 8.hours
    finishing_with = timezone_now - 20.minutes

    oldest_followups = FollowUpSchedule.where(run_at: starting_with..finishing_with)
                                       .where(state: 'created')
                                       .includes(:follow_up)

    oldest_followups.find_each do |scheduled|
      manager = Autoresponder::Jobs::FollowUpManagerJob.new(scheduled.follow_up.email_list.id)
      manager.send_email_notification(scheduled.follow_up_id, scheduled.subscriber_id, scheduled.id)
    end
  end
end

