class User < ActiveRecord::Base
  #attr_accessible :department, :email, :first_name, :job_title, :last_name, :login_count, :password_digest, :phone_number, :photo, :profile

  validates :first_name, :last_name, :job_title, :department, :presence => true

  validates :email, :uniqueness => true, :presence => true

  validates :password, :presence => true, :on => :create

  mount_uploader :photo, UserImageUploader

  has_secure_password

  has_many :award_suggested_nominations, :foreign_key => "user_nominated_id"
  has_many :awards, :through => :award_suggested_nominations
  has_many :shoutboxes, dependent: :destroy

  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    self.password_reset_token = SecureRandom.base64.tr('+/', '-_').tr('=', '')
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

end
