require_dependency 'issue'

module Prioritize::IssuePatch
  def lower_priority_in(version, project)
    where(:fixed_version_id => version, :project_id => project).maximum(:prioritization) || 0
  end

  def self.extended(base)
    base.class_eval do

      before_create :set_prioritization
      before_update :update_prioritization

      def set_prioritization
        lower_priority = ::Issue.lower_priority_in(self.fixed_version, self.project)
        self.prioritization = lower_priority + 1
      end

      def update_prioritization
        set_prioritization if self.fixed_version_id_changed?
      end
    end
  end

end

Issue.extend(Prioritize::IssuePatch)
