root_dir = File.dirname(__FILE__)
require File.join(root_dir, 'dependencies.rb')
require File.join(root_dir, 'config.rb')

repo_readers = []
messages_by_date = {}
date_range = (Date.parse(BEGIN_DATE))..(Date.parse(END_DATE))
opts = {
  :users => USERS,
  :date_range => date_range
}

REPOS.each do |project, repo_details|
  repo_type = repo_details[:vcs]
  repo_loc = repo_details[:repo]
  repo_adapter = TPS::VCAdapter.adapter(repo_type).new(opts.merge({:repo => repo_loc}))
  repo_readers << repo_adapter
end

date_range.each do |date|
  puts "\n#{date.strftime("%A %Y-%m-%d")}"
  repo_readers.each do |repo_reader|
    commits_for_date = repo_reader.commits_for_date(date.to_s)
    unless commits_for_date.nil?
      commits_for_date.each do |commit|
        puts "PR-#{repo_reader.project} :: #{commit}"
      end
    end
  end
end

# puts " [GENERATING] Report"
# pp messages_by_date
# messages_by_date.sort.each do |date, messages|
#   puts date
#   [messages].flatten.reverse.each {|msg| puts "#{msg}\n"}
#   puts "\n"
# end
