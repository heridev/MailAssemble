class Subscriber < ActiveRecord::Base
  belongs_to :email_list

  validates_presence_of :email,
                        :email_list_id

  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :email, uniqueness: { scope: :email_list_id }

  # For tracking versions, using meta now we can make some queries like
  # PaperTrail::Version.where(:email_list_id => email_list_id)
  # For example to restablish all the subscriber for an email list
  # when using meta do not forget to create a new migration for that
  has_paper_trail meta: { email_list_id: :email_list_id }
end
