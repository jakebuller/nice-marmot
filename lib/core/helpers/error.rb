module TeeShits
  module Helpers
    class Error

      def initialize(message, error_code = nil)
        @message = message
        @error_code = error_code #TODO ensure that error_code is set in TeeShits::Helpers::Errorcode
      end

      def message
        @message
      end

      def error_code
        @error_code
      end
    end
  end
end
