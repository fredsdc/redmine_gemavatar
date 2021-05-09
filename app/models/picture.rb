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

require 'net/ldap'


class Picture < ActiveRecord::Base
    unloadable

    belongs_to :user

    def self.get_by_user_id(uid)
        Picture.where(:user_id => uid).first
    end

    def self.initialize_ldap_con(record)

        ldap_user = record.account
        ldap_password = record.account_password

        options = { :host => record.host,
            :port => record.port,
        }
        if record.tls
          options[:encryption] = {
            :method => :simple_tls,
            # Always provide non-empty tls_options, to make sure, that all
            # OpenSSL::SSL::SSLContext::DEFAULT_PARAMS as well as the default cert
            # store are used.
            :tls_options => { :verify_mode => record.verify_peer ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE }
          }
        end
        options.merge!(:auth => { :method => :simple, :username => ldap_user, :password => ldap_password }) unless ldap_user.blank? && ldap_password.blank?
        Net::LDAP.new options
    end

    def self.create_from_ldap(user_id, user_login, user_auth_source_id)
        picture_data = nil

        if user_auth_source_id.present? && AuthSourceLdap.pluck(:id).include?(user_auth_source_id)
            ldap_rec=AuthSourceLdap.find(user_auth_source_id)

            picture_attr = Setting.plugin_redmine_gemavatar['LDAP_photoprop']
            ldap_con = initialize_ldap_con(ldap_rec)

            login_filter = Net::LDAP::Filter.eq( ldap_rec.attr_login, user_login )
            object_filter = Net::LDAP::Filter.eq( "objectClass", "*" )
            search_filter = object_filter & login_filter

            ldap_con.search( :base => ldap_rec.base_dn,
                             :filter => search_filter,
                             :attributes=> [picture_attr]) do |entry|

                picture_data = entry[picture_attr][0]
            end
        end

        if picture_data.nil?
            location = spock_location()
        else
            location = location_from_login(user_login)
            File.open(location, 'wb') { |f| f.write(picture_data)}

            #crop the avatar to be square
            original = Magick::Image.read(location)[0]
            width = original.columns
            #y = (original.rows-width)/2
            #if y<0
            #    y=0
            #end
            #croppedimage = original.crop(0,y,width,width)
            croppedimage = original.crop(0,0,width,width)
            croppedimage.write(location)
        end
        Picture.where(user_id: user_id).delete_all
        Picture.create(:location => location, :user_id => user_id, :created => DateTime.now.to_date)
    end

    def self.location_from_login(login)
        filename = File.dirname(__FILE__)
        plugin_dir = File.expand_path(File.dirname(File.dirname(filename)))
        File.join(plugin_dir, 'assets', 'images', login+'.jpg')
    end

    def self.spock_location()
        filename = File.dirname(__FILE__)
        plugin_dir = File.expand_path(File.dirname(File.dirname(filename)))
        File.join(plugin_dir, 'assets', 'images', 'avatar.png')
    end

    def old?
        max_time = Setting.plugin_redmine_gemavatar['refresh_days'].to_f
        now = DateTime.now.to_date
        (now - self.created).to_f > max_time
    end
end
