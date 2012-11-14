class Prioritize::Hooks < Redmine::Hook::ViewListener
render_on :view_issues_sidebar_planning_bottom, :text => 'Prioritize'
end
