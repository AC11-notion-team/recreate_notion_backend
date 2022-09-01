json.id  @page.id
json.icon @page.icon
json.cover @page.cover
json.url @page.url
json.tail @page.tail
json.blocks @blocks do |block|
  json.id block.editorID
  json.type block.kind
  json.data block.data
  json.prev_editorID block.prev_editorID
end 
