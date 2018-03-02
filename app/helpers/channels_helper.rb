module ChannelsHelper
  def generate_private_options(users)
    users.reject { |user| user == current_user }.map { |user| [user.name, user.id] }
  end
end
