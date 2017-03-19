desc "Delete the oldest trials"
task :delete_old_trials => [:environment] do |t|
  # Check current day of week to make sure this only runs weekly
  if Time.now.wday == 0
    # Check total of Trials and only delete if approaching limit
    if Trial.all.size > ENV['DATABASE_MAX_ROWS'].to_i
      # Delete the amount of trials to bring us under the limit with some margin of safety
      amount = Trial.all.size - (ENV['DATABASE_MAX_ROWS'].to_i - 3000)
      trials = Trial.limit(amount).order(created_at: :asc)
      puts "Deleting #{trials.count} trials"
      trials.each do |trial|
        begin
          trial.destroy!
        rescue => e
          puts "Skipping Trial #{trial.id}: #{e.message}"
        end
      end
      puts "Done."
    end
  end
end
