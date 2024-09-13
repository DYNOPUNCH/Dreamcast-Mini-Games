/// @description 

enum ulalaState
{
	ULALA_IDLE = -1,
	ULALA_UP = 0,
	ULALA_RIGHT = 2,
	ULALA_DOWN = 3,
	ULALA_LEFT = 4,
	ULALA_SHOOT = 5,
	ULALA_HOLD = 6,
	ULALA_HURT = 7,
	ULALA_DIE = 8
}

currentState = ulalaState.ULALA_IDLE;