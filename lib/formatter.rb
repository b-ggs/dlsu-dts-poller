class Formatter
  def self.run(data, src = __FILE__, will_sleep_for = 'N/A, triggered by Discord bot')
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
    **Update as of #{Time.now.to_s}**

    #{payload}
    **Sent by:** #{src}
    **Will sleep for:** #{will_sleep_for}
    MESSAGE
  end
end
