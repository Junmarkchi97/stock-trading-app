class Iex < ApplicationRecord
    def self.client
        client = IEX::Api::Client.new(
            publishable_token: 'pk_4b5edcd3a6884cf08b0588217f3fab8a',
            secret_token: 'sk_d6d8de248d1748b4a3e1fa3ff4db1c24',
            endpoint: 'https://cloud.iexapis.com/v1'
        )
    end
end
  