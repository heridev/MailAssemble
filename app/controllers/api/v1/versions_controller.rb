class Api::V1::VersionsController < Api::BaseController

  before_action :find_element_version

  def undo
    if is_user_creator?
      @current_version.reify.save!
      render_json_message('Undo was applied successfully')
    else
      activerecord_not_found
    end
  end

  private

    def is_user_creator?
      @current_version.whodunnit.to_i == current_user.id
    end

    def find_element_version
      @current_version = PaperTrail::Version.find(params[:id])
    end
end
