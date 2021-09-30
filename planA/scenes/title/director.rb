module Title
  class Director < DirectorBase
    def initialize
      # @bg = Image.load('images/bg_title.png')
      # @bg = Image.new(1000, 500, color: C_RED)

    end

    def reload
    end
  
    def play
      Scene.move_to(:game) if Input.key_push?(K_SPACE)
      # Window.draw(0, 0, @bg)
      Window.bgcolor = [29,161,242]
      draw_font_center(140, "神経衰弱", 72, color: C_WHITE)
      draw_font_left(300, "ルール", 30, color: C_WHITE, :x_offset => 330)
      draw_font_left(340, "4枚カードを揃える神経衰弱！", 30, color: C_WHITE, :x_offset => 330)
      draw_font_left(380, "制限時間は180秒です。", 30, color: C_WHITE, :x_offset => 330)
      draw_font_center(550, "スペースキーを押すと始まります。", 38, color: C_WHITE)
    end
  end
end