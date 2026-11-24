module ProductHelper
  def product_list(products)
    products.empty? ? "no_products" : "product_list"
  end

  # Paperclip filled in default_url whenever a product had no photo. Active
  # Storage has no such fallback, so every caller goes through here instead.
  # Name a style from Product::PHOTO_SIZES, or leave it out for the full image.
  def product_photo_tag(product, style: nil, **options)
    photo = product.photo
    return image_tag("/photos/original/missing_original.png", options) unless photo.attached?

    image_tag(style ? product.photo_variant(style) : photo, options)
  end
end
