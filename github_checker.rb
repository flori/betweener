require 'rufus-scheduler'
require_relative '../days_since_last_deploy/days_since_last_deploy'

class GithubChecker
  def initialize(token, github_repo, light_switch, scheduler)
    git_data = GitData.new(token)

    # check every 5 seconds for new commits
    scheduler = Rufus::Scheduler.new
    scheduler.every '5s' do
      if git_data.new_activity?(github_repo)
        puts "new commit"
        light_switch.blink_led(6,1,3)
      end
    end
  end
end

