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
    @version = Version.where(:project_id => 1, :status => 'open').first
    @issue = Issue.create!(:project_id => 1,
                           :tracker_id => 1,
                           :author_id => 3,
                           :status_id => 1,
                           :subject => 'Issue',
                           :fixed_version => @version)
  end

  test 'return the lower priority by version' do
    pending
  end

  test 'create a new issue on a version should have a order number(?!)' do
    lower_priority = Issue.lower_priority_in(@version)
    assert_equal lower_priority, @issue.prioritization
  end

  test 'move a issue to a version should add a order number(?!)' do
    pending
  end

  test 'move out a issue from a version should clean order number(?!)' do
    pending
  end
end
