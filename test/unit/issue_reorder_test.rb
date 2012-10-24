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

  test 'reorder issues target bigger' do
    3.times do
      version = Version.where(:project_id => 1, :status => 'open').first
      Issue.create!(:project_id => 1,
                    :tracker_id => 1,
                    :author_id => 3,
                    :status_id => 1,
                    :priority => IssuePriority.all.first,
                    :subject => "PrioritizationTest",
                    :fixed_version => version)
    end

    issue_source = Issue.where(:subject => "PrioritizationTest").first
    issue_target = Issue.where(:subject => "PrioritizationTest").last

    assert_equal 1, issue_source.prioritization
    assert_equal 3, issue_target.prioritization

    Prioritize::IssueReorder.reorder(issue_source, issue_target)

    assert_equal 3, issue_source.reload.prioritization
    assert_equal 2, issue_target.reload.prioritization
  end

  test 'reorder issues target lower' do
    3.times do
      version = Version.where(:project_id => 1, :status => 'open').first
      Issue.create!(:project_id => 1,
                    :tracker_id => 1,
                    :author_id => 3,
                    :status_id => 1,
                    :priority => IssuePriority.all.first,
                    :subject => "PrioritizationTest",
                    :fixed_version => version)
    end

    issue_source = Issue.where(:subject => "PrioritizationTest").last
    issue_target = Issue.where(:subject => "PrioritizationTest").first

    assert_equal 3, issue_source.prioritization
    assert_equal 1, issue_target.prioritization

    Prioritize::IssueReorder.reorder(issue_source, issue_target)

    assert_equal 1, issue_source.reload.prioritization
    assert_equal 2, issue_target.reload.prioritization
  end
end
