Gem::Specification.new do |s|
  s.name = 'cc_api'
  s.version = '0.0.1'
  s.date = '2016-10-15'
  s.summary = 'Ruby client to the CommitChange API'
  s.description = 'Micro-library for easy authentication and acces to the CommitChange fundraising API'
  s.authors = ['Jay R Bolton']
  s.email = 'jay@commitchange.com'
  s.files = 'lib/cc_api.rb'
  s.homepage = 'https://github.com/commitchange/cc-api-ruby-gem'
  s.license = 'MIT'
  s.add_runtime_dependency 'httparty', '>= 0.14.0'
end
