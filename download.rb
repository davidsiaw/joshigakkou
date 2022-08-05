# extract

# https://www.nikkei.com/article/DGXZQOUA273ZF0X20C22A7000000/
# https://news.yahoo.co.jp/articles/4b8a83d51d6ff7cb526244ff06f0f926ed587c14
# https://news.yahoo.co.jp/articles/14057da0645c16e2ea9e47ad7c0553c2964809d1
# https://www3.nhk.or.jp/news/html/20220729/k10013741281000.html
# https://www3.nhk.or.jp/news/html/20220728/k10013741261000.html
# https://ja.wikipedia.org/wiki/Help:%E8%A8%80%E8%AA%9E%E9%96%93%E3%83%AA%E3%83%B3%E3%82%AF

#require 'mecab'
require 'uri'
require 'yaml'
require_relative 'webpage'

if !File.exist?('pages.yml')
  File.write('pages.yml', {pages: {}}.to_yaml)
end

def follow(root)
  first_part = "https://#{URI.parse(root).host}/"

  links = Dir['pagedata/*'].flat_map do |x|

    w = Webpage.new('')
    w.set_rawcontent File.read(x)
    w.links.map do |link|
      link.sub(%r{^/}, first_part)
    end

  rescue
    []
  end

  links.each do |x|
    Webpage.cached_open(x)
  end
end

w = Webpage.cached_open(root)


# use it like: ruby download.rb 'https://www.yomiuri.co.jp/20220708-1500/'

p follow(ARGV[0])

`rm pagedata/.*`
`rm pagedata/http:*`
`rm pagedata/http:--k.nhk*`
`rm pagedata/-*`



# puts w.sentences.select{|x| x.length > 10}

# tagger = MeCab::Tagger.new
# tagger.parse w.first

#puts w.links

# p '28日夕方、北海道東部の標津町の住宅の敷地内で、正当な理由なく出刃包丁を所持したとして、46歳の女が逮捕されました。きっかけは、パチンコでした。

# 　銃刀法違反の疑いで逮捕されたのは、標津町の46歳の清掃員の女です。
# 　この女は28日午後５時15分ごろ、自宅の敷地内で、業務等、正当な理由がないのに台所にあった刃渡り17センチほどの出刃包丁を所持した疑いが持たれています。
# 　警察によりますと、女は夫に「パチンコに行きたい、お金を」などの話をしましたが、夫に止められると口論になり、カッとなって犯行に及んだとみられています。
# 　夫が「妻が包丁を持って暴れている」と通報、駆け付けた警察官がその場で女を逮捕しました。
# 　取り調べに対して46歳の清掃員の女は「包丁を持っていたのは、間違いない」などと話し、容疑を認めているということです。
# 　警察は、女のふだんの様子も含め、引き続き調べをすすめています。'.match(/([^\p{Hiragana}\p{Katakana}\p{Han}0-9０１２３４５６７８９。？！、「」（）＜＞\s　;]+)/)