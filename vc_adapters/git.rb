
module TPS
  class GitAdapter < VCAdapter
    register_vc_adapter :git, self
    
    def initalize(opts={})
      super.new(opts)
    end
    
    def read_commits
      puts "[GIT] Reading Commits for Project [#{@project}], #{@repo}"
      
      @commits = {}
      repo = Repo.new(@repo)
      unfiltered_commits = Commit.find_all(repo, 'master', :max_count => 600)
      
      unfiltered_commits.each do |uc| 
        date = Date.parse uc.to_hash['authored_date']
        author = uc.author.to_s
        should_keep = (@users.include?(author) && @date_range.include?(date))
        messages = uc.message.to_s.split("\n")
        if should_keep
          messages.each {|m| (@commits[date.to_s] ||=[]) << m}
        end
      end
    end
  end
end