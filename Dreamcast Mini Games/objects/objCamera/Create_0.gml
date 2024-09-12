/// @description 

window_set_size(viewWidth * windowScale, viewHeight * windowScale);
alarm[0] = 1;

surface_resize(application_surface, viewWidth * windowScale, viewHeight * windowScale);

display_set_gui_size(viewWidth, viewHeight);

camShakeX = 0;
camShakeY = 0;

freezeX = 0;
freezeY = 0;

isFrozen = false;
shakeTimer = 0;
shakeTimerMax = 0;

rangeRam = 0;

hasRoomChanged = false;

xPeek = 0;
yPeek = 0;

function cameraShakeReset()
{
	camShakeX = 0;
	camShakeY = 0;
}

function cameraShakeSet(_range, _time)
{	
	rangeRam = _range;

	shakeTimer++;
	shakeTimerMax = _time;
}

function cameraSetFrozen()
{
	isFrozen = true;
}

function cameraSetUnFrozen()
{
	isFrozen = false;
}

