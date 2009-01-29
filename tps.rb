require 'rubygems'
gem 'hpricot'
require 'hpricot'
require 'date'

Author = 'talha'
Svns = {
  :local        =>  "svn+ssh://svn.bubbleshare.com/svn/local/",
  :bluedash     =>  "svn+ssh://svn.bubbleshare.com/svn/admin/",
  :csp          =>  "svn+ssh://svn.bubbleshare.com/svn/csp/",
  # :photos       =>  "svn+ssh://svn.bubbleshare.com/svn/photos/"
  # :bubbleshare  =>  "svn+ssh://svn.bubbleshare.com/svn/bubbleshareweb/"
}
Start_Date, End_Date = ['2008-12-1', '2008-12-31']

date_range = (Date.parse(Start_Date))..(Date.parse(End_Date))
messages_by_date = {}

Svns.each do |project, svn_paths|
  puts "  [PROCESSING] Repos for #{project} ..."
  [svn_paths].flatten.each do |svn|
    (Hpricot(`svn log --xml #{svn}`)/"logentry").each do |entry|
      author = entry.search("author").inner_html
      date = Date.parse(entry.search("date").inner_html)
      if author == Author && date_range.include?(date)
        msgs = entry.search("msg").inner_html.split(/\n/)
        msgs.each do |msg|
          tps_report_message = "[#{project}] #{msg}"
          (messages_by_date[date.to_s] ||= []) << tps_report_message
        end
      end
    end
  end
end

puts "  [GENERATING] Report"

messages_by_date.sort.each do |date, messages|
  puts date
  [messages].flatten.reverse.each {|msg| puts "#{msg}\n"}
  puts "\n"
end
