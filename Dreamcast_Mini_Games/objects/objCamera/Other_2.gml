/// @description 

view_enabled = true;
view_visible[0] = true;

// Move camera instantly to player.

if(instance_exists(targetObject))
{
	var xAxis = 0;
	var yAxis = 0;
	
	if(room_width >= viewWidth)
		xAxis = clamp(targetObject.x - (viewWidth / 2), 0, room_width - viewWidth);
	else
		xAxis = (room_width / 2) - (viewWidth / 2);
	
	if(room_height >= viewHeight)
		yAxis = clamp(targetObject.y - (viewHeight / 2), 0, room_height - viewHeight);
	else 
		yAxis = (room_height / 2) - (viewHeight / 2);
	
	camera_set_view_pos(view, xAxis + cameraX, yAxis + cameraY);
}
else
{
	var xAxis = 0;
	var yAxis = 0;
	
	xAxis = (room_width / 2) - (viewWidth / 2);
	yAxis = (room_height / 2) - (viewHeight / 2);
	
	camera_set_view_pos(view, xAxis + cameraX, yAxis + cameraY);
}

display_set_gui_size(viewWidth, viewHeight);
