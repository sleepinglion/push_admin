crumb :root do
  link t(:home), root_path
end

crumb :users do
   link t(:menu_my_page), users_path
end

crumb :user_new do
   link t(:menu_new_user), new_user_path
end

crumb :delete_user do
   link t(:delete_user), bye_users_path
   parent :users
end

crumb :user_edit do |user|
   link t(:menu_edit_user), edit_user_path(user)
   parent :users
end

crumb :user_login do
   link t(:user_login), new_user_session_path
end

crumb :new_user_password do
   link t(:menu_new_user_password), new_user_password_path
end

crumb :edit_user_password do
   link t(:change_my_password), edit_user_password_path
end
