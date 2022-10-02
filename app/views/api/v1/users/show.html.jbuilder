json.pages @pages do |page|
  json.id page.id
  json.title page.title
  json.icon  page.icon
  json.url page.url
  json.favorite page.favorite
  json.cover page.cover
  json.shareuser page.shareuser do |user|
    json.user_id user.id
    json.username user.username
    json.email user.email
    json.picture user.image
  end
end
