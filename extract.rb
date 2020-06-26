require 'JSON'

texts = []

Dir.glob(File.expand_path('../guides/source/**/*.md', __FILE__)).each do |path|
  content = File.read(path)
  t = []

  content.scan(/```.+?```/m).each do |code|
    t += code.split("\n")[1..-2]
  end

  content.scan(/[^`]`([^`]+?)`[^`]/).each do |(code)|
    t << code
  end

  texts += t
    .map { |c| c.strip.gsub(/#.+\z/, '').strip.gsub(/\s+/, ' ') }
    .reject { |c| c.match?(/\A(#|\$|_)/) || c.match?(/\("?\z/) || c.match?(/--/) || c.match?(/\A\W*\z/) || c.size < 5 || c.size > 20 }
end

File.write(File.expand_path('../mygame/app/texts.rb', __FILE__), "TEXTS = " + texts.sample(1000).to_json(indent: '  ').gsub('  "', "\n  \"") + "\n")
