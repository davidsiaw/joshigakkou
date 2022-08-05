JoshiGakkou
-----------

This is a set of scripts to scrape out Japanese sentences from websites and parse them.

News sites are really good. Novels not so much.

You need to be able to `gem install mecab` whatever that entails

How to use
----------

```
ruby download.rb 'https://some news site'
ruby analyze.rb
./randomquestion
```

Scripts
-------

This doc is a braindump of what each of the files do.

- `download.rb` - Downloads and scrapes one level of links into pagedata folder
- `analyze.rb` - Analyzes all the stuff in pagedata folder (produces a sentences.yml file)
- `sentence.rb` - Library for Sentence class
- `webpage.rb` - Library for Webpage class
- `randomsentence.rb` - Shows a random sentence (uses sentences.yml file)
- `randomquestion` - Asks a random question (uses sentences.yml file)

