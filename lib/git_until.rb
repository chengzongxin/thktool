class GitUntil
    # 推送文件
    def self.git_push(path,commit)
        pn = Pathname.new(path)
        Dir.chdir(pn.to_s)
        `git add . && git commit -m "#{commit}" && git pull && git push`
    end

    # 获取最后一次提交commit id
    def self.last_commit_id(path)
        Dir.chdir(path)
        `git rev-parse --short HEAD`.chomp
    end
end