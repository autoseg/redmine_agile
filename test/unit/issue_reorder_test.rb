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
  end

  test 'decrease issue priority' do
    source = Issue.where(:subject => "PrioritizationTest")[0]
    target = Issue.where(:subject => "PrioritizationTest")[1]

    assert_equal 1, source.prioritization
    assert_equal 2, target.prioritization

    Prioritize::IssueReorder.reorder(source, target)

    assert_equal 2, source.reload.prioritization
    assert_equal 1, target.reload.prioritization
  end

  test 'increase issue priority' do
    source = Issue.where(:subject => "PrioritizationTest")[1]
    target = Issue.where(:subject => "PrioritizationTest")[0]

    assert_equal 2, source.prioritization
    assert_equal 1, target.prioritization

    Prioritize::IssueReorder.reorder(source, target)

    assert_equal 1, source.reload.prioritization
    assert_equal 2, target.reload.prioritization
  end
end
