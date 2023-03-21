class Const
    def initialize
        
    end

    def self.Home
        ('/Users/'+`whoami`).chomp
    end

    def self.Source_Repo_Path
        './'
    end

    def self.Source_Spec_Path
        self.Home + '/thkbusinesskitspecs'
    end

    def self.Bin_Repo_Path
        self.Home + '/frameworkrepo'
    end

    def self.Bin_Spec_Path
        self.Home + '/frameworkspec'
    end
end