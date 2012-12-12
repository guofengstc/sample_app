# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User
# class User < ActiveRecord::Base  
=begin

  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed


  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  # before_save {|user| user.email = email.downcase}
  before_save { self.email.downcase! }
  before_save :create_remember_token
  # validates :password,presence: true, length: {minimum:6}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  					format:   {with: VALID_EMAIL_REGEX},
  					uniqueness:{case_sensitive: false}
  validates :password, presence: true, length:{minimum:6}
  validates :password_confirmation, presence: true
=end
# User.create(id:1,name:'gf',email:'gf@tom.com',created_at:Time.now,updated_at:Time.now,password_digest:'1',remember_token:'KkO8snptYPmd-7XZaOkwcA',admin:true)
  # attr_accessible :id, :name, :email, :password_confirmation, :remember_token, :created_at, :updated_at,:admin
  
  include Mongoid::Document
  # include ActiveModel::SecurePassword::ClassMethods
  include ActiveModel::SecurePassword
  # include WillPaginateMongoid::MongoidPaginator
  before_save { self.email.downcase! }
  has_secure_password
  has_many :microposts, dependent: :destroy
  # has_many :relationships, dependent: :destroy
  # has_many :followed_users
  # has_and_belongs_to_many :followed_users, inverse_of: :followers, class_name: 'User'
  # has_and_belongs_to_many :followers, inverse_of: :followed_users, class_name: 'User'
  # has_many :followed_users, class_name: 'User'
  #has_and_belongs_to_many :followed_users, inverse_of: :followers, class_name: "User"
  #has_and_belongs_to_many :followers, inverse_of: :followed_users, class_name: "User"
  #has_many :followers, class_name: 'User'
  # has_and_belongs_to_many :links, :class_name => 'Link', :inverse_of => :inbound_links
  # has_and_belongs_to_many :inbound_links, :class_name => 'Link', :inverse_of => :links

  # has_many :reverse_relationships, dependent:   :destroy
  # has_many :followers
  field :id,                :type => Integer
  field :name,              :type => String
  field :email,             :type => String
  field :created_at,        :type => Time
  field :updated_at,        :type => Time
  field :password_digest,   :type => String
  field :remember_token,    :type => String
  field :admin,             :type => Boolean
  before_save { self.email.downcase! }
  before_save :create_remember_token
  validates_confirmation_of :password
  validates :password, confirmation: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  					format:   {with: VALID_EMAIL_REGEX},
  					uniqueness:{case_sensitive: false}

  validates :password, presence: true, length:{minimum:6}, :if => :need_check_password
    
  validates :password_confirmation, presence: true, :if => :need_check_password

  def need_check_password
    puts "=================================================="
    puts "password_digest => #{password_digest}"
    puts "=================================================="
    password_digest == nil
  end

  #has_and_belongs_to_many implement start#############################
  has_and_belongs_to_many :followed_users, inverse_of: :followers, class_name: 'User'
  has_and_belongs_to_many :followers, inverse_of: :followed_users, class_name: 'User'
  #has_and_belongs_to_many implement end###############################
=begin

  #has_many implement start************************************************
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy


  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy

  
  def followers
    reverse_relationships.map{|r| User.find(r.follower_id)}
  end

  def followed_users
    relationships.map{|r| User.find(r.followed_id)}
  end
  #has_many implement end**************************************************
=end

  def create_remember_token
    self.remember_token=SecureRandom.urlsafe_base64
  end

  def feed
    # Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    followed_users.include?(other_user)
    #relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    followed_users << other_user
    #relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    #relationships.find_by_followed_id(other_user.id).destroy
  end


end
