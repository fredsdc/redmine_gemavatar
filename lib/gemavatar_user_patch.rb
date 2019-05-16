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

require_dependency 'user'

module GemAvatarPlugin
  module GemavatarUserPatch
    def self.included(base) # :nodoc:
      base.class_eval do
        unloadable
        has_one :picture, :dependent => :destroy
      end
    end
  end
end
