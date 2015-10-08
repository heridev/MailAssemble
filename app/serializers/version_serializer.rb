class VersionSerializer < ActiveModel::Serializer
  attributes :item_type,
             :event,
             :whodunnit,
             :created_at,
             :id
end
