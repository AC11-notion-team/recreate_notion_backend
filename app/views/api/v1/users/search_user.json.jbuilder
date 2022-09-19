json.users @users do |user|
  json.username user.username
  json.email user.email
  json.picture user.image
end