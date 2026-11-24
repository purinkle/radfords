module ProductHelper
  def product_list(products)
    partial = "product_list"

    partial = "no_products" if products.empty?

    partial
  end

  # Paperclip filled in default_url whenever a product had no photo. Active
  # Storage has no such fallback, so every caller goes through here instead.
  # Name a style from Product::PHOTO_SIZES, or leave it out for the full image.
  def product_photo_tag(product, style: nil, **options)
    return image_tag("/photos/original/missing_original.png", options) unless product.photo.attached?

    if style
      image_tag(product.photo_variant(style), options)
    else
      image_tag(product.photo, options)
    end
  end
end
