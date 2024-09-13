/// @description 

// else machine, may optimize later

if(input_check_pressed("up"))
	userAction = actionPrompts.PROMPT_UP;
else if(input_check_pressed("right"))
	userAction = actionPrompts.PROMPT_RIGHT;
else if(input_check_pressed("down"))
	userAction = actionPrompts.PROMPT_DOWN;
else if(input_check_pressed("left"))
	userAction = actionPrompts.PROMPT_LEFT;
else if(input_check_pressed("accept"))
	userAction = actionPrompts.PROMPT_A;
else if(input_check_pressed("cancel"))
	userAction = actionPrompts.PROMPT_B;
else
	userAction = actionPrompts.PROMPT_NULL;