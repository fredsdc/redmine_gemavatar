#    This file is part of Gemavatar.
#
#    Gemavatar is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Gemavatar is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Gemavatar.  If not, see <http://www.gnu.org/licenses/>.

require 'redmine'
require 'gravatar'
require 'application_helper_gemavatar_patch'
require 'gemavatar_hooks'

Redmine::Plugin.register :redmine_gemavatar do
  name 'Ldap avatar plugin'
  author 'Antoni Segura Puimedon'
  description 'Fetches avatars from LDAP'
  version '1.0.3'
  url ''
  author_url 'http://celebdor.com'
  requires_redmine :version_or_higher => '2.2.0'

  settings :default => {'refresh_days' => '7'}, :partial => 'settings/gemavatar'
end

RedmineApp::Application.config.after_initialize do
    ApplicationHelper.send(:include, GemAvatarPlugin::ApplicationAvatarPatch)
end
