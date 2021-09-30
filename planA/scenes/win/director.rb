module Win
	class Director < DirectorBase
		attr_accessor :winner

		def initialize
			@bg = Image.load('images/temple.jpg')
			@bg_size_width = Window.width / @bg.width.to_f
			@bg_size_height = Window.height / @bg.height.to_f
			self.winner = nil
		end

		def reload
		end

		def play
			Scene.move_to(:title) if Input.key_push?(K_SPACE)
			Window.draw_scale(0, 0, @bg, @bg_size_width, @bg_size_height, 0, 0)
			if self.winner
				draw_font_center(300, "P#{self.winner} 勝ち!", 100, color: C_GREEN)
			else
				draw_font_center(228, "引き分け", 72, color: C_RED)
			end
		end
	end
end