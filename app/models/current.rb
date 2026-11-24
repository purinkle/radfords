# Per-request state. Rails resets it at the end of every request, so the
# signed in user can never leak from one request into the next.
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end
