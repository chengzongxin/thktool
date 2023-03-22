# frozen_string_literal: true

require_relative "thktool/version"
require_relative "trigger_event"
require_relative "modify_until"
require_relative "package_framework"
require_relative "git_until"

module Thktool
  class Error < StandardError; end
  # Your code goes here...

  # test argv
  # ARGV = ["{\"before\":\"ee7810f9d805d4de60ff16b11fc667a6dc36873f\",\"after\":\"1111222233334444\",\"ref\":\"refs/heads/master\",\"user_id\":1379,\"user_name\":\"joe.cheng\",\"project_id\":8339,\"repository\":{\"name\":\"FrameworkSpec\",\"url\":\"git@repo.we.com:iosfeaturelibraries/frameworkspec.git\",\"description\":\"二进制仓库spec文件\",\"homepage\":\"http://repo.we.com/iosfeaturelibraries/frameworkspec\"},\"commits\":[{\"id\":\"0169573dc981119ae22ea64a850cc252816cb66b\",\"message\":\"【THKMacroKit】\\n\",\"timestamp\":\"2023-03-21T14:51:23+08:00\",\"url\":\"http://repo.we.com/iosfeaturelibraries/frameworkspec/commit/0169573dc981119ae22ea64a850cc252816cb66b\",\"author\":{\"name\":\"Joe.cheng\",\"email\":\"joe.cheng@corp.to8to.com\"}}],\"total_commits_count\":1}"]

  p "=========THK Tool Event========="
  p "web hook argv : "
  p ARGV

  # Tool.run(ARGV)
end

class Tool  
  def self.run(argv)
    te = TriggerEvent.new(argv)
    if te.validate_object
      # 修改源码仓库对应的spec仓库
      src_podspec = ModifyUntil.modify_src_commit(te.fwk,te.commit)
      # 提交spec仓库代码
      GitUntil.git_push(Const.Source_Spec_Path,"source podspec repo change : #{te.fwk} commit => #{te.commit}")
      # 开始制作二进制包
      PackageFramework.package(src_podspec)
      # 提交二进制包到framwork仓库
      GitUntil.git_push(Const.Bin_Repo_Path,"binary repo change : #{te.fwk}")
      # 获取二进制仓库最后一次提交commit
      last_commit_id = GitUntil.last_commit_id(Const.Bin_Repo_Path)
      # 修改二进制spec仓库
      fwk_podspec = ModifyUntil.modify_fwk_commit(te.fwk,te.commit,last_commit_id)
      # 提交二进制spec仓库
      GitUntil.git_push(Const.Bin_Spec_Path,"binary podspec change : #{te.fwk} src commit => #{te.commit},  bin commit => #{last_commit_id}")
    end
  end
end