class Config
    def initialize
        
    end

    def self.create_config_file_if_need
        yaml = nil
        
        if File.exist?(Config.config_file)
            yaml = YAML.load_file(Config.config_file)
            Config.load_yaml(yaml)
        else
            yml_file = File.join(File.dirname(File.expand_path(__FILE__)), 'thktool_config.yml')
            yaml = YAML.load_file(yml_file)
            File.open(Config.config_file,"w") { |f| YAML.dump(yaml,f) }
        end
        yaml
    end

    def self.config_file
        self.Home + "/thktool_config.yml"
    end

    def self.load_yaml(yaml)
        @@source_repo_path = yaml['SOURCE_REPO_PATH'].trans_home_path!
        @@source_spec_path = yaml['SOURCE_SPEC_PATH'].trans_home_path!
        @@bin_repo_path = yaml['BIN_REPO_PATH'].trans_home_path!
        @@bin_spec_path = yaml['BIN_SPEC_PATH'].trans_home_path!
        @@source_repo_url = yaml['SOURCE_REPO_URL']
        @@bin_repo_url = yaml['BIN_REPO_URL']
        @@package_enable = yaml['PACKAGE_ENABLE']
        @@package_source_repo = yaml['PACKAGE_SOURCE_REPO']
    end

    def self.Home
        ('/Users/'+`whoami`).chomp
    end

    def self.Source_Repo_Path
        @@source_repo_path
    end

    def self.Source_Spec_Path
        @@source_spec_path
    end

    def self.Bin_Repo_Path
        @@bin_repo_path
    end

    def self.Bin_Spec_Path
        @@bin_spec_path
    end

    def self.Source_Repo_Url
        @@source_repo_url
    end

    def self.Bin_Repo_Url
        @@bin_repo_url
    end

    def self.Package_Enable
        @@package_enable == 1
    end

    def self.Package_Source_repo
        @@package_source_repo
    end
end