class EmailList < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name,
                        :user_id,
                        :default_from,
                        :default_from_name

  after_save :generate_secure_key

  private

    def generate_secure_key
      self.update_column(:secure_key, SecureRandom.uuid)
    end
end
