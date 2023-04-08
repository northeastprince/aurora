class Aura
  def initialize(user)
    @user = user
  end

  def content
    @content ||= "Good #{part_of_day}, #{@user.first_name}! It's gonna be #{description_of_weather} - #{suggestion}"
  end

  def send
    client = Twilio::REST::Client.new
    client.messages.create(
      from: ENV["TWILIO_PHONE_NUMBER"],
      to: Phonelib.parse(@user.phone_number).e164,
      body: content
    )
  end

  private

  def part_of_day
    hour = Time.use_zone(Ziptz.instance.time_zone_name(@user.zip_code)) { Time.now.hour }
    if hour < 12
      "morning"
    elsif hour < 18
      "afternoon"
    else
      "evening"
    end
  end

  def temperature_in_fahrenheit
    response = Faraday.get("http://api.weatherapi.com/v1/forecast.json?key=#{ENV["WEATHERAPI_KEY"]}&q=#{@user.zip_code.to_s}&days=1&aqi=no&alerts=no")
    JSON.parse(response.body)["current"]["temp_f"].to_i
  end

  def description_of_weather
    "around #{temperature_in_fahrenheit} degrees today"
  end

  def suggestion
    "#{suggestion_prefix} #{apparel_suggestion}"
  end

  def suggestion_prefix
    [
      "you should definitely",
      "it might be a good day to",
      "a human like yourself might even",
      # more phrases
      "you'd be crazy not to",
      "it's a no-brainer to",
      "it's so good, even your grandma would",
      "don't be a chicken, go ahead and",
      "if you don't, the universe might implode",
      "it's like finding a dollar on the sidewalk – you have to",
      "the weather gods demand that you",
      "do it for the vine! Or, you know, just because you should",
      "if you're feeling brave, you could",
      "this is your chance to be a weather warrior and",
      "you won't regret it if you"
    ].sample
  end

  def apparel_suggestion
    case temperature_in_fahrenheit
    when -Float::INFINITY...0
      "bundle up in your warmest coat, hat, and gloves to stay cozy today - don't get frostbite!"
    when 0...10
      "wear a thick sweater, scarf, and beanie will keep you comfortable... hopefully..."
    when 10...20
      "wear a warm jacket, jeans, and boots to keep you toasty."
    when 20...30
      "layer up with a sweater, jacket, and cozy socks."
    when 30...40
      "take a brisk morning walk with a light jacket, leggings, and sneakers."
    when 40...50
      "grab a light jacket and a pair of jeans for a comfortable day."
    when 50...60
      "enjoy the nice temperature with a light sweater and shorts"
    when 60...70
      "perfect weather for a t-shirt and shorts. Get outside and soak up the sunshine!"
    when 70...90
      "wear a hat, sunglasses, and light, breathable clothing."
    else
      "stay cool and hydrated B-)"
    end
  end
end
