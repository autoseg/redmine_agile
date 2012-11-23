require File.dirname(__FILE__) + '/../test_helper'

class IssueReorderTest < ActiveSupport::TestCase
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
    @version = Version.create!(:name => "version", :project => @project, :status => 'open', :sharing => 'tree')

    3.times do
      @issue = create_issue(:project => @project, :fixed_version => @version)
    end
  end

  test 'decrease issue priority' do
    source = @project.issues.first
    target = @project.issues.last

    assert_equal 1, source.prioritization
    assert_equal 3, target.prioritization

    Prioritize::IssueReorder.reorder(source, target)

    assert_equal 3, source.reload.prioritization
    assert_equal 2, target.reload.prioritization
  end

  test 'increase issue priority' do
    source = @project.issues.last
    target = @project.issues.first

    assert_equal 3, source.prioritization
    assert_equal 1, target.prioritization

    Prioritize::IssueReorder.reorder(source, target)

    assert_equal 1, source.reload.prioritization
    assert_equal 2, target.reload.prioritization
  end
end
