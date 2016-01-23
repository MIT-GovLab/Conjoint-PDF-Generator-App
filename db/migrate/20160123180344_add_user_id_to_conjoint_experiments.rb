class AddUserIdToConjointExperiments < ActiveRecord::Migration
  def change
    add_column :conjoint_experiments, :user_id, :integer
  end
end
