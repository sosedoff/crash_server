module UserAgents
  AGENT_TYPES = {
    :bot      => /(google|yahoo|baidu|crawler|bot|webalta|ia_archiver|spider|survey)/i,
    :mobile   => /(blackberry|motorokr|motorola|sony|windows ce|240x320|176x220|palm|mobile|iphone|ipod|symbian|nokia|samsung|midp)/i,
    :system   => /(urllib)/i,
    :terminal => /(wget|curl)/i,
    :ie6      => /MSIE 6/i,
    :ie7      => /MSIE 7/i,
    :ie8      => /MSIE 8/i,
    :ie9      => /MSIE 9/i,
    :chrome   => /chrome/i,
    :firefox  => /firefox/i,
    :opera    => /opera/i,
    :safari   => /safari/i,
    :os_mac   => /mac os x/i,
    :os_win   => /windows (98|nt|xp)/i,
    :os_linux => /(linux|debian)/i
  }
  
  # Returns an array of available agent types
  #
  def agent_types
    UserAgents::AGENT_TYPES.keys.map(&:to_s)
  end
  
  # Detect user-agent type by string
  #   returns an array of matched types
  #   returns nil if no agents detected
  # 
  def detect_agent(str)
    result = []
    AGENT_TYPES.each_pair do |name, regex|
      result << name.to_s if str =~ regex
    end
    result.empty? ? nil : result
  end
end