class Subscriber < ActiveRecord::Base
  belongs_to :email_list

  validates_presence_of :email,
                        :email_list_id

  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

end
