require_relative 'config'

class PackageFramework
    
    def self.package(podspec)
        Dir.chdir(Config.Bin_Repo_Path)
        spec_source = Config.Package_Source_repo
        command = "pod packagethk #{podspec} --force --exclude-deps --no-mangle --configuration=Debug --spec-sources=#{spec_source.join(',')}"
        puts "start package ..."
        puts command
        output = `#{command}`
        error = nil
        if $?.exitstatus != 0 
            error = output
            puts error
            Process.exit
        end
        puts output
    end
end