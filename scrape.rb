## super jank, have to load the page and scroll around to get colors to load
# replace KadAutomation.driver with a selenium driver if anyone other
# than me ever tries to run this

require 'json'

driver = KadAutomation.driver

pallets = []

p_div = driver.find_elements(css: '.collection-assets-item')

pallets.first.attribute('style')

pallets = p_div.map do |i|
  {
    name: i.find_element(css: '.name > a').text,
    palette: i.find_elements(css: '.frame > div').map do |ele|
      ele.attribute('style')
    end,
    url: i.find_element(css: '.name > a').attribute('href')
  }
end


pallets = pallets.each do |i|
  i[:palette].map! do |t|
    t.split(/\D+/).reject(&:empty?).map(&:to_i)
  end
end

File.open('./kuler.json', 'w') do |f|
  f.write(JSON.pretty_generate(pallets))
end

