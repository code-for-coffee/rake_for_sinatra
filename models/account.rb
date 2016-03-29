class Account < ActiveRecord::Base

  include BCrypt
  # password setter/mutator
  def password=(users_password)
    self.password_hash = BCrypt::Password.create(users_password)
  end

  def password
    BCrypt::Password.new(self.password_hash)
  end

  def has_valid_password(attempted_password)
    @current_user = self
    if (self.password == attempted_password)
      return true
    else
      return false
    end
  end

  # usage
  # Account.create(
  #   :password => params[:pwd],
  #
  # )

  # password getter

end
