require_relative 'const'
require 'Pathname'

class ModifyUntil
    def initialize
        
    end

    # 查找最大版本号
    def self.find_max_ver(fwk)
        file = Const.Source_Spec_Path
        pn = Pathname.new(file) + fwk
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

    # 修改文件
    def self.modify_file_line(file,commit)
        p 'start modify file ...' + file

        IO.write(file, File.open(file) do |f|
            f.read.gsub(/:commit => (.*)/, ":commit => \"#{commit}\"")
        end
        )
    end

    # 推送文件
    def self.git_push(commit)
        pn = Pathname.new(Const.Source_Spec_Path)
        Dir.chdir(pn.to_s)
        `git add . && git commit -m "#{commit}" && git pull && git push`
    end

    # 开始修改
    def self.start_modify_fwk_commit(fwk,commit)
        pn = find_max_ver(fwk)
        if pn.file?
            modify_file_line(pn.to_s,commit)
            git_push("#{fwk} spec change commit #{commit}")
        end
    end
end


#   >> "1.5.8".compare_by_fields("1.5.8")
class String
    def compare_by_fields(other, fieldsep = ".")
      cmp = proc { |s| s.split(fieldsep).map(&:to_i) }
      cmp.call(self) <=> cmp.call(other)
    end
end
