// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function beatObject(_position, _audio) constructor
{
	targetInterval = _position;
	
	audio = _audio;
	
	rankOne = 0.1;
	rankTwo = 0.12;
	rankThree = 0.16;
	rankBad = 0.4;
	
	text = "---";
	
	function drawSelf()
	{
		draw_set_color(c_green);
		draw_line(
		normalize(targetInterval, 0, audio.songLength) * objCamera.viewWidth,
		0,
		normalize(targetInterval, 0, audio.songLength) * objCamera.viewWidth,
		objCamera.viewHeight);
		draw_set_color(c_white);
	}
	
	function detectStep()
	{
		if(point_in_rectangle(audio_sound_get_track_position(audio.audioProcessing), 0, 
			targetInterval - rankBad/2, -1,
			targetInterval + rankBad/2, 1))
		{
			if(point_in_rectangle(audio_sound_get_track_position(audio.audioProcessing), 0, 
				targetInterval - rankOne/2, -1,
				targetInterval + rankOne/2, 1))
				{
					text = "Great!";
					show_debug_message(text);
					return true;
				}
			else if(point_in_rectangle(audio_sound_get_track_position(audio.audioProcessing), 0, 
				targetInterval - rankTwo/2, -1,
				targetInterval + rankTwo/2, 1))
				{
					text = "OK!";
					show_debug_message(text);
					return true;
				}
			else if(point_in_rectangle(audio_sound_get_track_position(audio.audioProcessing), 0, 
				targetInterval - rankThree/2, -1,
				targetInterval + rankThree/2, 1))
				{
					text = "OK...";
					show_debug_message(text);
					return true;
				}
			else if(point_in_rectangle(audio_sound_get_track_position(audio.audioProcessing), 0, 
				targetInterval - rankBad/2, -1,
				targetInterval + rankBad/2, 1))
			{
			
				text = "Bad...";
				show_debug_message(text);
				return true;
			}
			
			return false;
		}
	}

}

function timeSigniture(_top, _bottom) constructor
{
	top = _top;
	bottom = _bottom;
}

function generatePattern(_barCount = 1, _tmNumerator = 4, _tmDenominator = 4)
{
	var tempPattern = [];
	
	for(var i = 0; i < _barCount * (_tmDenominator * _tmNumerator); i++)
	{
		array_push(tempPattern, 0);	
	}
	
	return tempPattern;
}

function rhythmSystem(_song, _pattern = [], _barCount = 8, _bpm = 130, _timeSigniture = new timeSigniture(4, 4)) constructor
{
	music = new songContext();
	sfx = new sfxContext();
	
	barCount = _barCount;
	beatsPerMinuet = _bpm;

	tmNumerator = _timeSigniture.top;
	tmDenominator = _timeSigniture.bottom;

	scoreText = "---";
	
	if(array_length(_pattern) == 0)
		pattern = generatePattern(_barCount, _timeSigniture.top, _timeSigniture.bottom);
	else
		pattern = _pattern;
		
	beatObjects = [];
	
	period = 0.0;
	
	greatRange = 1;
	goodRange = 2;
	safeRange = 3;
	
	music.playSong(_song,,,true);
	
	function initBeats()
	{
		for(var i = 0; i < array_length(pattern); i++)
		{
			if(pattern[i] > 0)
				array_push(beatObjects, new beatObject((music.songLength / barCount / tmNumerator / tmDenominator) * i, music));
		}
	}
	
	function runSystem()
	{
		music.audioUpdate()
		music.songVolume = 0.5;
		
		period = audio_sound_get_track_position(music.audioProcessing);
		
		if(input_check_pressed("accept"))
		{
			sfx.playSFX(sndClap);
			
			for(var i = 0; i < array_length(beatObjects); i++)
				beatObjects[i].detectStep();
		}
		
	}
	
	function debugDraw()
	{
		var width = objCamera.viewWidth;
		var height = objCamera.viewHeight;
		
		// Show the current musical block
		draw_set_color(c_white);

		draw_line(0, height / 2, width, height / 2)

		for(var bars = 0; bars < barCount; bars++)
		{
			// Draw Bars
			draw_line(bars * (width / barCount), height, bars * (width / barCount), height)

			// Get the x position of the bars.
			barPosition = bars * (width / barCount);

			// Get the size of individual beat sets.
			barWidth = (width / barCount) / tmNumerator;
	
			// Show the current musical block
		    if (period >= (music.songLength / barCount) * bars  && period < (music.songLength / barCount) * (bars + 1))
		    {
		        // Highlight the current bar
		        draw_set_color(c_blue);
		        draw_rectangle(barPosition + 1, 0, barPosition + (width / barCount), height, false);
		        draw_set_color(c_white);
		    }

			for(var beatset = 0; beatset < tmNumerator; beatset++)
			{
				// Reset color
				draw_set_color(c_white);
		
				// Draw how many beat sets per bar.
				draw_line(barPosition + (beatset * barWidth), height/2 - 10, barPosition + (beatset * barWidth), height / 2 + 10)
		
				// Get the x position of  beatsets.
				beatsetPosition = barPosition + (beatset * barWidth);
		
				// Get the size of individual beats.
				beatsetWidth = ((width / barCount) / tmNumerator) / tmDenominator;
			}
		}

		draw_set_color(c_red);
		draw_line(normalize(period, 0, music.songLength) * width, 0, normalize(period, 0, music.songLength) * width, height);

		for(var i = 0; i < array_length(beatObjects); i++)
			beatObjects[i].drawSelf();

		// Draw Score
		draw_set_color(c_white); 
		draw_set_font(fntStrongGamer);
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		draw_text(window_get_width() / 2, (window_get_height() / 4) * 3, scoreText);
	
	}
	
	function audioClean()
	{
		delete music;
		delete sfx;
		for(var i = 0; i < array_length(beatObjects); i++)
			delete beatObjects[i];
	}
	
	left = 0;
	right = 0;
	beat_render = true;
	
	function levelCreator(_x, _y)
	{
		draw_sprite(sprNavArrows, 0,_x, _y);
		
		for(var i = 0; i < 8 && right < array_length(pattern); i++)
		{
			
		}
	}
}

