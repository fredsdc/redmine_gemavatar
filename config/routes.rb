ActionController::Routing::Routes.draw do |map|
    map.connect 'gemavatar/show/:user_id', :controller => 'pictures', :action => 'show'
end
