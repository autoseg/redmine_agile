module Prioritize
  class IssueReorder
    def self.reorder(issue_source, issue_target)
      if issue_source.prioritization < issue_target.prioritization
        issues = Issue.where([
          "prioritization > ? and prioritization <= ? and fixed_version_id = ?",
          issue_source.prioritization,
          issue_target.prioritization,
          issue_source.fixed_version
        ])

        issues.update_all("prioritization = prioritization - 1")
        issue_source.update_attribute(:prioritization, issue_target.prioritization)
      elsif issue_source.prioritization > issue_target.prioritization
        issues = Issue.where([
          "prioritization < ? and prioritization >= ? and fixed_version_id = ?",
          issue_source.prioritization,
          issue_target.prioritization,
          issue_source.fixed_version
        ])

        issues.update_all("prioritization = prioritization + 1")
        issue_source.update_attribute(:prioritization, issue_target.prioritization)
      end
    end
  end
end
