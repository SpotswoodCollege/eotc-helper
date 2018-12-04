module ApplicationHelper
  def account_buttons
    if user_signed_in?
      out =  button_to 'Sign Out', destroy_user_session_path, method: :delete
      out += link_to   'Settings', edit_user_registration_path
    else
      out =  link_to   'Sign Up',  new_user_registration_path
      out += link_to   'Sign In',  new_user_session_path
    end
    out
  end
end
