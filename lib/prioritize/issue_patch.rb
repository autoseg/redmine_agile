require_dependency 'issue'

module Prioritize
  module IssuePatch
    def lower_priority_in(version)
      select(:prioritization).
        where(:fixed_version_id => version).
        order(:prioritization).last
    end
  end
end

Issue.extend(Prioritize::IssuePatch)
