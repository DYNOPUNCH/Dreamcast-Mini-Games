/// @description 

var healthState = 0;

for(var i = 0; i < maxHealth; i++)
{
	if(i < currentHealth)
		healthState = 1
	else
		healthState = 0;
	
	draw_sprite(healthIcon, healthState, ((sprite_get_width(healthIcon) + spacing) * i) + x , y);	
}