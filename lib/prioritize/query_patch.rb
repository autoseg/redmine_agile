require_dependency 'query'

module Prioritize::QueryPatch
  unloadable

  def self.extended(base)
    column = "#{Issue.table_name}.prioritization"

    query_column = QueryColumn.new(:prioritization,
                                   :sortable => column,
                                   :groupable => false)

    base.add_available_column(query_column)
  end
end

Query.extend(Prioritize::QueryPatch)
