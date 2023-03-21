require 'json'

Home = ('/Users/'+`whoami`).chomp
Source_Repo_Path = './'
Source_Spec_Path = Home + '/thkbusinesskitspecs'

Bin_Repo_Path = Home + '/frameworkrepo'
Bin_Spec_Path = Home + '/frameworkspec'


#   >> "1.5.8".compare_by_fields("1.5.8")
class String
    def compare_by_fields(other, fieldsep = ".")
      cmp = proc { |s| s.split(fieldsep).map(&:to_i) }
      cmp.call(self) <=> cmp.call(other)
    end
end

def find_max_ver(fwk)
    pn = Pathname.new(Source_Spec_Path) + fwk
    maxVer = "0.0.0"
    if pn.directory? 
        pn.each_entry { |verDir|
            next if verDir.basename.to_s[0] == ?.
            if maxVer.compare_by_fields(verDir.basename.to_s) == -1
                maxVer = verDir.basename.to_s
            end
        }
    end
    if maxVer != "0.0.0"
        return pn + maxVer + "#{fwk}.podspec"
    end
    return nil
end

def modify_file_line(file,commit)
    p 'start modify file ...' + file

    IO.write(file, File.open(file) do |f|
        f.read.gsub(/:commit => (.*)/, ":commit => \"#{commit}\"")
      end
    )
end

def git_push(commit)
    pn = Pathname.new(Source_Spec_Path)
    Dir.chdir(pn.to_s)
    `git add . && git commit -m "#{commit}" && git pull && git push`
end


def change_source_spec(fwk,commit)
    pn = find_max_ver(fwk)
    if pn.file?
        modify_file_line(pn.to_s,commit)
        git_push("#{fwk} spec change commit #{commit}")
    end
end

def start_parse
    argv = ["{\"before\":\"ee7810f9d805d4de60ff16b11fc667a6dc36873f\",\"after\":\"0169573dc981119ae22ea64a850cc252816cb66b\",\"ref\":\"refs/heads/master\",\"user_id\":1379,\"user_name\":\"joe.cheng\",\"project_id\":8339,\"repository\":{\"name\":\"FrameworkSpec\",\"url\":\"git@repo.we.com:iosfeaturelibraries/frameworkspec.git\",\"description\":\"二进制仓库spec文件\",\"homepage\":\"http://repo.we.com/iosfeaturelibraries/frameworkspec\"},\"commits\":[{\"id\":\"0169573dc981119ae22ea64a850cc252816cb66b\",\"message\":\"【THKMacroKit】\\n\",\"timestamp\":\"2023-03-21T14:51:23+08:00\",\"url\":\"http://repo.we.com/iosfeaturelibraries/frameworkspec/commit/0169573dc981119ae22ea64a850cc252816cb66b\",\"author\":{\"name\":\"Joe.cheng\",\"email\":\"joe.cheng@corp.to8to.com\"}}],\"total_commits_count\":1}"]
    data = argv.first
    json = JSON.parse(data)
    # p json
    msg = json['commits'].first['message']
    /【([a-zA-Z0-9]*)】/.match(msg)
    change_source_spec($1,json['after']) if $1
end

start_parse
