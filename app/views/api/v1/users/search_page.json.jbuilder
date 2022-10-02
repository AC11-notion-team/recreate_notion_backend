json.pages @pages do |page|
  json.id page.id
  json.title page.title
  json.icon  page.icon
end

# json.extract! user, :title, :icon
# json.url user_url(user, format: :json)