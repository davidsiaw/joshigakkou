require 'colorize'

class Sentence
  ABSPART = %w[に を が]

  def initialize(sentencedata)
    @sentencedata = sentencedata
  end

  def particle?(x)
    x[:feat] == '助詞' && ABSPART.include?(x[:word])
  end

  def particles
    @sentencedata.
      select{|x| particle?(x)}.
      map {|x| x[:word]}.
      to_a
  end

  def sans_particles
    count = 0
    @sentencedata.map do |x|
      if particle?(x)
        count += 1
        " __[#{count}] " 
      else
        x[:word]
      end

    end.join
  end

  def particles_highlighted
    @sentencedata.map do |x| 
      if particle?(x)
        x[:word].colorize(:light_blue)
      else
        x[:word]
      end
    end.join
  end

  def to_s
    @sentencedata.map{|x| x[:word]}.join
  end
end

class SentenceFile
  def initialize(file)
    @file = file
  end

  def yml
    @yml ||= YAML.load_file(@file)
  end

  def sample
    Sentence.new(yml[:sentences].sample)
  end
end

