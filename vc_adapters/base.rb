module TPS
  class VCAdapter
    attr_reader :date_range, :commits, :project
    
    def initialize(opts={})
      read_options(opts)
      read_commits
      
      self
    end
    
    def adapter_name
      :BASE
    end
    
    def read_options(opts={})
      @users = opts[:users]
      @repo = opts[:repo]
      @date_range = opts[:date_range]
      @project = opts[:project] || "NOPROJECT"
      
      puts
      puts " [#{adapter_name}] processing repo: #{@repo}"
      puts " [#{adapter_name}] date range: #{@date_range.to_s}"
      puts " [#{adapter_name}] users: #{@users.join(", ")}"
      
      throw Exception, "No users or repo set" if @users.nil? || @repo.nil?
    end
    
    def read_commits
      raise Exception, "Your Adapter needs to implement the method read_commits"
    end
    
    def all_commits
      @commits
    end
    
    def commits_for_date(date=Date.today.to_s)
      @commits[date].nil? ? nil : [@commits[date].split(";")].flatten
    end
    
    # TODO implement this
    def commits_for_dates(begin_date, end_date)
    end
  end
end