require File.dirname(__FILE__) + '/../test_helper'

class IssueTest < ActiveSupport::TestCase
  fixtures :projects,
    :users,
    :members,
    :member_roles,
    :roles,
    :trackers,
    :projects_trackers,
    :enabled_modules,
    :versions,
    :issue_statuses,
    :workflows,
    :enumerations,
    :issues

  setup do
    @project = Project.create!(:name => 'project', :identifier => 'p1')
    @other_project = Project.create!(:name => 'project', :identifier => 'p2')

    2.times do
      @issue_without_version = create_issue(:project => @project)
      @other_project_issue = create_issue(:project => @other_project)
    end

    @version = Version.create!(:name => "version", :project => @project, :status => 'open', :sharing => 'tree')

    2.times do
      @issue = create_issue(:project => @project, :fixed_version => @version)
    end
  end

  test "return the lower priority by version" do
    assert_equal 2, Issue.lower_priority_in(@version, @project)
  end

  test "new issues should receive the lower priority" do
    lower_priority = Issue.lower_priority_in(@version, @project)
    assert_equal lower_priority, @issue.prioritization
  end

  test "issues moved to another version should receive the version's lower priority" do
    lower_priority = Issue.lower_priority_in(nil, @project)
    @issue.update_attribute :fixed_version, nil

    assert_equal lower_priority + 1, @issue.prioritization
  end
end
