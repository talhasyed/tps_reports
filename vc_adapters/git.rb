module TPS
  class GitAdapter < VCAdapter
    register_vc_adapter :git, self
    
    def initalize(opts={})
      super.new(opts)
    end
    
    def read_commits
      puts "\n\n\n\nREADING GIT COMMITS"
      @commits = {}
    end
    
    private
      def read_entry(entry)
      end
  end
end