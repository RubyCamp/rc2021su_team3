require 'dxruby'
# require_relative 'character'  # DXRubyにすでに存在するクラス 'Sprite'
require_relative 'pointer'   # 分割したクラスのファイルを読み込む
require_relative 'card'

Window.width = 800
Window.height = 600
Window.bgcolor = [175, 238, 238, 0]
Window.caption = "中四国ゲーム"

pointer_img = Image.new(10,10, C_RED)
omote_img = Image.load("images/foreground_card.png")
ura_img = Image.load("images/uramaru.png")

pointer = Pointer.new(300, 300, pointer_img)

# a = Image.load("images/bitmap1.png")
# b = Image.load("images/bitmap2.png")

a = "島根"
b = "鳥取"
c = "広島"
d = "岡山"
e = "山口"
f = "高知"
g = "香川"
h = "愛媛"
i = "徳島"

cards = []
x = 60
y = 90
# arr = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10]
# arr = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
# arr = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
arr = [a, a, b, b, c, c, d, d, e, e, f, f, g, g, h, h, i, i]
# arr = [a, a, a, a, a, a, a, a, a, b, b, b, b, b, b, b, b, b,]

arr.shuffle!

arr.size.times do |num|
    cards << Card.new(x, y, ura_img, omote_img.dup, arr[num])
    if x < 600
        x += 110
    else
        x = 60
        y += 160
    end
end

timer = 1800 + 60
font = Font.new(32)
counter = 150
Window.loop do      # ブロック内のコードを60times/secで実行し続けて(loopして)いる  

    break if Input.key_push?(K_ESCAPE) # ESCAPEキーを押すと、ゲーム画面を終了する

    if pointer.active
        if cards.size == 0        
            pointer.active = false
            pointer.game_end = true
        elsif timer >= 60
            timer -= 1
        else
            pointer.active = false
            pointer.game_end = true
        end
        cards.delete_if{|card| card.vanished?}

        cards.each do |card|
            card.update
            card.draw
        end


        pointer.update   #　プレイヤーキャラの座標を更新
        pointer.draw     #　プレイヤーキャラの画像を描画

        Window.draw_font(10, 35, "残り時間 : #{timer / 60}秒", font) # 残り時間を表示させる
        Window.draw_font(10, 10, "スコア：#{pointer.score.to_i}", font)

        Sprite.check(pointer, cards)
    end

    # Window.draw_font(10, 35, "残り時間 : #{timer / 60}秒", font) # 残り時間を表示させる
    # Window.draw_font(10, 10, "スコア：#{pointer.score.to_i}", font)



    if !pointer.active
        # if cards.size == 0 && counter > 0
        #     counter -= 1
        #     Window.draw_font(250, 180, "YOU WON!!", font,{color: C_RED})
        #     Window.draw_font(250, 220, "CONGRATULATIONS!", font)
        # end
        if pointer.game_end && counter > 0
            counter -= 1
            if cards.size == 0
                Window.draw_font(250, 180, "YOU WON!!", font,{color: C_RED})
                Window.draw_font(250, 220, "CONGRATULATIONS!", font)
            else
                Window.draw_font(250, 180, "GAMEOVER", font,{color: C_RED})
                Window.draw_font(250, 220, "TOTAL SCORE：#{pointer.score.to_i}", font)
            end
        end
        # p pointer.game_end
        Window.draw_font(200, 450, "START GAME: PRESS SPACE", font,{color: C_BLUE})
        Window.draw_font(200, 480, "QUIT GAME: PRESS ESCAPE", font,{color: C_BLUE})
        if Input.key_push?(K_SPACE)
            pointer.restart
            timer = 1800 + 60
            counter = 150
            cards = []
            x = 60
            y = 90
            # arr = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10]
            # arr = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
            # arr = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]

            arr.shuffle!

            arr.size.times do |num|
                cards << Card.new(x, y, ura_img, omote_img.dup, arr[num])
                if x < 600
                    x += 120
                else
                    x = 60
                    y += 180
                end
            end
        end
    end
end