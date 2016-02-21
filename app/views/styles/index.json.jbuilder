json.array!(@styles) do |style|
  json.extract! style, :id, :style
  json.url style_url(style, format: :json)
end
