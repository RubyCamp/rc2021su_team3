class Card < Sprite
	attr_accessor :id, :suit, :number

	SUIT_FONT_SIZE = 24
	NUMBER_FONT_SIZE = 36
	SUIT_FONT = Font.new(SUIT_FONT_SIZE)
	NUMBER_FONT = Font.new(NUMBER_FONT_SIZE)
	SUIT_LABELS = {
		spade: { text: '♠', color: C_BLACK },
		dia: { text: '♦', color: C_RED },
		club: { text: '♣', color: C_BLACK },
		heart: { text: '♥', color: C_RED }
	}

	def initialize(id, x, y, suit, number, director)
		self.id = id
		self.suit = suit
		self.number = number
		@reverse_image = Image.load('images/card_hatena.png')
		@foreground_image = Image.load('images/foreground_card.jpg')
		label = SUIT_LABELS[self.suit]
		@foreground_image.draw_font(5, 5, label[:text], SUIT_FONT, label[:color])
		char = number_char(self.number)
		char_width = NUMBER_FONT.get_width(char)
		@foreground_image.draw_font((@foreground_image.width - char_width) / 2, 30, char, NUMBER_FONT, C_BLACK)
		super(x, y, @reverse_image)
		@director = director
	end

	def update
		@dragging = true if Input.mouse_down?(M_RBUTTON)
		@dragging = false if Input.mouse_release?(M_RBUTTON)
		if @dragging && @director.opened_cards.include?(self)
			self.x = Input.mouse_x
			self.y = Input.mouse_y
		end
	end

	def draw
		Window.draw(self.x, self.y, self.image)
	end

	def open
		self.image = @foreground_image
	end

	def reverse
		self.image = @reverse_image
	end

	private

	def number_char(num)
		return 'A' if num == 1
		return 'J' if num == 11
		return 'Q' if num == 12
		return 'K' if num == 13
		return num.to_s
	end
end