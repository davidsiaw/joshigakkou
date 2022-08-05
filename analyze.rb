require 'mecab'
require_relative 'webpage'
require_relative 'sentence'

require 'yaml'

stuff = {sentences:[]}

tagger = MeCab::Tagger.new
# parseメソッドを使用することで解析結果を文字列で取得

Dir['pagedata/*'].each do |x|
  w = Webpage.new('')
  w.set_rawcontent File.read(x)
  # puts w.sentences
  w.sentences.each do |sentence|

    n = tagger.parseToNode sentence

    features = []

    loop do
      break if n.nil?

      featurename = n.feature.split(',').first
      unless featurename == 'BOS/EOS'
        features << {
          word: n.surface,
          feat: n.feature.split(',').first
        }
      end

      n = n.next
    end

    s = Sentence.new(features)

    if s.particles.length > 0 && features[0][:feat] != '助詞' && !features[0][:word].start_with?('」')
      stuff[:sentences] << features
    end

  end
end

File.write("sentences.yml", stuff.to_yaml)
