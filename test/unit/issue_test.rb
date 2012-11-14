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
    2.times do
      @issue_without_version = Issue.create!(:project_id => 1,
                                             :tracker_id => 1,
                                             :author_id => 3,
                                             :status_id => 1,
                                             :subject => 'Issue')
    end

    @version = Version.where(:project_id => 1, :status => 'open').first

    2.times do
      @issue = Issue.create!(:project_id => 1,
                             :tracker_id => 1,
                             :author_id => 3,
                             :status_id => 1,
                             :subject => 'Issue',
                             :fixed_version => @version)
    end
  end

  test "return the lower priority by version" do
    assert_equal 2, Issue.lower_priority_in(@version)
  end

  test "new issues should receive the lower priority" do
    lower_priority = Issue.lower_priority_in(@version)
    assert_equal lower_priority, @issue.prioritization
  end

  test "issues moved to another version should receive the version's lower priority" do
    lower_priority = Issue.lower_priority_in(nil)
    @issue.update_attribute :fixed_version, nil
    assert_equal lower_priority + 1, @issue.prioritization
  end
end
