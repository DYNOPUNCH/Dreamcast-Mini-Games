/// @description 
draw_sprite(sprPromptBox, 0, x, y);

if(currentPrompt == -1)
	exit;

draw_sprite(sprPrompt, clamp(userAction, 0, 6), x + 2, y + 2);

