module CrashesHelper
  include UserAgents
  
  def render_backtrace(content)
    content.split("\r\n").map { |l| "<div class='line'>#{l}</div>" }.join.html_safe
  end
end
