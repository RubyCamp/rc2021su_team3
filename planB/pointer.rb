class Pointer < Sprite
    attr_accessor :score, :active, :game_end
    attr_reader :hit_cards

    # WAIT_FRAMES = 60

    def initialize(*args)
        @hit_cards = []
        @sound = Sound.new("sounds/トランプ・カードをめくる音.wav")
        @sound_hit = Sound.new("sounds/「ピロリ」決定のボタン音・アクセント音.wav")
        @score = 0
        @active = false
        @game_end = false
        super(*args)
        @counter = 60
    end

    def update
        self.x = Input.mouse_x
        self.y = Input.mouse_y

        if @hit_cards.size == 2
            @counter = 60 if @counter < 0
            @counter -= 1
            if @counter < 0
                if judgement
                    @sound_hit.play
                    @hit_cards.each do |card|
                        card.vanish
                    @score += 0.5 
                    end
                    # @sound_hit.play
                else
                    @hit_cards.each do |card|
                        card.reverse
                    end
                end
                @hit_cards = []
                # @waite = WAIT_FRAMES
                # @sound.play
                # @score += 1  # NG!!めくるだけで加算される
            end
        end
        
    end

    def shot(card)
        if Input.mouse_push?(M_LBUTTON) && !@hit_cards.include?(card) && @hit_cards.size < 2
            card.reverse
            @hit_cards << card
            @sound.play
            # @waite = WAIT_FRAMES
        end 
        # @sound.play NG!! 一生ループ再生される
        # @score += 1 NG!! 当たった分一生加算される
        
    end

    def judgement
        c1 = @hit_cards[0]
        c2 = @hit_cards[1]
        c1.prefecture == c2.prefecture
    end

    def timeout
        @active = false
    end

    def restart
        @hit_cards = []
        @score = 0
        @active = true
        @game_end =false
    end
end