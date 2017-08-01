class MessageSerializer < ActiveModel::Serializer
  attributes :id, :from, :text, :to, :created_at, :report_id

  def from
    {
      id: "#{object.from_type}:#{object.from.id}",
      name: object.from.name
    }
  end

  def to
    {
      id: "#{object.to_type}:#{object.to.id}",
      name: object.to.name
    } if object.to.present?
  end
end
