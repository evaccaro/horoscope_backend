require 'nokogiri'
require 'open-uri'

# astrology.com .css('.daily-horoscope p').text
# horoscope.com horoscope = doc.css('.horoscope-content p')[0].text.split(" - ")
                #horoscope.shift
                #puts horoscope[0]
# huffingtonpost .css('.topdaily .postBody').text
# elle .css('.standard-body p').text.chomp('See All Signs')
# astrologyanswers .css('.new_change p').text.split(" - ")
                    # horoscope.shift
                    # puts horoscope
# dailynews .css('.rt-b p').text
# astrolis .css('span[itemprop="articleBody"]').text
# soulvibe .css('.hungryfeed_items p').text
# vogue italia .css('.entry p')[0].text
# mirror .css('.star-text p').text
# astrology zodiac signs .css('.dailyHoroscope p').text
# californiapsychics .css('.horoscope-detail p').text

#
# html = open("")
# doc = Nokogiri::HTML(html)
# horoscope = doc.css('.tab-content p').text
# puts horoscope

signs = [
      {:sign => "aries", :period => "March 21 - April 19", :code => "a60", :id => "1"},
      {:sign => "taurus", :period => "April 20 - May 20", :code => "a98", :id => "2"},
      {:sign => "gemini", :period => "May 21 - June 20", :code => "a99", :id => "3"},
      {:sign => "cancer", :period => "June 21 - July 22", :code => "a100", :id => "4"},
      {:sign => "leo", :period => "July 23 - August 22", :code => "a101", :id => "5"},
      {:sign => "virgo", :period => "August 23 - September 22", :code => "a102", :id => "6"},
      {:sign => "libra", :period => "September 23 - October 22", :code => "a103", :id => "7"},
      {:sign => "scorpio", :period => "October 23 - November 21", :code => "a104", :id => "8"},
      {:sign => "sagittarius", :period => "November 22 - December 21", :code => "a105", :id => "9"},
      {:sign => "capricorn", :period => "December 22 - January 19", :code => "a106", :id => "10"},
      {:sign => "aquarius", :period => "January 20 - February 18", :code => "a107", :id => "11"},
      {:sign => "pisces", :period => "February 19 - March 20", :code => "a108", :id => "12"}
    ]

sites = [
    {:address => "https://www.astrology.com/horoscope/daily/ABCD.html", :selector => ".daily-horoscope p"},
    {:address => "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=IJ", :selector => ".horoscope-content p"},
    {:address => "http://horoscopes.huffingtonpost.com/astrology/ABCD/", :selector => ".topdaily .postBody"},
    {:address => "http://www.elle.com/horoscopes/daily/EFGH/ABCD-daily-horoscope/", :selector => ".standard-body p"},
    {:address => "https://astrologyanswers.com/horoscopes/ABCD-daily-horoscope/", :selector => ".new_change p"},
    {:address => "http://www.nydailynews.com/horoscopes/ABCD", :selector => ".rt-b p"},
    {:address => "https://www.astrolis.com/horoscopes/ABCD", :selector => "span[itemprop='articleBody']"},
    {:address => "https://www.soulvibe.com/ABCD-2/", :selector => ".hungryfeed_items p"},
    {:address => "http://www.vogue.it/en/horoscope/daily-horoscope/ABCD/", :selector => ".entry p"},
    {:address => "http://www.mirror.co.uk/lifestyle/horoscopes/ABCD/daily/", :selector => ".star-text p"},
    {:address => "http://www.astrology-zodiac-signs.com/horoscope/ABCD/daily/", :selector => ".dailyHoroscope p"},
    {:address => "https://www.californiapsychics.com/horoscope/ABCD-daily-horoscope/", :selector => ".horoscope-detail p"}
  ]

#create star_signs using above array
signs.each do |sign|
  star_sign = StarSign.create(sign: sign[:sign], period: sign[:period])
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
    content = doc.css('.horoscope-content p')[0].text.split(" - ")
    content.shift
    content = content[0]
  when "elle"
    content = doc.css('.standard-body p').text.chomp('See All Signs')
  when "astrologyanswers"
    content = doc.css('.new_change p').text.split(" - ")
    content.shift
    content = content[0]
  when "vogue"
    content = doc.css('.entry p')[0].text
  else
    content = doc.css("#{site[:selector]}").text
  end
    puts content
    horoscope = Horoscope.create(day: Time.now, content: content, origin: address.split(".")[1], star_sign_id: signScope[:id].to_i)
  end
end






# sites = [
#   {:name => "aries", :sites => ["https://www.astrology.com/horoscope/daily/aries.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=1",
#   "http://horoscopes.huffingtonpost.com/astrology/aries/",
#   "http://www.elle.com/horoscopes/daily/a60/aries-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/aries-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/aries",
#   "https://www.astrolis.com/horoscopes/aries",
#   "https://www.soulvibe.com/aries-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/aries/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/aries/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/aries/daily/",
#   "https://www.californiapsychics.com/horoscope/aries-daily-horoscope/"]},
#
#   {:name => "taurus", :sites => ["https://www.astrology.com/horoscope/daily/taurus.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=2",
#   "http://horoscopes.huffingtonpost.com/astrology/taurus/",
#   "http://www.elle.com/horoscopes/daily/a98/taurus-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/taurus-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/taurus",
#   "https://www.astrolis.com/horoscopes/taurus",
#   "https://www.soulvibe.com/taurus-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/taurus/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/taurus/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/taurus/daily/",
#   "https://www.californiapsychics.com/horoscope/taurus-daily-horoscope/"]},
#
#   {:name => "gemini", :sites  => ["https://www.astrology.com/horoscope/daily/gemini.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=3",
#   "http://horoscopes.huffingtonpost.com/astrology/gemini/",
#   "http://www.elle.com/horoscopes/daily/a99/gemini-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/gemini-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/gemini",
#   "https://www.astrolis.com/horoscopes/gemini",
#   "https://www.soulvibe.com/gemini-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/gemini/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/gemini/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/gemini/daily/",
#   "https://www.californiapsychics.com/horoscope/gemini-daily-horoscope/"]},
#
#   {:name => "cancer", :sites => ["https://www.astrology.com/horoscope/daily/cancer.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=4",
#   "http://horoscopes.huffingtonpost.com/astrology/cancer/",
#   "http://www.elle.com/horoscopes/daily/a100/cancer-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/cancer-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/cancer",
#   "https://www.astrolis.com/horoscopes/cancer",
#   "https://www.soulvibe.com/cancer-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/cancer/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/cancer/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/cancer/daily/",
#   "https://www.californiapsychics.com/horoscope/cancer-daily-horoscope/"]},
#
#   {:name => "leo", :sites => ["https://www.astrology.com/horoscope/daily/leo.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=5",
#   "http://horoscopes.huffingtonpost.com/astrology/leo/",
#   "http://www.elle.com/horoscopes/daily/a101/leo-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/leo-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/leo",
#   "https://www.astrolis.com/horoscopes/leo",
#   "https://www.soulvibe.com/leo-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/leo/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/leo/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/leo/daily/",
#   "https://www.californiapsychics.com/horoscope/leo-daily-horoscope/"]},
#
#   {:name => "virgo", :sites  => ["https://www.astrology.com/horoscope/daily/virgo.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=6",
#   "http://horoscopes.huffingtonpost.com/astrology/virgo/",
#   "http://www.elle.com/horoscopes/daily/a102/virgo-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/virgo-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/virgo",
#   "https://www.astrolis.com/horoscopes/virgo",
#   "https://www.soulvibe.com/virgo-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/virgo/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/virgo/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/virgo/daily/",
#   "https://www.californiapsychics.com/horoscope/virgo-daily-horoscope/"]},
#
#   {:name => "libra", :sites => ["https://www.astrology.com/horoscope/daily/libra.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=7",
#   "http://horoscopes.huffingtonpost.com/astrology/libra/",
#   "http://www.elle.com/horoscopes/daily/a103/libra-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/libra-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/libra",
#   "https://www.astrolis.com/horoscopes/libra",
#   "https://www.soulvibe.com/libra-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/libra/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/libra/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/libra/daily/",
#   "https://www.californiapsychics.com/horoscope/libra-daily-horoscope/"]},
#
#   {:name => "scorpio", :sites => ["https://www.astrology.com/horoscope/daily/scorpio.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=8",
#   "http://horoscopes.huffingtonpost.com/astrology/scorpio/",
#   "http://www.elle.com/horoscopes/daily/a104/scorpio-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/scorpio-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/scorpio",
#   "https://www.astrolis.com/horoscopes/scorpio",
#   "https://www.soulvibe.com/scorpio-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/scorpio/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/scorpio/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/scorpio/daily/",
#   "https://www.californiapsychics.com/horoscope/scorpio-daily-horoscope/"]},
#
#   {:name => "sagittarius", :sites => ["https://www.astrology.com/horoscope/daily/sagittarius.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=9",
#   "http://horoscopes.huffingtonpost.com/astrology/sagittarius/",
#   "http://www.elle.com/horoscopes/daily/a105/sagittarius-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/sagittarius-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/sagittarius",
#   "https://www.astrolis.com/horoscopes/sagittarius",
#   "https://www.soulvibe.com/sagittarius-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/sagittarius/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/sagittarius/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/sagittarius/daily/",
#   "https://www.californiapsychics.com/horoscope/sagittarius-daily-horoscope/"]},
#
#   {:name => "capricorn", :sites => ["https://www.astrology.com/horoscope/daily/capricorn.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=10",
#   "http://horoscopes.huffingtonpost.com/astrology/capricorn/",
#   "http://www.elle.com/horoscopes/daily/a106/capricorn-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/capricorn-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/capricorn",
#   "https://www.astrolis.com/horoscopes/capricorn",
#   "https://www.soulvibe.com/capricorn-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/capricorn/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/capricorn/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/capricorn/daily/",
#   "https://www.californiapsychics.com/horoscope/capricorn-daily-horoscope/"]},
#
#   {:name => "aquarius", :sites => ["https://www.astrology.com/horoscope/daily/aquarius.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=11",
#   "http://horoscopes.huffingtonpost.com/astrology/aquarius/",
#   "http://www.elle.com/horoscopes/daily/a107/aquarius-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/aquarius-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/aquarius",
#   "https://www.astrolis.com/horoscopes/aquarius",
#   "https://www.soulvibe.com/aquarius-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/aquarius/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/aquarius/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/aquarius/daily/",
#   "https://www.californiapsychics.com/horoscope/aquarius-daily-horoscope/"]},
#
#   {:name => "pisces", :sites => ["https://www.astrology.com/horoscope/daily/pisces.html",
#   "https://www.horoscope.com/us/horoscopes/general/horoscope-general-daily-today.aspx?sign=12",
#   "http://horoscopes.huffingtonpost.com/astrology/pisces/",
#   "http://www.elle.com/horoscopes/daily/a108/pisces-daily-horoscope/",
#   "https://astrologyanswers.com/horoscopes/pisces-daily-horoscope/",
#   "http://www.nydailynews.com/horoscopes/pisces",
#   "https://www.astrolis.com/horoscopes/pisces",
#   "https://www.soulvibe.com/pisces-2/",
#   "http://www.vogue.it/en/horoscope/daily-horoscope/pisces/",
#   "http://www.mirror.co.uk/lifestyle/horoscopes/pisces/daily/",
#   "http://www.astrology-zodiac-signs.com/horoscope/pisces/daily/",
#   "https://www.californiapsychics.com/horoscope/pisces-daily-horoscope/"]}
# ]
