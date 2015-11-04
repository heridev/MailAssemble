module Autoresponder
  class FollowUpSchedulerManager

    MINUTES_AFTER_MIDNIGHT = 1

    def initialize(email_list_id)
      find_email_list(email_list_id)
    end

    def find_email_list(list_id)
      @email_list ||= EmailList.find_by(id: list_id)
    end

    def process_follow_up(follow_up_id, subscriber_id, scheduled_id)
      follow_up = FollowUp.find_by(id: follow_up_id)
      scheduled = FollowUpSchedule.find_by(id: scheduled_id)
      subscriber = Subscriber.find_by(id: subscriber_id)

      # in case the subscriber was removed we are
      # not sending the follow ups anymore
      if follow_up && subscriber
        begin
          scheduled.process!

          FollowUpMessageMailer.send_email(follow_up, subscriber).deliver

          # By default we'd want to schedule the second notification if exists
          schedule_next(follow_up.id, subscriber_id) if find_next_scheduled(follow_up.id)
          scheduled.finish!
        rescue => e
          Rails.logger.error "================ Error while sending process follow ups #{e.inspect}============"
          scheduled.error!
        end
      end
    end

    def process_first_follow_up(subscriber_id)
      follow_ups = @email_list.follow_ups.order('position ASC')
      subscriber = Subscriber.find_by(id: subscriber_id)
      first_follow = follow_ups.first

      # in case the subscriber was removed we are
      # not sending the follow ups anymore
      if first_follow && subscriber
        FollowUpMessageMailer.send_email(first_follow, subscriber).deliver

        # By default we'd want to schedule the second notification if exists
        schedule_next(first_follow.id, subscriber_id) if find_next_scheduled(first_follow.id)
      end
    end

    def find_next_scheduled(follow_up_id)
      @next_followup ||= @email_list.follow_ups
                                    .order('position ASC')
                                    .where('id > ?', follow_up_id)
                                    .first
    end

    def schedule_next(follow_up_id, subscriber_id)
      next_follow_up = find_next_scheduled(follow_up_id)

      if next_follow_up

        follow_up_attributes = {
          follow_up_id: next_follow_up.id,
          subscriber_id: subscriber_id,
          run_at: calculate_run_at(next_follow_up)
        }

        FollowUpSchedule.create(follow_up_attributes)
      end
    end

    def calculate_run_at(follow_up)
      find_next_calculated_week_dates(follow_up).each do |day|
        @selected_day = day[:day_date]
        day_name = Date::DAYNAMES[@selected_day.wday].downcase
        @next_send_windows = follow_up.send_windows.where("#{day_name} = ?", true)
        break if @next_send_windows.exists?
      end

      if @next_send_windows.count > 1
        minutes_quantity = @next_send_windows.order('hour_in_minutes ASC')
                                            .first
                                            .hour_in_minutes
      else
        minutes_quantity = MINUTES_AFTER_MIDNIGHT
      end

      @selected_day + minutes_quantity.minutes
    end

    # NOTE: Add some rspec tests after setting up the suite
    # Response example:
    #   follow_up.days_to_be_sent_after_previous => 1
    #   Date.today      => Thu, 15 Oct 2015
    #
    #   After running the method you should have the next
    #   days starting from tomorrow
    #   next_week_days => [{:day_date=>Fri, 16 Oct 2015},
    #                      {:day_date=>Sat, 17 Oct 2015},
    #                      {:day_date=>Sun, 18 Oct 2015},
    #                      {:day_date=>Mon, 19 Oct 2015},
    #                      {:day_date=>Tue, 20 Oct 2015},
    #                      {:day_date=>Wed, 21 Oct 2015},
    #                      {:day_date=>Thu, 22 Oct 2015}]
    def find_next_calculated_week_dates(follow_up)
      days_after = follow_up.days_to_be_sent_after_previous || 1
      date_starts = Date.today + days_after.days
      next_week_days = []

      7.times do
        next_week_days << {
          day_date: date_starts
        }

        date_starts = date_starts + 1.day
      end

      next_week_days
    end
  end
end

