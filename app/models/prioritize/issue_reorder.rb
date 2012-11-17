module Prioritize::IssueReorder
  def self.reorder(source, target)
    @source = source
    @target = target

    if increase_priority?
      @update_prioritization = "prioritization = prioritization + 1"
      @conditions = conditions_for_increase_priority
    else
      @update_prioritization = "prioritization = prioritization - 1"
      @conditions = conditions_for_decrease_priority
    end

    @issues_by_version = Issue.where(:fixed_version_id => @source.fixed_version)

    @issues_by_version.update_all(@update_prioritization, @conditions)

    @source.update_attribute(:prioritization, target.prioritization)
  end

  def self.increase_priority?
    @source.prioritization > @target.prioritization
  end
  private_class_method :increase_priority?

  def self.conditions_for_increase_priority
    [
      "prioritization < :source_priority AND prioritization >= :target_priority",
      :source_priority => @source.prioritization, :target_priority => @target.prioritization
    ]
  end
  private_class_method :conditions_for_increase_priority

  def self.conditions_for_decrease_priority
    [
      "prioritization > :source_priority AND prioritization <= :target_priority",
      :source_priority => @source.prioritization, :target_priority => @target.prioritization
    ]
  end
  private_class_method :conditions_for_decrease_priority
end
