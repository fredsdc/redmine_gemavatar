require 'redmine'
require 'gravatar'
require 'application_helper_gemavatar_patch.rb'

Redmine::Plugin.register :redmine_gemavatar do
  name 'Redmine Gemavatar plugin'
  author 'Antoni Segura Puimedon'
  description 'Fetches gemalto avatars from LDAP'
  version '0.0.1'
  url ''
  author_url 'http://celebdor.com'
  settings :default => {}, :partial => 'settings/gemavatar'
end
