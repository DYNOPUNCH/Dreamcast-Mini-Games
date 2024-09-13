/// @description 
// Handle the current state
switch(currentState)
{
    case alienState.ALIEN_IDLE:
        sprite_index = sprAlien_Hold;
        break;

    case alienState.ALIEN_UP:
        sprite_index = sprAlien_Up;
        break;

    case alienState.ALIEN_RIGHT:
        sprite_index = sprAlien_Right;
        break;

    case alienState.ALIEN_DOWN:
        sprite_index = sprAlien_Down;
        break;

    case alienState.ALIEN_LEFT:
        sprite_index = sprAlien_Left;
        break;

    case alienState.ALIEN_SHOOT:
        sprite_index = sprAlien_Shoot;
        break;

    case alienState.ALIEN_HOLD:
        sprite_index = sprAlien_Hold;
        break;

    case alienState.ALIEN_HURT:
        sprite_index = sprAlien_Hurt;
        break;

    case alienState.ALIEN_DIE:
        sprite_index = sprAlien_Die;
        break;

    default:
        // Handle any unexpected states
        sprite_index = sprAlien_Hold; // Default to idle state
        break;
}