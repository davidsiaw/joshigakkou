require_relative 'webpage'

Dir['pagedata/*'].each do |x|
  w = Webpage.new('')
  w.set_rawcontent File.read(x)
  puts w.sentences
end