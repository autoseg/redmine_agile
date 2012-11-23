def create_issue(attrs)
  project = if attrs[:project]
              attrs[:project]
            elsif attrs[:project_id]
              Project.find(attrs[:project_id])
            else
              Project.create!(:name => 'project', :identifier => 'p1')
            end

  attrs.reverse_merge!({
    :project => project,
    :author => User.first,
    :tracker => Tracker.first,
    :status => IssueStatus.first,
    :subject => 'Issue'
  })

  Issue.create! attrs
end
