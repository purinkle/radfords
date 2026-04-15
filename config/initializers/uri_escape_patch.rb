# frozen_string_literal: true

# URI.escape was removed in Ruby 3.0. Paperclip 5.x still uses it.
# This patch restores it until Paperclip is replaced with Active Storage.
module URI
  class << self
    def escape(str, unsafe = nil)
      parser = defined?(RFC2396_PARSER) ? RFC2396_PARSER : DEFAULT_PARSER
      if unsafe
        parser.escape(str, unsafe)
      else
        parser.escape(str)
      end
    end
    alias_method :encode, :escape
  end
end
