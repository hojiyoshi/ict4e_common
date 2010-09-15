require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken


  ### email縺ｮ蛟､繧呈､懆ｨｼ縺吶ｋ縲・
  validates_presence_of     :email
  validates_length_of       :email,:maximum => 100,
    :if => :email_presence_required?
  validates_format_of       :email,
    :with => /^([a-zA-Z0-9])+([a-zA-Z0-9\._-])*@([a-zA-Z0-9_-])+([a-zA-Z0-9\._-]+)+$/,
    :if => :email_presence_required?
  validates_uniqueness_of   :email,
    :case_sensitive => false,
    :if => :email_presence_required?
  
  before_create :make_activation_code

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.


  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  def recently_activated?
    @activated
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find :first, :conditions => ['email = ? and activated_at IS NOT NULL', email] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end


  protected
    def make_activation_code

      self.activation_code = self.class.make_token
    end

    def email_presence_required?
      !(email.blank? || email == '')
    end
end