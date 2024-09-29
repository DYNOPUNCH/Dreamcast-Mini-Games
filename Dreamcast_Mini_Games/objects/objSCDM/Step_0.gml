/// @description 
/*
//state for when the game is paused
if (currentGameState == gameState.GAME_PAUSE) 
{
    
}
// state for when the game starts for the first time from a new game
else if (currentGameState == gameState.GAME_START) 
{
	if(startTimer.runTimer() == true)
	{
		// Randomly pick a pattern.
		
		changePattern();
		
		startTimer.resetTimer();
		currentGameState = gameState.GAME_SWITCH_PROMPT;
	}
}
// state for switching between Ulala and the Alien
else if (currentGameState == gameState.GAME_SWITCH_PROMPT) 
{
	if(switchTimer.runTimer() == true)
	{
		switchTimer.resetTimer();
		
		// Check who's turn it is and chnage the state accordingly.
		// Alien should always go first.
		
		if(alienTurn == true)
			currentGameState = gameState.GAME_ALIEN_PROMPT;
		else
			currentGameState = gameState.GAME_ULALA_PROMPT;
		
		alienTurn = !alienTurn;
	}
	
	show_debug_message("Switch Prompt");
} 
// state for the Alien's prompt.
else if (currentGameState == gameState.GAME_ALIEN_PROMPT) 
{
	
	promptObject.currentPrompt = currentPattern[patternIndex];
	show_debug_message("Alien Prompt" + string(currentPattern[patternIndex]));
	alienPatternStates(currentPattern[patternIndex]);
	
	if(promptTimer.runTimer() == true)
	{
		patternIndex++;
		promptTimer.resetTimer();
		
		if(patternIndex == array_length(currentPattern))
		{
			alienPatternStates(-1);
			promptObject.currentPrompt = -1;
			patternIndex = 0;
			currentGameState = gameState.GAME_SWITCH_PROMPT
		}
	}
	
    
} 
// state for Ulala's copy cat prompt
else if (currentGameState == gameState.GAME_ULALA_PROMPT) 
{
	// Setup timer and counts for ulala's part.
	if(ulalaTimer.runTimer() == true)
	{
		patternIndex = 0;
		currentGameState = gameState.GAME_ULALA_LOSE;
		ulalaTimer.resetTimer();
	}
	
	// Manage success and error of the prompts.
	if()
	{
		patternIndex++;
	}
	
	if(ulalaPatternStates() == currentPattern[patternIndex])
	{
		patternIndex = 0;
		currentGameState = gameState.GAME_ULALA_LOSE;
		ulalaTimer.resetTimer();
	}
	
	// If you succeed in doing the prompts change state to win state.
	if(patternIndex == array_length(currentPattern))
	{
		patternIndex = 0;
		currentGameState = gameState.GAME_ULALA_WIN;
		ulalaTimer.resetTimer();
	}
	

	
    show_debug_message("Ulala Prompt");
} 
// state for if Ulala did it wrong
else if (currentGameState == gameState.GAME_ULALA_WIN) 
{
	ulalaObject.currentState = ulalaState.ULALA_HURT;
    changePattern();
}
// state for if Ulala misses
else if (currentGameState == gameState.GAME_ULALA_LOSE) 
{
	ulalaObject.currentState = ulalaState.ULALA_HURT;
    changePattern();
} 
// State for if you run out of hearts (check this at the end of ulala losing
else if (currentGameState == gameState.GAME_GAMEOVER) 
{
    
} 
else 
{
    
}
*/

gameEvents.runEventChain();
musicSys.runSystem();
