require 'app/primitives.rb'
require 'app/texts.rb'

class Game
  attr_accessor :state, :outputs, :grid, :inputs

  FONTS = {
    base: 'fonts/Press_Start_2P/PressStart2P-Regular.ttf',
    code: 'fonts/Hack-v3.003-ttf/ttf/Hack-Regular.ttf',
    code_bold: 'fonts/Hack-v3.003-ttf/ttf/Hack-Bold.ttf',
  }

  def tick
    set_defaults
    handle_inputs
    update_state
    output
  end

  def set_defaults
    state.started_at ||= Time.new

    state.text ||= TEXTS.sample
    state.input ||= ''
    state.total_input ||= 0

    state.wpm ||= 0
  end

  def handle_inputs
    if state.input.size < state.text.size
      char = state.text[state.input.size]
      if input?(char)
        state.input += char
      end
    else
      puts "next"
      state.total_input += state.text.size
      state.text = TEXTS.sample
      state.input = ''
    end
  end

  def update_state
    state.wpm = wpm
  end

  def output
    outputs.background_color = [245, 245, 245]

    outputs.labels << Label.new(
      x: grid.center_x,
      y: grid.center_y,
      text: state.text,
      alignment_enum: 1,
      font: FONTS[:code],
      size_enum: 10,
      r: 150,
      g: 150,
      b: 150
    )

    outputs.labels << Label.new(
      x: grid.center_x,
      y: grid.center_y,
      text: state.input + ' ' * (state.text.size - state.input.size),
      alignment_enum: 1,
      font: FONTS[:code_bold],
      size_enum: 10
    )

    outputs.labels << Label.new(
      x: grid.center_x,
      y: grid.center_y - 20,
      text: ' ' * state.input.size + '_' + ' ' * [state.text.size - state.input.size - 1, 0].max,
      alignment_enum: 1,
      font: FONTS[:code],
      size_enum: 10
    )


    time = elapsed_time
    minutes = (time.to_i / 60).floor
    seconds = time.to_i % 60
    milliseconds10 = time * 100 % 100

    outputs.labels << Label.new(
      x: grid.w * 0.1,
      y: grid.h * 0.9,
      text: [minutes, seconds, milliseconds10].map { |t| '%02d' % t }.join(':'),
      alignment_enum: 0,
      font: FONTS[:base],
      size_enum: -1
    )

    outputs.labels << Label.new(
      x: grid.w * 0.9,
      y: grid.h * 0.9,
      text: "WPM: %.1f" % state.wpm.to_s,
      alignment_enum: 2,
      font: FONTS[:base],
      size_enum: -1
    )
  end

  def serialize
    {}
  end

  def inspect
    serialize.to_s
  end

  def to_s
    serialize.to_s
  end

  private

  def input?(char)
    sym = {
      '!'  => :exclamation_point,
      '0'  => :zero,
      '1'  => :one,
      '2'  => :two,
      '3'  => :three,
      '4'  => :four,
      '5'  => :five,
      '6'  => :six,
      '7'  => :seven,
      '8'  => :eight,
      '9'  => :nine,
      '('  => :open_round_brace,
      ')'  => :close_round_brace,
      '{'  => :open_curly_brace,
      '}'  => :close_curly_brace,
      '['  => :open_square_brace,
      ']'  => :close_square_brace,
      ':'  => :colon,
      ';'  => :semicolon,
      '='  => :equal_sign,
      '-'  => :hyphen,
      ' '  => :space,
      '$'  => :dollar_sign,
      '"'  => :double_quotation_mark,
      "'"  => :single_quotation_mark,
      '`'  => :backtick,
      '~'  => :tilde,
      '.'  => :period,
      ','  => :comma,
      '|'  => :pipe,
      '_'  => :underscore,
      '#'  => :hash,
      '+'  => :plus,
      '@'  => :at,
      '/'  => :forward_slash,
      '\\'  => :back_slash,
      '*'  => :asterisk,
      '<'  => :less_than,
      '>'  => :greater_than,
      '^'  => :greater_than,
      '&'  => :ampersand,
      '?'  => :question_mark,
      '%'  => :percent_sign
    }[char] || char.downcase.to_sym

    include_keys = [
      sym,
      sym.to_s.upcase == char ? :shift : nil
    ].compact
    exclude_keys = [
      sym.to_s.downcase == char ? :shift : nil
    ].compact
    include_keys.all? { |key| inputs.keyboard.key_down.truthy_keys.include?(key) } &&
      exclude_keys.none? { |key| inputs.keyboard.key_down.truthy_keys.include?(key) }
  end

  def elapsed_time
    Time.new - state.started_at
  end

  def wpm
    words = (state.total_input + state.input.size) / 5
    minutes = (elapsed_time / 60).ceil
    state.wpm = words / minutes
  end
end

$game = Game.new

def tick args
  $game.state = args.state
  $game.outputs = args.outputs
  $game.grid = args.grid
  $game.inputs = args.inputs
  $game.tick
end
