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

  test 'the truth' do
    3.times do
      Issue.new(:project_id => 1,
                :tracker_id => 1,
                :author_id => 3,
                :status_id => 1,
                :priority => IssuePriority.all.first,
                :subject => 'Issue',
                :fixed_version => Version.first)
    end

    issue_source = Issue.first
    issue_target = Issue.last

    assert_equal 0, issue_source.prioritization
    assert_equal 2, issue_target.prioritization

    IssueReorder.reorder(issue_source, issue_target)

    assert_equal 2, issue_source.prioritization
    assert_equal 0, issue_target.prioritization
  end
end
