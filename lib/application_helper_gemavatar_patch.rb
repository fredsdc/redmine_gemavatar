require 'application_helper'

module GemAvatarPlugin
    module ApplicationAvatarPatch
        def self.included(base)
            base.send(:include, InstanceMethods)
            base.class_eval do
                alias_method :avatar, :avatar_gem
            end
        end
        module InstanceMethods
            def avatar_gem(user, options = { })
                if Setting.gravatar_enabled?
                    options.merge!({:ssl => (defined?(request) && request.ssl?), :default => Setting.gravatar_default})
                    options[:size] = "64" unless options[:size]
                    return "<img class=\"gravatar\" width=\"#{options[:size]}\" height=\"#{options[:size]}\" src=\"/gemavatar/show/#{user.id}\" />"
                else
                    ''
                end
            end
        end
    end
end

ApplicationHelper.send(:include, GemAvatarPlugin::ApplicationAvatarPatch)
