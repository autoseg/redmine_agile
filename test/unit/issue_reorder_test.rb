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

    5.times do
      @issue = create_issue(:project => @project, :fixed_version => @version)
    end
  end

  test 'decrease issue priority' do
    first = @project.issues.order(:prioritization).first
    source = @project.issues.where(:prioritization => 2).first
    target = @project.issues.where(:prioritization => 4).first
    last = @project.issues.order(:prioritization).last

    Prioritize::IssueReorder.reorder(source, target)

    assert_equal 4, source.reload.prioritization
    assert_equal 3, target.reload.prioritization

    assert_equal 1, first.reload.prioritization
    assert_equal 5, last.reload.prioritization
  end

  test 'increase issue priority' do
    first = @project.issues.order(:prioritization).first
    source = @project.issues.where(:prioritization => 4).first
    target = @project.issues.where(:prioritization => 2).first
    last = @project.issues.order(:prioritization).last

    Prioritize::IssueReorder.reorder(source, target)

    assert_equal 2, source.reload.prioritization
    assert_equal 3, target.reload.prioritization

    assert_equal 1, first.reload.prioritization
    assert_equal 5, last.reload.prioritization
  end
end
