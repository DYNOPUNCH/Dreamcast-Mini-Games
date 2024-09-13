/// @description 
ulalaObject = instance_find(objUlala, 0);
alienObject = instance_find(objAlien, 0);
healthObject = instance_find(objHealth, 0);
promptObject = instance_find(objPrompt, 0);
scoreObject = instance_find(objScoreRenderer, 0);

enum gameState
{
	GAME_PAUSE = -1,
	GAME_START = 0,
	GAME_SWITCH_PROMPT = 1,
	GAME_ALIEN_PROMPT = 2,
	GAME_ULALA_PROMPT = 3,
	GAME_ULALA_WIN = 4,
	GAME_ULALA_LOSE = 5,
	GAME_GAMEOVER = 6
}

// Timer variables
startTimer = new timer(1);
switchTimer = new timer(1);
alienTimer = new timer(2);
ulalaTimer = new timer(3);
winTimer = new timer(2);
loseTimer = new timer(2);
gameoverTimer = new timer(2);

promptTimer = new timer(1);

// Variable that dictates who's turn it is.
alienTurn = true;

promptFlash = true;

// Variable that stores the game state.
currentGameState = gameState.GAME_START;

// Use this for a push pop state event when you unpause.
pauseState = noone;

//Dance Patterns
pattern = [0, 1, 2, 3];

currentPattern = pattern;

patternIndex = 0;

function alienPatternStates(_state)
{
	switch(_state)
	{
		case actionPrompts.PROMPT_UP:
			alienObject.currentState = alienState.ALIEN_UP;
			break;
		case actionPrompts.PROMPT_RIGHT:
			alienObject.currentState = alienState.ALIEN_RIGHT;
			break;
		case actionPrompts.PROMPT_DOWN:
			alienObject.currentState = alienState.ALIEN_DOWN;
			break;
		case actionPrompts.PROMPT_LEFT:
			alienObject.currentState = alienState.ALIEN_LEFT;
			break;
		case actionPrompts.PROMPT_A:
			alienObject.currentState = alienState.ALIEN_HOLD;
			break;
		case actionPrompts.PROMPT_B:
			alienObject.currentState = alienState.ALIEN_SHOOT;
			break;
		default:
			alienObject.currentState = alienState.ALIEN_HOLD
			break
	}
}

function ulalaPatternStates()
{
	
	if(input_check_pressed("up"))
		ulalaObject.currentState = ulalaState.ULALA_UP;
	else if(input_check_pressed("right"))
		ulalaObject.currentState = ulalaState.ULALA_RIGHT;
	else if(input_check_pressed("down"))
		ulalaObject.currentState = ulalaState.ULALA_DOWN;
	else if(input_check_pressed("left"))
		ulalaObject.currentState = ulalaState.ULALA_LEFT;
	else if(input_check_pressed("accept"))
		ulalaObject.currentState = ulalaState.ULALA_HOLD;
	else if(input_check_pressed("cancel"))
		ulalaObject.currentState = ulalaState.ULALA_SHOOT;
	
}

