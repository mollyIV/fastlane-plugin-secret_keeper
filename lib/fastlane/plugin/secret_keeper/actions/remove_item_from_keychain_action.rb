require 'security'

module Fastlane
  module Actions
    class RemoveItemFromKeychainAction < Action
      def self.run(params)
        item_name = params[:item_name]

        success = Security::InternetPassword.delete(server: item_name)
        if success 
          UI.success("Sucessfully removed an item from the keychain 🎉")
        else
          UI.error("Could not remove an item from the keychain ❌")
          UI.user_error!("Could not remove an item from the keychain. This can happen if an item you are trying to remove could not be found in the keychain.")
        end
      end

      def self.description
        "Removes the credentials from the keychain on behalf of the user"
      end

      def self.authors
        ["Daniel Jankowski"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :item_name,
                                  env_name: "SECRET_KEEPER_ITEM_NAME",
                               description: "Item name to be removed from the keychain",
                                  optional: false,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
