class Api::BaseController < ActionController::Base

  before_filter :authenticate_user!, :except => [:add_public_subscriber]

  rescue_from ActiveRecord::RecordNotFound, with: :activerecord_not_found

  def render_serialized(obj, serializer, opts={})
    render_json_dump(serialize_data(obj, serializer, opts))
  end

  def render_json_dump(obj, status = :ok)
    render json: MultiJson.dump(obj),
           status: status
  end

  def render_json_message(message, variable = 'status')
    data = {
      "#{variable}" => message
    }
    render_json_dump(data, :ok)
  end

  def render_error_object(hash)
    render_json_dump(hash, :unprocessable_entity)
  end

  def render_with_error(msg = 'An error occurred while...')
    data = {
      error: msg
    }
    render_json_dump(data, :unprocessable_entity)
  end

  def activerecord_not_found
    data = {
      error: 'Record not found'
    }
    render_json_dump(data, 404)
  end

  def serialize_data(obj, serializer, opts={})
    # If it's an array, apply the serializer as an each_serializer to the elements
    if obj.respond_to?(:to_ary)
      opts[:each_serializer] = serializer
      ActiveModel::ArraySerializer.new(obj.to_ary, opts).as_json
    else
      serializer.new(obj, opts).as_json
    end
  end
end
