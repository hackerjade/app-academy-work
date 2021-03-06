class User < ActiveRecord::Base
  validates :username, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  has_many(
    :subs,
    class_name: 'Sub',
    foreign_key: :moderator_id,
    primary_key: :id
    )

    has_many(
      :posts,
      class_name: 'Post',
      foreign_key: :author_id,
      primary_key: :id
    )

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end
end
