module Game
  class Director < DirectorBase
    attr_accessor :deck_cards, :opened_cards

    SCORE_X = 20
    SCORE_Y = 450
    SCORE_FONT = Font.new(42)
    SCORE_GAP = 43
    WAIT_FRAMES = 60
    TIMER_FONT = Font.new(30)

    def initialize
      @timer = 1*30*30+60
      @counter = 0
      @bg = Image.load('images/haikei.jpg')
      @suits = [:spade, :club, :dia, :heart]
      @pointer = Pointer.new(self)
      @correct_sound = Sound.new("sounds/correct.wav")
      @incorrect_sound = Sound.new("sounds/incorrect.wav")
    end

    def reload
      self.deck_cards = []
      id = 1
      x = 50
      y = 40

      @suits.each do |suit|
        1.upto(13) do |n|
          @deck_cards << Card.new(id, 0, 0, suit, n, self)
          id += 1
        end
      end
      @deck_cards#.shuffle!
      @deck_cards.each do |card|
        card.x = x
        card.y = y
        if x < 841
          x += 70
        else
          x = 50
          y += 100
        end
      end
      @wait = WAIT_FRAMES
      @opened_cards = []
      @score = {
        1 => 0,
        2 => 0
      }
      @player_id = 1
    end
    
    def play
      if  @timer>0
        @timer-=1
      else
        win_director = Scene.get(:win)
        if @score[1] > @score[2]
          win_director.winner = 1
        elsif @score[1] < @score[2]
          win_director.winner = 2
        end
        Scene.move_to(:win)
      end
      puts @timer
      
      Window.draw(0, 0, @bg)
      self.deck_cards.sort_by{|c| c.id }.each(&:draw)
      draw_score
      @pointer.update
      Sprite.update(self.deck_cards)
      Sprite.check(@pointer, self.deck_cards)
      if @wait > 0 && @opened_cards.size == 4
        @wait -= 1
        return
      end
      if @opened_cards.size == 4
        if judgement
          @opened_cards.each do |c|
            self.deck_cards.delete(c)
            @score[@player_id] += 1
            @correct_sound.play
            @counter = 60
            
          end
        else
          @incorrect_sound.play
          @opened_cards.each(&:reverse)
          change_player
        end
        @opened_cards = []
        @wait = WAIT_FRAMES
      end
      draw_font_center(200, "正解！！", 100, color: C_RED) if @counter > 0
      @counter -= 1 if @counter > 0
      if self.deck_cards.size == 0
        win_director = Scene.get(:win)
        if @score[1] > @score[2]
          win_director.winner = 1
        elsif @score[1] < @score[2]
          win_director.winner = 2
        end
        Scene.move_to(:win)
      end
      if @timer/60 < 10
        timer_color = C_RED
      else
        timer_color = C_BLACK
      end
      Window.draw_font(750,500,"制限時間: #{@timer/60}秒",TIMER_FONT, color:timer_color)
    end
    
    def add_opened_card(card)
      return if @opened_cards.size == 4
      return if @opened_cards.include?(card)
      @opened_cards << card
    end

    def locked?
      @opened_cards.size == 4 && @wait > 0
    end

    private

    def change_player
      if @player_id == 1
        @player_id = 2
      else
        @player_id = 1
      end
    end

    def judgement
      @opened_cards.map{|c|c.number}.uniq.size == 1
    end

    def draw_score
      y_pos = SCORE_Y
      @score.each do |pid, score|
        color = C_BLACK
        color = C_RED if pid == @player_id
        Window.draw_font(SCORE_X, y_pos, "P#{pid}: #{score}", SCORE_FONT, color: color)
        y_pos += SCORE_GAP
      end
    end
  end
end
