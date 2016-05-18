module Exceptions
  class Authorization < StandardError
    class Required; end
    class OnlyForGuests; end
  end
end