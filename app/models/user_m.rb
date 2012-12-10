class UserM
  include Mongoid::Document
  field :id, type: Integer
  field :name, type: String
  field :email, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime
  field :password_digest, type: String
  field :admin, type: Boolean
end
