# secret_keeper plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-secret_keeper)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-secret_keeper`, add it to your project by running:

```bash
fastlane add_plugin secret_keeper
```

## About secret_keeper

You should keep your secret keys, tokens and passwords secure and private. Never store keys in a code repository, in client-side code. 
One of the recommend way of storing sensitive data is the [keychain](https://support.apple.com/guide/keychain-access/what-is-keychain-access-kyca1083/mac).
secret_keeper allows you to store, remove and read the items from the keychain on macOS system. 

## Actions

### ➕ add_item_to_keychain

``` ruby
add_item_to_keychain	# Adds the credentials to the keychain on behalf of the user
```

``` ruby
add_item_to_keychain(
      item_name: "personal-access-token", # Item name to be stored in the keychain
      account_name: "username", # An account name associated with the keychain item
      password: ENV["PERSONAL_ACCESS_TOKEN"] # Password to be stored in the keychain
    )
```

It returns password as a plain text.

⚠️ If an item you are trying to add already exists, the lane fails. 

### ➖ remove_item_from_keychain

``` ruby
remove_item_to_keychain	# Removes the credentials from the keychain on behalf of the user
```

``` ruby
remove_item_to_keychain(
      item_name: "personal-access-token", # Item name to be removed from the keychain
    )
```

⚠️ If an item you are trying to remove does not exist, the lane fails.

### 👓 read_item_from_keychain

``` ruby
read_item_from_keychain	# Reads the password from the keychain for a given item
```

``` ruby
read_item_from_keychain(
      item_name: "personal-access-token", # Item name for a given password stored in the keychain
    )
```

It returns password as a plain text if the item has been found, nil otherwise.

## Example

One of the common usage of a secret_keeper plugin is storing and reading API tokens for a 3rd party services you need to communicate with.

```ruby
lane :request_3rd_party_API do
    password = read_item_from_keychain(
        item_name: PERSONAL_ACCESS_TOKEN
    )

    if password
        # You can use your password here
    else
        # The password for a given item has not been found in the keychain. Request a user to provide the password. 
        UI.message 'Falstlane will talk to the 3rd party service on your behalf. In order to do so, it needs a personal access token. It will ask about it only once and store it in the keychain. Please provide your token 🙏🏻'

        # Since `password` field is non-optional, Fastlane will ask to provide it via a user input. 
        password = add_item_to_keychain(
            item_name: PERSONAL_ACCESS_TOKEN,
            account_name: ENV["USER"]
        )

        # Now you can read a password successfully. 
    end
end
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
