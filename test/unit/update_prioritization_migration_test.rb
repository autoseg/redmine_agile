require File.dirname(__FILE__) + '/../test_helper'
require File.join(File.dirname(__FILE__), '..', '..', 'db', 'migrate', '002_update_prioritizations')

class UpdatePrioritizationsTest < ActiveSupport::TestCase
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

    @version = Version.create!(:name => "version", :project => @project, :status => 'open', :sharing => 'tree')

    2.times do
      create_issue(:project => @project)
      create_issue(:project => @project, :fixed_version => @version)
      create_issue(:project => @other_project)
    end

    Issue.update_all "prioritization = 0"
    UpdatePrioritizations.new.up
  end

  test "set prioritizations" do
    project_issues = Issue.where(:project_id => @project)
    other_project_issues = Issue.where(:project_id => @other_project)

    assert_equal 1, project_issues.where(:fixed_version_id => nil).minimum(:prioritization)
    assert_equal 2, project_issues.where(:fixed_version_id => nil).maximum(:prioritization)

    assert_equal 1, project_issues.where(:fixed_version_id => @version).minimum(:prioritization)
    assert_equal 2, project_issues.where(:fixed_version_id => @version).maximum(:prioritization)

    assert_equal 1, other_project_issues.where(:fixed_version_id => nil).minimum(:prioritization)
    assert_equal 2, other_project_issues.where(:fixed_version_id => nil).maximum(:prioritization)
  end
end
