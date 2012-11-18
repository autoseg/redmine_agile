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
    issue_source = Issue.find(params[:source])
    issue_target = Issue.find(params[:target])

    Prioritize::IssueReorder.reorder(issue_source, issue_target)

    respond_to do |format|
      format.json { render :json => { status: 'ok' } }
    end
  end

  private

  def fixed_version_id
    return if params[:fixed_version_id].blank?

    params[:fixed_version_id]
  end
end
