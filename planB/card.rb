class Card < Sprite
    attr_accessor :prefecture
    attr_reader :open, :reverse
    WAIT_FRAMES = 60
    IMAGES = {
         "島根" => Image.load("images/shimane.png"),
         "鳥取" => Image.load("images/tottori.png"),
         "広島" => Image.load("images/hiroshima.png"),
         "山口" => Image.load("images/yamaguchi.png"),
         "岡山" => Image.load("images/okayama.png"),
         "高知" => Image.load("images/kouchi.png"),
         "香川" => Image.load("images/udon.png"),
         "愛媛" => Image.load("images/ehime.png"),
         "徳島" => Image.load("images/tokushima.png"),
    }

    FONT = Font.new(16)
    def initialize(x, y, ura_img, omote_img, prefecture)
        self.prefecture = prefecture
        
        # @prefecture = prefecture
        @ura_img = ura_img
        # @ura_img.draw(0, 0, Image.load("images/maru.png"))
        @omote_img = omote_img
        @omote_img.draw(0, 0, IMAGES[prefecture])
        @omote_img.draw_font(23, 10, self.prefecture.to_s, FONT, C_BLACK)
        self.image = ura_img
        super(x, y, self.image)
        @speed = 1
    end
    ##### Spriteの引数がわからないとき ############
        # def initialize(*args)
        #     super(*args)
        #     @speed = 5
        # end
    ##############################################
    def update
            # @x += rand(3) - 1
            # @y += rand(3) - 1
            # self.x += rand(3) - 1   
            # self.y += rand(3) - 1
            # self.x += (rand(3) - 1) * 5   # 動きを5倍にする
            # self.y += (rand(3) - 1) * 5
            # self.x += (rand(3) - 1) * @speed  
            # self.y += (rand(3) - 1) * @speed
    end   
    
    # def hit(obj)
    #     reverse if Input.mouse_push?(M_LBUTTON)
    # end

    def reverse
        if self.image == @ura_img
            self.image = @omote_img
        else
            self.image = @ura_img
        end
        
    end

    # def open
    #     self.image = @omote_img
    # end

    # def reverse
    #     self.image = @ura_img
    # end
end
