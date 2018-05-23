class UserAuthSerializer < ActiveModel::Serializer
  attributes :jwt, :refresh_token, :role
  alias_method :user, :object
  belongs_to :affiliate, if: :include_affiliate?

  def jwt
    object.token
  end

  def include_affiliate?
    object.affiliate.present?
  end
end
