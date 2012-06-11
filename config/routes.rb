ActionController::Routing::Routes.draw do |map|
    map.connect 'gemavatar/show/:user_id', :controller => 'pictures', :action => 'show'
    map.connect 'gemavatar/delete/:user_id', :controller => 'pictures', :action => 'delete'
end
