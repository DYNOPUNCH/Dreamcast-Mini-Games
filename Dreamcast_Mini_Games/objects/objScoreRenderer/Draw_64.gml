/// @description 

var charIndex = 0;
var charSpacing = 10; 
var scoreStr = string_replace_all(string_format(score, 2, 0), " ", "0");

if(emblemAlignment == emblemAlignment.ALIGN_START)
{
	draw_sprite(emblemIcon, 0, x, y);
	charIndex += (sprite_get_width(emblemIcon) + spacing)
}
else if(emblemAlignment == emblemAlignment.ALIGN_END)
{
	draw_sprite(emblemIcon, 0, x + (string_length(scoreStr) * sprite_get_width(numberSprites)) + spacing, y);
}

// go through each character and render them with the sprite.
for(var i = 0; i < string_length(scoreStr); i++)
{	
	draw_sprite(numberSprites, real(string_char_at(scoreStr, i+1)), charIndex + x, y);
	charIndex += (sprite_get_width(numberSprites) + spacing);
}