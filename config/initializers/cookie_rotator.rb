# Rails 7.0 derives cookie keys with SHA256 where 6.1 used SHA1. Without
# this, every signed and encrypted cookie written before the upgrade stops
# reading, which signs every customer out and empties their basket. This
# rotator, from the Rails 7.0 upgrade guide, reads the old cookies and
# rewrites them with the new key.
#
# Delete it once every cookie written under Rails 6.1 has been rewritten
# or has expired. The remember token is permanent, so that wait is long.
Rails.application.config.after_initialize do
  Rails.application.config.action_dispatch.cookies_rotations.tap do |cookies|
    authenticated_encrypted_cookie_salt = Rails.application.config.action_dispatch.authenticated_encrypted_cookie_salt
    signed_cookie_salt = Rails.application.config.action_dispatch.signed_cookie_salt

    secret_key_base = Rails.application.secret_key_base

    key_generator = ActiveSupport::KeyGenerator.new(
      secret_key_base, iterations: 1000, hash_digest_class: OpenSSL::Digest::SHA1
    )
    key_len = ActiveSupport::MessageEncryptor.key_len

    old_encrypted_secret = key_generator.generate_key(authenticated_encrypted_cookie_salt, key_len)
    old_signed_secret = key_generator.generate_key(signed_cookie_salt)

    cookies.rotate :encrypted, old_encrypted_secret
    cookies.rotate :signed, old_signed_secret
  end
end
