class Relationship
	include Mongoid::Document
	# include Mongoid::Timestamps
  # attr_accessible :followed_id
  field :follower_id, :type =>Integer
  field :followed_id, :type =>Integer
  field :timestamps, :type =>Time
  
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # has_and_belongs_to_many :followers, inverse_of: :followed_users, class_name: 'User'
  # has_and_belongs_to_many :followed_users, inverse_of: :followers, class_name: 'Relationship'

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
