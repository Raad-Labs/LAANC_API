# LAANC API Client

A Ruby gem to interact with the FAA LAANC (Low Altitude Authorization and Notification Capability) REST API for drone flight authorizations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'laanc_api_client'
```

## Initialize the Client

```ruby
require 'laanc_api_client'

client = LaancApiClient::Client.new(jwt_token: "your_jwt_token_here")
```

## Fetch Operation Statistics

```ruby
begin
  stats = client.get_operation_statistics(
    datetime_start: "2024-04-01T00:00:00Z",
    datetime_end: "2024-04-30T23:59:59Z",
    facility: "ABC,DEF" # Optional
  )
  puts stats.inspect
rescue LaancApiClient::Error => e
  puts "Error: #{e.message}"
end
```

## Fetch Operation Status

```ruby
begin
  status = client.get_operation_status(reference_number: "123456789012")
  puts status.inspect
rescue LaancApiClient::Error => e
  puts "Error: #{e.message}"
end
```

## Fetch System Health Status

```ruby
begin
  health = client.get_system_status
  puts health.inspect
rescue LaancApiClient::Error => e
  puts "Error: #{e.message}"
end
```

## Fetch System Health Status

```ruby
begin
  health = client.get_system_status
  puts health.inspect
rescue LaancApiClient::Error => e
  puts "Error: #{e.message}"
end

## Fetch Public Key

begin
  public_key = client.fetch_public_key(kid: "your_kid_here")
  puts public_key.inspect
rescue LaancApiClient::Error => e
  puts "Error: #{e.message}"
end
```