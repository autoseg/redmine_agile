class PrioritizationController < ApplicationController
  def index
    @project = Project.find(params[:id])
    @versions = @project.versions.where(:status => 'open')
    @issues = @project.
      issues.
      where(:fixed_version_id => fixed_version_id).
      order(:prioritization)

    respond_to do |format|
      format.html
      format.json { render :json => @issues.to_json }
    end
  end

  def update
    Prioritize::IssueReorder.reorder(Issue.find(params[:source]),
                                     Issue.find(params[:target]))
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
