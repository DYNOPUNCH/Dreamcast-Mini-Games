/// @description 

//state for when the game is paused
if (currentGameState == gameState.GAME_PAUSE) 
{
    
}
// state for when the game starts for the first time from a new game
else if (currentGameState == gameState.GAME_START) 
{
	if(startTimer.runTimer() == true)
	{
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
	if(ulalaTimer.runTimer() == true)
	{
		ulalaObject.currentState = ulalaState.ULALA_IDLE;
		ulalaTimer.resetTimer();
		currentGameState = gameState.GAME_SWITCH_PROMPT;
	}
	
	ulalaPatternStates();
	
    show_debug_message("Ulala Prompt");
} 
// state for if Ulala did it wrong
else if (currentGameState == gameState.GAME_ULALA_WIN) 
{
    
}
// state for if Ulala misses
else if (currentGameState == gameState.GAME_ULALA_LOSE) 
{
    
} 
// State for if you run out of hearts (check this at the end of ulala losing
else if (currentGameState == gameState.GAME_GAMEOVER) 
{
    
} 
else 
{
    
}