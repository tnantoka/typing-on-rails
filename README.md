# Typing on Rails

![](/demo.gif)

## Setup

### Example texts

```
$ cp texts.rb.example mygame/app/
```

### Extract texts from Ruby on Rails Guides

```
$ mv path/to/rails/guides ./guides
$ ruby extract.rb
```

## Run


```
$ cp /path/to/dragonruby-macos/dragonruby .
$ cp /path/to/dragonruby-macos/font.ttf .

$ ./dragonruby
```

## Run with smaug

```bash
cd mygame
smaug install
smaug run
```

## Package

```
$ cp /path/to/dragonruby-macos/dragonruby-publish .
$ cp /path/to/dragonruby-macos/.dragonruby .
$ cp /path/to/dragonruby-macos/*.png .
$ cp /path/to/dragonruby-macos/open-source-licenses.txt .

$ ./dragonruby-publish --only-package
```

## License

My code is licensed under MIT.

## Acknowledgements

- [DragonRuby GTK](https://dragonruby.itch.io/dragonruby-gtk)
- [Press Start 2P](https://fonts.google.com/specimen/Press+Start+2P)
- [Hack](https://github.com/source-foundry/Hack)
- [Ruby on Rails Guides](https://guides.rubyonrails.org/)
