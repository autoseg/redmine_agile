require_dependency 'issue'

module Prioritize::IssuePatch
  def lower_priority_in(version)
    lower_priority_issue = select(:prioritization).
      where(:fixed_version_id => version).
      order(:prioritization).last

    lower_priority_issue.present? ? ( lower_priority_issue.prioritization || 0 ) : 0
  end

  def self.extended(base)
    base.class_eval do

      before_create :set_prioritization
      before_update :update_prioritization

      def set_prioritization
        lower_priority = self.class.lower_priority_in(self.fixed_version)
        self.prioritization = lower_priority + 1
      end

      def update_prioritization
        set_prioritization if self.fixed_version_id_changed?
      end
    end
  end

end

Issue.extend(Prioritize::IssuePatch)
