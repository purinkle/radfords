require "rails_helper"

describe "a remember token signed before Rails 7.0" do
  # Rails 6.1 derived its cookie keys with SHA1, and signed cookies with a
  # purpose and an expiry. Build a cookie exactly as it would have.
  def cookie_signed_with_sha1_keys(value)
    key = ActiveSupport::KeyGenerator.new(
      Rails.application.secret_key_base, iterations: 1000, hash_digest_class: OpenSSL::Digest::SHA1
    ).generate_key(Rails.application.config.action_dispatch.signed_cookie_salt)

    ActiveSupport::MessageVerifier.new(key, digest: "SHA1", serializer: JSON)
                                  .generate(value, purpose: "cookie.remember_token", expires_in: 20.years)
  end

  it "still signs the customer in" do
    cookies[:remember_token] = cookie_signed_with_sha1_keys(create(:user).remember_token)

    get events_path

    expect(response).to have_http_status(:ok)
  end

  it "is refused if the old key does not match" do
    cookies[:remember_token] = cookie_signed_with_sha1_keys("not a user")[1..]

    get events_path

    expect(response).to redirect_to(signin_path)
  end
end
