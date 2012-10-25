module Prioritize
  class IssueReorder
    class << self
      def reorder(source, target)
        if source.prioritization < target.prioritization
          decrease_priority(source, target)
        elsif source.prioritization > target.prioritization
          increase_priority(source, target)
        end
      end

      private

      def increase_priority(source, target)
        issues = Issue.where([
          "prioritization < :source_priority and prioritization >= :target_priority and fixed_version_id = :version",
          source_priority: source.prioritization, target_priority: target.prioritization, version: source.fixed_version
        ])

        issues.update_all("prioritization = prioritization + 1")
        source.update_attribute(:prioritization, target.prioritization)
      end

      def decrease_priority(source, target)
        issues = Issue.where([
          "prioritization > :source_priority and prioritization <= :target_priority and fixed_version_id = :version",
          source_priority: source.prioritization, target_priority: target.prioritization, version: source.fixed_version
        ])

        issues.update_all("prioritization = prioritization - 1")
        source.update_attribute(:prioritization, target.prioritization)
      end
    end
  end
end
