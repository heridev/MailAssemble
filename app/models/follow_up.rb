class FollowUp < ActiveRecord::Base
  # Associations
  #
  belongs_to :email_list

  validates_presence_of :email_list_id,
                        :title,
                        :days_to_be_sent_after_previous

  has_many :send_windows, dependent: :destroy
  accepts_nested_attributes_for :send_windows, allow_destroy: true

  ### Callbacks #######
  after_create :set_position_number

  # Thanks to http://thepugautomatic.com/2008/11/rails-jquery-sortables/
  # query for mysql
  def self.mysql_reorder_position(ids)
    update_all(
      ['position = FIND_IN_SET(id, ?)', ids.join(',')],
      { id: ids }
    )
  end

  def self.reorder_position(ids)
    db_adapter = ENV['DB_ADAPTER'] || 'postgress'
    return self.postgress_reorder_position(ids) if db_adapter == 'postgress'
    return self.mysql_reorder_position(ids) if db_adapter == 'mysql'
  end

  # Query for postgresSql
  def self.postgress_reorder_position(ids)
    self.where('id in (?)', ids)
        .update_all(["position = (STRPOS(?, ','||lpad(cast(id as text), 20, '0')||',') - 1)/21 + 1", ", #{ids.map{|x| "%020d" % x }.join(',')},"])
  end

  def is_first_in_email_list?
    FollowUp.where(email_list_id: self.email_list_id).order('position ASC').first.try(:id) == self.id
  end

  private

    def set_position_number
      last_question = FollowUp.where(email_list_id: self.email_list_id)
                              .where("id <> #{self.id}")
                              .order('position DESC').first
      position_number = (last_question.try(:position)).to_i + 1
      update_column(:position, position_number) unless position
    end

    def set_default_section_name
      update_column(:section_name, 'patients') unless section_name
    end
end
