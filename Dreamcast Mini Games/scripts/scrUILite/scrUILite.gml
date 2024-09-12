function touchScreenButton() constructor
{
	_buttonSprite = sprButton;
	_font = fntStrongGamer;
	_text = "NULL"
	_buttonWidth = 160;
	_buttonHeight = 60;
	_x = 480 / 2 - _buttonWidth / 2;
	_y = 270 / 2 - _buttonHeight / 2;
	_buttonAction = noone;
	_triggerMessage = "Default"
	_triggerSet = false;
	_alpha = 1;
	_payload = noone;
	isHeld = false
	


	function translate(_X, _Y, _Z)
	{
		_x = _X;
		_y = _Y;
		_sprite.depth = _Z;
	}

	function buttonHover()
	{
		if(_alpha != 1)
			return 0;

		var hover = rectangle_in_rectangle(_x , _y, _x + _buttonWidth, _y + _buttonHeight,
		device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), device_mouse_x_to_gui(0) + 1, device_mouse_y_to_gui(0) + 1) == 0 ? false : true;

		return hover;
	}

	function drawSelf()
	{
		var _yPress = 0;
		draw_set_alpha(_alpha);

		draw_set_font(_font);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);

		var buttonSpriteWidth = sprite_get_width(_buttonSprite);
		var buttonSpriteHeight = sprite_get_height(_buttonSprite);

		// itemize this.
		var hover = buttonHover();
		isHeld = false

		if(_alpha == 1)
		{
			_buttonAction = noone;

			if(_triggerSet)
			{
				_triggerSet = false;
				_buttonAction = _triggerMessage;

			}

			if (hover)
			{
				if (mouse_check_button(mb_left))
				{
					_yPress = 5;
					isHeld = true
				}
				if (mouse_check_button_released(mb_left))
				{
					_triggerSet = true;
				}
			}

		}

		draw_sprite_ext(_buttonSprite, hover, _x, _y + _yPress, _buttonWidth / buttonSpriteWidth, _buttonHeight / buttonSpriteHeight, 0, c_white, _alpha);

		draw_text_ext(_x + (_buttonWidth / 2),
		_y + _yPress + (_buttonHeight / 2),
		_text,
		-1,
		_buttonWidth);

		draw_set_alpha(1);

	}

}
