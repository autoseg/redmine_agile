class UpdatePrioritizations < ActiveRecord::Migration
  def up
    Issue.order(:updated_on).each do |issue|
      issue.set_prioritization!
    end
  end

  def down
    Issue.update_all "prioritization = null"
  end
end