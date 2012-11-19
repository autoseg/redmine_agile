class PrioritizationController < ApplicationController
  helper :issues

  def index
    @project = Project.find(params[:id])
    @versions = @project.versions.where(:status => 'open')
    @issues = @project.issues.where(:fixed_version_id => fixed_version_id).order(:prioritization)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    issue_source = Issue.find(params[:source_id])
    issue_target = Issue.find(params[:target_id])

    Prioritize::IssueReorder.reorder(issue_source, issue_target)

    @issues = Issue.where(:fixed_version_id => issue_source.fixed_version)

    respond_to do |format|
      format.json { render :json => @issues.to_json }
    end
  end

  private

  def fixed_version_id
    return if params[:fixed_version_id].blank?

    params[:fixed_version_id]
  end
end
