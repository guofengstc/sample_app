class Micropost 
  include Mongoid::Document
  # attr_accessible :content, :user_id
  # attr_accessible :content
  belongs_to :user
  validates :content, presence: true, length:{maximum: 140}
  validates :user_id, presence: true
  field :content, :type => String
  field :user_id, :type => Integer
  field :timestamps, :type => Time
  # default_scope order: 'microposts.created_at DESC'
  # default_scope :created_at, order('created_at DESC')

  # def self.from_users_followed_by(user)
  #   followed_user_ids = user.followed_user_ids
  #   # where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  #   where("user_id IN (:followed_user_ids) OR user_id = :user_id",
  #         followed_user_ids: followed_user_ids, user_id: user)
  # end
=begin

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
=end
  def self.from_users_followed_by(user)
    # followed_user_ids = "SELECT followed_id FROM relationships
    #                      WHERE follower_id = :user_id"
    # where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
    #       user_id: user.id)
    User.where(follower_id: user.id)
  end

end
