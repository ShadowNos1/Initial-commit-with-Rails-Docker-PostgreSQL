class BmiClient
  def initialize(base = ENV.fetch("BMI_API_BASE", "https://www.freepublicapis.com"))
    @conn = Faraday.new(url: base) do |f|
      f.request :url_encoded
      f.adapter Faraday.default_adapter
    end
  end

  # expects height in cm and weight in kg
  def calculate(height_cm:, weight_kg:)
    resp = @conn.get("/bmi-calculator-api", { height: height_cm, weight: weight_kg })
    if resp.status == 200
      JSON.parse(resp.body)
    else
      { "error" => "external API returned status #{resp.status}" }
    end
  rescue => e
    { "error" => e.message }
  end
end
