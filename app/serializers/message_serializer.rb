class MessageSerializer < ActiveModel::Serializer
  attributes :from, :text, :to

  def from
    {
      id: object.from.id,
      name: object.from.name
    }
  end

  def to
    {
      id: object.to.id,
      name: object.to.name
    } if object.to.present?
  end
end
