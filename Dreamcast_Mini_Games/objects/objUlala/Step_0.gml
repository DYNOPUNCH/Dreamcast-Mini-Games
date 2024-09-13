/// @description 

switch(currentState)
{
    case ulalaState.ULALA_IDLE:
        sprite_index = sprUlala_Idle;
        break;

    case ulalaState.ULALA_UP:
        sprite_index = sprUlala_Up;
        break;

    case ulalaState.ULALA_RIGHT:
        sprite_index = sprUlala_Right;
        break;

    case ulalaState.ULALA_DOWN:
        sprite_index = sprUlala_Down;
        break;

    case ulalaState.ULALA_LEFT:
        sprite_index = sprUlala_Left;
        break;

    case ulalaState.ULALA_SHOOT:
        sprite_index = sprUlala_Shoot;
        break;

    case ulalaState.ULALA_HOLD:
        sprite_index = sprUlala_Hold;
        break;

    case ulalaState.ULALA_HURT:
        sprite_index = sprUlala_Hurt;
        break;

    case ulalaState.ULALA_DIE:
        sprite_index = sprUlala_Die;
        break;

    default:
        // Handle any unexpected states
        sprite_index = sprUlala_Idle; // Default to idle state
        break;
}