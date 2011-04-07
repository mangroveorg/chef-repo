current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "asifdmomin"
client_key               "#{current_dir}/asifdmomin.pem"
validation_client_name   "mangrove-validator"
validation_key           "#{current_dir}/mangrove-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/mangrove"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
