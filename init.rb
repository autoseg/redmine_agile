require_dependency 'prioritize/issue_patch'
require_dependency 'prioritize/query_patch'

Redmine::Plugin.register :redmine_prioritize do
  name 'Prioritize plugin'
  author 'Kassio Borges & Brian Storti'
  description 'Plugin that give real order to issues'
  version '0.0.1'
  url 'https://github.com/kassio/redmine_prioritize'
  author_url 'https://github.com/kassio/redmine_prioritize#readme'

  permission :prioritization,
    { :prioritization => [:index, :update] },
    :require => :member

  menu :project_menu,
       :prioritization,
       { :controller => :prioritization, :action => :index },
       :caption => :issue_prioritization,
       :after => :issues,
       :if => Proc.new {
         User.current.allowed_to? :edit_issues, nil, :global => true ||
         User.current.admin?
       }
end
