require 'redmine'
require 'gravatar'
require 'application_helper_gemavatar_patch.rb'
require 'hooks'

Redmine::Plugin.register :redmine_gemavatar do
  name 'Ldap avatar plugin'
  author 'Antoni Segura Puimedon'
  description 'Fetches avatars from LDAP'
  version '1.0.0'
  url ''
  author_url 'http://celebdor.com'
  settings :default => {}, :partial => 'settings/gemavatar'

  #Initialize settings.
  Setting.plugin_redmine_gemavatar['refresh_days'] = '5' if Setting.plugin_redmine_gemavatar['refresh_days'].nil?
  Setting.plugin_redmine_gemavatar['allow_reload'] = 'yes' if Setting.plugin_redmine_gemavatar['allow_reload'].nil?
end
