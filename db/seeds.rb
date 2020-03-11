require 'nokogiri'
require 'open-uri'

signs = [
      {sign: "aries", start_date: Date.new(2017, 3, 21), end_date: Date.new(2017, 4, 19), code: "a60", id: "1"},
      {sign: "taurus", start_date: Date.new(2017, 4, 20), end_date: Date.new(2017, 5, 20),code: "a98", id: "2"},
      {sign: "gemini", start_date: Date.new(2017, 5, 21), end_date: Date.new(2017, 6, 20),code: "a99", id: "3"},
      {sign: "cancer", start_date: Date.new(2017, 6, 21), end_date: Date.new(2017, 7, 22),code: "a100", id: "4"},
      {sign: "leo", start_date: Date.new(2017, 7, 23), end_date: Date.new(2017, 8, 22),code: "a101", id: "5"},
      {sign: "virgo", start_date: Date.new(2017, 8, 23), end_date: Date.new(2017, 9, 22),code: "a102", id: "6"},
      {sign: "libra", start_date: Date.new(2017, 9, 23), end_date: Date.new(2017, 10, 22),code: "a103", id: "7"},
      {sign: "scorpio", start_date: Date.new(2017, 10, 23), end_date: Date.new(2017, 11, 21),code: "a104", id: "8"},
      {sign: "sagittarius", start_date: Date.new(2017, 11, 22), end_date: Date.new(2017, 12, 21),code: "a105", id: "9"},
      {sign: "capricorn", start_date: Date.new(2017, 12, 22), end_date: Date.new(2017, 1, 19),code: "a106", id: "10"},
      {sign: "aquarius", start_date: Date.new(2017, 1, 20), end_date: Date.new(2017, 2, 18),code: "a107", id: "11"},
      {sign: "pisces", start_date: Date.new(2017, 2, 19), end_date: Date.new(2017, 3, 20),code: "a108", id: "12"}
    ]

users = [
  {name: "Elisa", password: "minxie", birthday: Date.new(1994, 9, 15)},
  {name: "Gianfranco", password: "eagles", birthday: Date.new(1997, 3, 22)},
  {name: "Gina", password: "fragin", birthday: Date.new(1970, 9, 28)},
  {name: "Franco", password: "may16", birthday: Date.new(1968, 11, 16)},
  {name: "Christian", password: "elisa", birthday: Date.new(1993, 3, 5)}
]

sites = [
    {address: "https://www.astrology.com/horoscope/daily/ABCD.html", selector: ".section-horoscopes p"},
    {address: "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=IJ", selector: ".horoscope-content p"},
    {address: "http://horoscopes.huffingtonpost.com/astrology/ABCD/", selector: ".topdaily .postBody"},
    {address: "https://www.elle.com/horoscopes/daily/EFGH/ABCD-daily-horoscope/", selector: ".standard-body p"},
    {address: "https://astrologyanswers.com/horoscopes/ABCD-daily-horoscope/", selector: ".new_change p"},
    {address: "http://www.nydailynews.com/horoscopes/ABCD", selector: ".rt-b p"},
    {address: "https://www.astrolis.com/horoscopes/ABCD", selector: "span[itemprop='articleBody']"},
    {address: "https://www.soulvibe.com/ABCD-2/", selector: ".hungryfeed_items p"},
    {address: "http://www.vogue.it/en/horoscope/daily-horoscope/ABCD/", selector: ".entry p"},
    {address: "https://www.mirror.co.uk/lifestyle/horoscopes/ABCD/daily/", selector: ".star-text p"},
    {address: "http://www.astrology-zodiac-signs.com/horoscope/ABCD/daily/", selector: ".dailyHoroscope p"},
    {address: "https://www.californiapsychics.com/horoscope/ABCD-daily-horoscope/", selector: ".horoscope-detail p"}
  ]

# create star_signs using above array
signs.each do |sign|
  star_sign = StarSign.create(sign: sign[:sign], start_date: sign[:start_date], end_date: sign[:end_date])
end
#
users.each do |user|
  signs.each do |sign|
    if user[:birthday].strftime("%m/%d") >= sign[:start_date].strftime("%m/%d") && user[:birthday].strftime("%m/%d") <= sign[:end_date].strftime("%m/%d")
      User.create(name: user[:name], password: user[:password], birthday: user[:birthday], star_sign_id: sign[:id])
    end
  end

end


sites.each do |site|
  puts site[:address]
  signs.each do |signScope|
    puts signScope[:sign]
    sign = signScope[:sign]
    code = signScope[:code]
    id = signScope[:id]
    address = site[:address]
    address = address.gsub /ABCD/, sign
    address = address.gsub /EFGH/, code
    address = address.gsub /IJ/, id
    website = address.split(".")[1]
    doc = Nokogiri::HTML(open(address))
    case website
    when "horoscope"
    content = doc.css('.main-horoscope p')[0].text.split(" - ")
    content.shift
    content = content[0]
  when "elle"
    content = doc.css('.standard-body p').text.chomp('See All Signs')
  when "astrologyanswers"
    content = doc.css('.new_change p').text.split(" - ")
    content.shift
    content = content[0]
  when "vogue"
    content = doc.css('.col-content p').slice(0, 2).text
  else
    content = doc.css("#{site[:selector]}").text
  end
    puts content
    day = Time.now.strftime("%m/%d/%Y")
    horoscope = Horoscope.create(day: day, content: content,
      origin: address.split("//")[1].split('.')[1], star_sign_id: signScope[:id].to_i)
  end
end
