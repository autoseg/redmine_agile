require_dependency 'prioritize/issue_patch'
require_dependency 'prioritize/query_patch'

Redmine::Plugin.register :prioritize do
  name 'Prioritize plugin'
  author 'Kassio Borges & Brian Storti'
  description 'Plugin that give real order to issues'
  version '0.0.1'
  url 'https://github.com/kassio/redmine-prioritize'
  author_url 'https://github.com/kassio/redmine-prioritize#readme'

  permission :prioritization,
    { :prioritization => [:index, :update] },
    :public => true

  menu :project_menu,
       :prioritization,
       { :controller => :prioritization, :action => :index },
       :caption => 'Issue Prioritization',
       :after => :issues
end
