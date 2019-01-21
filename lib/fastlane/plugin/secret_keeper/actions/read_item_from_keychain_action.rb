require 'security'

module Fastlane
  module Actions
    class ReadItemFromKeychainAction < Action
      def self.run(params)
        item_name = params[:item_name]

        item = Security::InternetPassword.find(server: item_name)
        if item 
          UI.success("Sucessfully read an item from the keychain 🎉")
          return item.password 
        else
          UI.error("Could not read an item from the keychain. Please make sure '#{item_name}' item exists in the keychain ❌")
          return nil
        end
      end

      def self.description
        "Reads the password from the keychain for a given item"
      end

      def self.authors
        ["Daniel Jankowski"]
      end

      def self.return_value
        "Returns password as a plain text"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :item_name,
                                  env_name: "SECRET_KEEPER_ITEM_NAME",
                               description: "Item name for a given password stored in the keychain",
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
