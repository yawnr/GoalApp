class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many :goals

  has_many :comments, as: :commentable

  has_many :authored_comments, foreign_key: :author_id, class_name: 'Comment'

  attr_reader :password

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    if user
      user.is_password?(password) ? user : nil
    else
      nil
    end
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.base64(16)
  end

  def reset_session_token
    self.session_token = SecureRandom.base64(16)
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
