class SendWindowSerializer < ActiveModel::Serializer
  attributes :id,
             :sunday,
             :monday,
             :tuesday,
             :wednesday,
             :thursday,
             :friday,
             :saturday,
             :hour

end

