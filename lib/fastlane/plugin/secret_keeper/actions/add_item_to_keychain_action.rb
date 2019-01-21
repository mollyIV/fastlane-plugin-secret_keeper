require 'security'

module Fastlane
  module Actions
    class AddItemToKeychainAction < Action
      def self.run(params)
        item_name = params[:item_name]
        account_name = params[:account_name]
        password = params[:password]

        success = Security::InternetPassword.add(item_name, account_name, password)
        if success 
          UI.success("Sucessfully added new item to the keychain 🎉")
          return password
        else
          UI.error("Could not store password in keychain ❌")
          UI.user_error!("Could not store password in the keychain. This can happen if the item you are trying to store already exists in the keychain.")
        end
      end

      def self.description
        "Adds the credentials to the keychain on behalf of the user"
      end

      def self.return_value
        "Returns password as a plain text"
      end

      def self.authors
        ["Daniel Jankowski"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :item_name,
                                  env_name: "SECRET_KEEPER_ITEM_NAME",
                               description: "Item name to be stored in the keychain",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :account_name,
                                    env_name: "SECRET_KEEPER_ACCOUNT_NAME",
                                description: "An account name associated with the keychain item",
                                    optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :password,
                                    env_name: "SECRET_KEEPER_PASSWORD",
                                description: "Password to be stored in the keychain",
                                    optional: false,
                                    sensitive: true,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
