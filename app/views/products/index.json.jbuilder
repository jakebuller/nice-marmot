json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :price, :available, :purchase_link, :image_link
  json.url product_url(product, format: :json)
end
