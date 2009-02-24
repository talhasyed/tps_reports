module TPS
  class SvnAdapter < VCAdapter
    def initalize(opts={})
      super.new(opts)
    end
    
    def adapter_name
      :SVN
    end
    
    def read_commits
      @commits = {}
      (Hpricot(`svn log --xml #{@repo}`)/"logentry").each do |entry|
        read_entry(entry)
      end
    end
    
    def read_entry(entry)
      author = entry.search("author").inner_html
      date = Date.parse(entry.search("date").inner_html)
      if @users.member?(author) && @date_range.include?(date)
        commit_messages = entry.search("msg").inner_html.split(/\n/)
        commit_messages.each do |commit_message|
          (@commits[date.to_s] ||=[]) << commit_message
        end
      end
    end
  end
end