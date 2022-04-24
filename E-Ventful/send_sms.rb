# Download the twilio-ruby library from twilio.com/docs/libraries/ruby

require 'Firebase'
require 'rubygems'
require 'twilio-ruby'


account_sid = 'AC76b5e65656abcddfcbeb28a8ba6e6f19'
auth_token = '58b84aa8c4a011d985178eddc5cd86be'
@client = Twilio::REST::Client.new(account_sid, auth_token)

message = @client.messages
.create(
        messeging_service_sid: ''
        body: 'This is a scheduled message'
        send_at Time.new)
