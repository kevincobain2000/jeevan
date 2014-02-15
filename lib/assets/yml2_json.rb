# usage:
# ruby ./lib/assets/yml2_json.rb ./app/assets/yaml/items.yml

require 'json'
require 'yaml'

print YAML.load(ARGF.read()).to_json
