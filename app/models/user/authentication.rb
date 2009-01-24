class User
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of :login, :if => :not_using_openid?
  validates_length_of :login, :within => 3..40, :if => :not_using_openid?
  validates_uniqueness_of :login, :case_sensitive => false, :if => :not_using_openid?
  validates_format_of :login, :with => Authentication.login_regex, :message => Authentication.bad_login_message, :if => :not_using_openid?
  validates_presence_of :email, :if => :not_using_openid?
  validates_length_of :email, :within => 6..100, :if => :not_using_openid?
  validates_uniqueness_of :email, :case_sensitive => false
  validates_format_of :email, :with => Authentication.email_regex, :message => Authentication.bad_email_message, :if => :not_using_openid?
  validates_uniqueness_of :identity_url, :unless => :not_using_openid?
  validate :normalize_identity_url
  
  attr_accessible :login, :email, :name, :password, :password_confirmation, :identity_url

  def self.authenticate(login, password)
    u = find_in_state :first, :active, :conditions => { :login => login } # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
  
  def not_using_openid?
    identity_url.blank?
  end

  protected    
    def make_activation_code
      self.deleted_at = nil
      self.activation_code = self.class.make_token
    end
  
    def normalize_identity_url
      self.identity_url = OpenIdAuthentication.normalize_url(identity_url) unless not_using_openid?
    rescue URI::InvalidURIError
      errors.add_to_base("Invalid OpenID URL")
    end
end