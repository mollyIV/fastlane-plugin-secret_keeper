module Fastlane
  module Helper
    class SecretKeeperHelper
      # class methods that you define here become available in your action
      # as `Helper::SecretKeeperHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the secret_keeper plugin helper!")
      end
    end
  end
end
