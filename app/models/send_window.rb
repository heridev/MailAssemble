class SendWindow < ActiveRecord::Base
  belongs_to :follow_up

  validates_presence_of :hour

  after_save :set_hour_in_minutes

  private

    def set_hour_in_minutes
      hour_string = self.hour
      splitted_hour = hour_string.split(':')
      convert_hour_minutes = splitted_hour.first.to_i * 60 + splitted_hour.second.to_i

      # only update the column since we don't want to trigger the callbacks again
      self.update_column(:hour_in_minutes, convert_hour_minutes)
    end
end
