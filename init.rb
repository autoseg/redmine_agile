require_dependency 'prioritize/issue_patch'
require_dependency 'prioritize/query_patch'

Redmine::Plugin.register :redmine_prioritize do
  name 'Prioritize plugin'
  author 'Kassio Borges'
  description 'Plugin that give real order to issues'
  version '0.0.2'
  url 'https://github.com/autoseg/redmine_prioritize'
  author_url 'https://github.com/autoseg/redmine_prioritize#readme'

  permission :prioritization,
    { :prioritization => [:index, :update] }

  menu :project_menu,
    :prioritization,
    { :controller => :prioritization, :action => :index },
    :caption => :issue_prioritization,
    :after => :issues
end
