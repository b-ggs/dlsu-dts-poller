class Formatter
  def self.run(data, src = __FILE__)
    payload = ''

    if data[:success]
      payload = ''

      data[:data].each do |row|
        row.each do |col|
          payload << "#{col}\n"
        end
        payload << "\n"
      end
    else
      payload = <<~PAYLOAD
      **A thing happened.**
      ```
      #{data}
      ```
      PAYLOAD
    end

    <<~MESSAGE
    #{payload}
    **Sent by:** #{src}
    MESSAGE
  end
end
