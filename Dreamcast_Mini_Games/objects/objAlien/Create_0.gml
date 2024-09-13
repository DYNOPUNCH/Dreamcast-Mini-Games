/// @description 
enum alienState
{
    ALIEN_IDLE = -1,
    ALIEN_UP = 0,
    ALIEN_RIGHT = 2,
    ALIEN_DOWN = 3,
    ALIEN_LEFT = 4,
    ALIEN_SHOOT = 5,
    ALIEN_HOLD = 6,
    ALIEN_HURT = 7,
    ALIEN_DIE = 8
}

currentState = alienState.ALIEN_IDLE;