
class Webpage
  attr_reader :url
  attr_accessor :rawcontent

  def self.cached_open(page)
    fname = File.join('pagedata', page.gsub('/', '-'))
    if File.exist?(fname)
      w = Webpage.new(page)
      w.set_rawcontent File.read(fname)
      return w
    end

    webpage = Webpage.new(page)
    File.write(fname, webpage.rawcontent)

    webpage
  end

  def initialize(url)
    @url = url
  end

  def set_rawcontent(value)
    @rawcontent = value
  end

  def rawcontent
    @rawcontent ||= `curl #{@url} 2>/dev/null`
  end

  def sentences
    rawcontent.split('<').
      map{|x| x.gsub(/"[^"]+"/, '')}.
      flat_map {|x| x.split('>')}.
      map{|x| x.gsub(/([^\p{Hiragana}\p{Katakana}\p{Han}0-9０１２３４５６７８９。？！、「」（）＜＞\s　;][^\p{Hiragana}\p{Katakana}\p{Han}0-9a-zA-Z０１２３４５６７８９。？！、「」（）＜＞\s　;])/, '')}.
      map{|x| x.strip}.
      select {|x| x.length > 0}.
      select {|x| x.end_with?('。')}.
      flat_map {|x| x.split('。')}.
      map{|x| x.strip}.
      uniq.
      map {|x| "#{x}。"}
  end

  def links
    rawcontent.
      scan(/href\s?=\s?".+?"/).
      select{|x| x.start_with?('"https') || x.end_with?('.html"')}.
      map{|x| x[6..-2]}
  end
end
