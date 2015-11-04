require 'aasm'

class FollowUpSchedule < ActiveRecord::Base
  include AASM

  belongs_to :subscriber
  belongs_to :follow_up

  aasm column: 'state' do
    state :created, initial: true
    state :started
    state :failed
    state :completed

    event :process do
      transitions from: [:created, :failed], to: :started
    end

    event :error do
      transitions from: :started, to: :failed
    end

    event :finish do
      transitions from: :started, to: :completed
    end
  end

end

