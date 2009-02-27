module TPS
  class VCAdapter
    attr_reader :date_range, :commits, :project
    
    def initialize(opts={})
      read_options(opts)
      read_commits
      do_adapter_specific_setup
      self
    end
    
    def self.register_vc_adapter(vcs, adapter)
      @@adapters ||= {}
      @@adapters[vcs] = adapter
    end
    
    # override this in your adapter to register your adapter etc
    def do_adapter_specific_setup; end
    
    def self.register_adapter(vcs, adapter_name)
      @@adapters[vcs] = adapter_name
    end
    
    def self.adapter(vcs)
      @@adapters[vcs]
    end

    def read_options(opts={})
      @users = opts[:users]
      @repo = opts[:repo]
      @date_range = opts[:date_range]
      @project = opts[:project] || "NOPROJECT"
      
      puts " [INIT] processing repo: #{@repo}"
      puts " [INIT] date range: #{@date_range.to_s}"
      puts " [INIT] users: #{@users.join(", ")}"
      
      raise Exception, "No users or repo set" if @users.nil? || @repo.nil?
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
  end
end