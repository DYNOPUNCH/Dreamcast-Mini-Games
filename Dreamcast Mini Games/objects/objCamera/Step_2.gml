/// @description 

#macro view view_camera[0]
camera_set_view_size(view, viewWidth, viewHeight);

if(instance_exists(targetObject))
{
	if(isFrozen == false)
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
	
	var camCurrentX = camera_get_view_x(view);
	var camCurrentY = camera_get_view_y(view);
	
	var camSpeed = 0.09;
	
	camera_set_view_pos(view, 
	lerp(camCurrentX, xAxis + xPeek, camSpeed), 
	lerp(camCurrentY, yAxis + yPeek, camSpeed));
	
	if(camShakeX != 0 || camShakeY != 0)
		camera_set_view_pos(view, xAxis + camShakeX, yAxis + camShakeY);
	
	freezeX = xAxis;
	freezeY = yAxis;
	}
	else
	{
		var xAxis = 0;
		var yAxis = 0;
	
		if(room_width >= viewWidth)
			xAxis = clamp(targetObject.x - (viewWidth / 2) + (sprite_get_width(targetObject.sprite_index) / 2), 0, room_width - viewWidth);
		else
			xAxis = (room_width / 2) - (viewWidth / 2);
	
		if(room_height >= viewHeight)
			yAxis = clamp(targetObject.y - (viewHeight / 2) + (sprite_get_height(targetObject.sprite_index) / 2), 0, room_height - viewHeight);
		else 
			yAxis = (room_height / 2) - (viewHeight / 2);
	
		var camCurrentX = camera_get_view_x(view);
		var camCurrentY = camera_get_view_y(view);
	
		var camSpeed = 0.05;
		
		camera_set_view_pos(view, camCurrentX + cameraX, camCurrentY + cameraY);
	}
	
}
else
{
	var xAxis = 0;
	var yAxis = 0;
	
	xAxis = (room_width / 2) - (viewWidth / 2);
	yAxis = (room_height / 2) - (viewHeight / 2);
	
	camera_set_view_pos(view, xAxis + cameraX, yAxis + cameraY);
}
