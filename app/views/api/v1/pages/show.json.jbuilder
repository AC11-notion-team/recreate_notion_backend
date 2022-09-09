json.id  @page.id
json.icon @page.icon
json.cover @page.cover
json.url @page.url
json.tail @page.tail
json.state @state
json.blocks @blocks do |block|
  json.id block.blockID
  json.type block.kind
  json.data block.data
  json.prev_blockID block.prev_blockID
end 
