class UserSerializer
  def initialize(user)
    @user = user
  end

  def serializable_hash
    {
      id: @user.id,
      name: @user.name,
      email: @user.email,
      is_first_register: @user.is_first_register
    }
  end
end
