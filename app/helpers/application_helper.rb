module ApplicationHelper
  def flash_messages
    unless flash.empty?
      msg = []
      flash.each_pair do |k,v|
        msg << "<div class='flash-message flash-#{k.to_s}'>#{v.to_s}</div>"
      end
      flash.discard
      msg.join("\n").html_safe
    else
      ''
    end
  end
  
  def render_crashes_table(records)
    render :partial => 'shared/crashes_table', :locals => {:crashes => records}
  end
  
  def render_deployments_table(records)
    render :partial => 'shared/deployments_table', :locals => {:deployments => records}
  end
end
