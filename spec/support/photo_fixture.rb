# The one image the suite uploads, named in a single place so the factory and
# the specs that drive the file field agree on it.
module PhotoFixture
  FILENAME = "photo.jpg".freeze
  PATH = Rails.root.join("spec", "support", "files", FILENAME).freeze
  CONTENT_TYPE = "image/jpeg".freeze
end
