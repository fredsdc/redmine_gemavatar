module GemAvatarPlugin
    class Hooks < Redmine::Hook::ViewListener
        render_on :view_my_account, :partial => 'hooks/reload'
    end
end
