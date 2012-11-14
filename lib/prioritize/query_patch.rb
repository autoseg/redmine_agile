require_dependency 'query'

module Prioritize::QueryPatch
  def self.extended(base)
    query_column = QueryColumn.new(:prioritization,
                                   :sortable => "#{Issue.table_name}.prioritization",
                                   :groupable => false)

    base.add_available_column(query_column)
  end
end

Query.extend(Prioritize::QueryPatch)
