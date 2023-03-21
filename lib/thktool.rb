# frozen_string_literal: true

require_relative "thktool/version"
require_relative "trigger_event"

module Thktool
  class Error < StandardError; end
  # Your code goes here...
  p ARGV
  argv = ["{\"before\":\"ee7810f9d805d4de60ff16b11fc667a6dc36873f\",\"after\":\"0169573dc981119ae22ea64a850cc252816cb66b\",\"ref\":\"refs/heads/master\",\"user_id\":1379,\"user_name\":\"joe.cheng\",\"project_id\":8339,\"repository\":{\"name\":\"FrameworkSpec\",\"url\":\"git@repo.we.com:iosfeaturelibraries/frameworkspec.git\",\"description\":\"二进制仓库spec文件\",\"homepage\":\"http://repo.we.com/iosfeaturelibraries/frameworkspec\"},\"commits\":[{\"id\":\"0169573dc981119ae22ea64a850cc252816cb66b\",\"message\":\"【THKMacroKit】\\n\",\"timestamp\":\"2023-03-21T14:51:23+08:00\",\"url\":\"http://repo.we.com/iosfeaturelibraries/frameworkspec/commit/0169573dc981119ae22ea64a850cc252816cb66b\",\"author\":{\"name\":\"Joe.cheng\",\"email\":\"joe.cheng@corp.to8to.com\"}}],\"total_commits_count\":1}"]

  te = TriggerEvent.new(argv)
  te.change_source_spec
end
