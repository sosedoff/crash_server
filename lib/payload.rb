module Payload
  # Calculate payload uuid
  def payload_uuid(payload)
    str = payload['exception']['class_name'] + payload['exception']['message']
    str << payload['exception']['backtrace'].join("\r\n")
    ['REQUEST_METHOD', 'HTTP_HOST', 'SERVER_PROTOCOL'].each do |k|
      str << payload['environment'][k]
    end
    Digest::SHA1.hexdigest(str)
  end
end