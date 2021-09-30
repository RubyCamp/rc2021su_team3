require 'dxruby'
require 'singleton'

require_relative 'lib/director_base'
require_relative 'lib/card'
require_relative 'lib/pointer'

require_relative 'scene'
require_relative 'scenes/game/director'
require_relative 'scenes/title/director'
require_relative 'scenes/win/director'

Window.width = 1000
Window.height = 600
Window.caption = "RubyCamp 2021Summer Sample Game"

Scene.add(Game::Director.new, :game)
Scene.add(Win::Director.new, :win)
Scene.add(Title::Director.new, :title)
Scene.move_to(:title)

Window.loop do
  break if Input.key_push?(K_ESCAPE)
  Scene.play
end
