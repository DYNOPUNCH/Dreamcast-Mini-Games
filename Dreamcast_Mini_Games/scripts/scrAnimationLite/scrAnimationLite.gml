function spriteAnimation(_sprite) constructor
{
	sprite = _sprite;
	frameCount = sprite_get_number(_sprite);
	
	// Current frame index
	currentFrame = 0;       
	
	// Frames per second
	animationSpeed = sprite_get_speed(_sprite);  
	
	// Timer to track animation timing
	animationTimer = 0;
	
	function DrawAnimation(x, y)
	{
		draw_sprite(sprite, currentFrame, x, y);
	}
	
	function StepAnimation()
	{
		// Increment animation timer
		animationTimer += delta_time; 

		// Calculate the time required for the current frame
		var frameTime = 1000000 / animationSpeed;

		// Check if enough time has passed for the next frame
		if (animationTimer >= frameTime) 
		{
		    currentFrame += 1; // Move to the next frame
		    animationTimer = 0; // Reset the animation timer

		    // Loop back to the first frame if we reach the end of the animation
		    if (currentFrame >= frameCount) 
		        currentFrame = 0;
		}		
	}
	
}