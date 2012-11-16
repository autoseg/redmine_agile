require_dependency 'prioritize/issue_patch'
require_dependency 'prioritize/query_patch'

Redmine::Plugin.register :prioritize do
  name 'Prioritize plugin'
  author 'Kassio Borges & Brian Storti'
  description 'Plugin that give real order to issues'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  permission :prioritization,
    { :prioritization => [:index, :update] },
    :public => true

  menu :project_menu,
       :prioritization,
       { :controller => :prioritization, :action => :index },
       :caption => 'Prioritization',
       :after => :issues
end
