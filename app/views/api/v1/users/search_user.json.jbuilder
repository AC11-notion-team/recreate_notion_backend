json.users @Users do |user|
  json.id user.id
  json.username user.username
  json.email user.email
  json.picture user.image
end
