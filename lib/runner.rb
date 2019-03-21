require 'httpclient'
require 'oga'

class Runner
  URL_BASE = 'http://enroll.dlsu.edu.ph/dlsu/dts2.view_request?w_button=View&w_dts_no='.freeze

  def self.run
    url = URL_BASE + ENV['DTS_NO']
    # url = 'https://httpstat.us/500'

    resp = HTTPClient.get(url)

    status = resp.status

    if status == 200
      begin
        document = Oga.parse_xml(resp.body)

        data = document.css('form').last.css('table').first.css('tr').map { |a| a.text.split("\n").map { |b| b unless b.empty? }.compact }
        success = true
      rescue => e
        success = false
        data = "Caught exception #{e.class} with message #{e.message}."
      end

    else
      success = false
      data = "Server responded with code #{status}."
    end

    {
      success: success,
      data: data,
      status: status
    }
  end
end
