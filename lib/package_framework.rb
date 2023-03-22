require_relative 'const'

class PackageFramework
    
    def self.package(podspec)
        Dir.chdir(Const.Bin_Repo_Path)
        spec_source = ['https://github.com/CocoaPods/Specs.git','git@repo.we.com:iosfeaturelibraries/thkbusinesskitspecs.git','git@repo.we.com:ios/tspecsrepo.git']
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