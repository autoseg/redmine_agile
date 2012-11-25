class UpdatePrioritizations < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do
      Issue.order(:updated_on).each do |issue|
        issue.set_prioritization!
      end
    end
  end

  def down
    Issue.update_all "prioritization = null"
  end
end
