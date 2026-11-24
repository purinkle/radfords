# Keep MiniMagick as the variant processor

Rails 7.0's framework defaults switch Active Storage from MiniMagick to vips
for resizing images. On the 7.0 hop we took every other 7.0 default but set
`config.active_storage.variant_processor = :mini_magick` in
`config/application.rb`, so product photos keep being resized by ImageMagick,
as they were on Rails 6.1.

## Why not vips now

Checked on 2026-11-24.

Only CircleCI and this machine run the app today, and they disagree. CircleCI
installs ImageMagick in its "Install ImageMagick" step and has no libvips.
This machine has vips 8.18 from Homebrew. The `image_processing` gem already
depends on both `mini_magick` and `ruby-vips`, so no gem change is needed
either way; the difference is only in the system libraries.

The suite does not catch the switch. No spec processes a variant: pages link
to variants through Active Storage's redirect URLs, and the files behind them
are only made when a browser asks. A green build on vips would therefore say
nothing about whether vips is installed or whether the photos still look the
same.

The photos would change. vips and ImageMagick crop and sample differently, the
Rails 7.0 upgrade guide warns that cached variant URLs change, and every
`resize_to_fill` size in `Product::PHOTO_SIZES` would be regenerated on first
view.

None of that is worth taking on in the same pull request as a Rails upgrade.

## What switching takes

- Install libvips on CircleCI beside, or instead of, ImageMagick.
- Make sure whatever serves the app in production has libvips.
- Process one variant per entry in `Product::PHOTO_SIZES` in a spec, so the
  build proves the processor works.
- Compare the resized photos by eye before deploying.
- Delete the override in `config/application.rb`, and this ADR.
