module TeeShits
  module Base
    class PaymentProcessorBase
      def pre_authorize(amount)
        raise "Method #{__method__} need to be implemented."
      end

      def complete_charge(charge_id = nil)
        raise "Method #{__method__} need to be implemented."
      end

      def has_errors?
        raise "Method #{__method__} need to be implemented."
      end

      def errors
        raise "Method #{__method__} need to be implemented."
      end

    end
  end
end
