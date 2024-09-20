function songContext() constructor
{
	audio = noone;
	songPosition = 0.0;
	songLength = 0.0;
	songName = "";
	startTime = 0.0;
	loopTime = 0.0;
	songVolume = 1.0;
	fadeTime = 1500;
	songPitch = 1.0;
	songPitchOscilation = 0.0;
	songPitchOscilationSpeed = 8;
	
	audioProcessing = noone;
	
	keyTimer = 0;
	fadeSetup = false;
	
	#region SPATIAL_AUDIO_DEFINITIONS
	
	reverb_emitter = audio_emitter_create();
	reverb_bus = audio_bus_create();

	audio_emitter_bus(reverb_emitter, reverb_bus);

	_reverbEffect = audio_effect_create(AudioEffectType.Reverb1);

	_reverbEffect.size = 0;
	_reverbEffect.damp = 0;
	_reverbEffect.mix = 0;

	reverb_bus.effects[0] = _reverbEffect;	
	
	#endregion
	
	enum audioState
	{
		PROCESSING,
		PAUSED,
		RESET,
		FADE_IN,
		FADE_OUT,
		PITCH_IN,
		PITCH_OUT,
		PITCH_OSCILLATE,
		PITCH_FREE
	}
	
	currentAudioState = audioState.PROCESSING;
	
	function playSong(_audio, _startTime = 0.0, _songVolume = 1.0, _enableSpatialAudio = false)
	{
		if(_audio == audio)
			return; 
			
			var _pathParts = string_split(audio_get_name(_audio), "_");
			var _joinParts = string_concat(_pathParts[array_length(_pathParts) - 2],".", _pathParts[array_length(_pathParts) - 1]);
			var _loopPos = real(_joinParts);
			
			audio = _audio;
			songPosition = 0.0;
			songLength = audio_sound_length(_audio);
			songName = _pathParts[0];
			startTime = _startTime;
			loopTime = _loopPos;
			songVolume = _songVolume;
			
			if(_enableSpatialAudio == false)
				audioProcessing = audio_play_sound(_audio, 100, true, 0.0,,songPitch);
			else
				audioProcessing = audio_play_sound_on(reverb_emitter, _audio, true, 100, 0.0,,songPitch);
				
			audio_sound_loop_start(audioProcessing, loopTime);
			audio_sound_loop_end(audioProcessing, songLength);
			audio_sound_loop(audioProcessing, true);
			
			if(_startTime != 0.0)
			{
				songPosition = _startTime;
				audio_sound_set_track_position(audioProcessing, _startTime);	
			}
		
	}
	
	function spatialAudio(_mix, _damp, _roomSize)
	{
		_reverbEffect.size = _roomSize;
		_reverbEffect.damp = _damp;
		_reverbEffect.mix = _mix;
	}
	
	function audioUpdate()
	{
		if(audio == noone)
			return;
		
		#region DEBUG TOOLS
		
		// Check if the key has been tapped.
		
		if(keyboard_check_pressed(vk_left))
			if(audio_sound_get_track_position(audioProcessing) - 1.0 > 0)
			{
				audio_sound_set_track_position(audioProcessing, audio_sound_get_track_position(audioProcessing) - 0.20);
				songPosition = audio_sound_get_track_position(audioProcessing);
			}
			else
			{
				audio_sound_set_track_position(audioProcessing, 0.0);
				songPosition = audio_sound_get_track_position(audioProcessing);	
			}
		
		if(keyboard_check_pressed(vk_right))
			if(audio_sound_get_track_position(audioProcessing) + 1.0 < audio_sound_length(audioProcessing))
			{
				audio_sound_set_track_position(audioProcessing, audio_sound_get_track_position(audioProcessing) + 0.20);
				songPosition = audio_sound_get_track_position(audioProcessing);
			}
			else
			{
				audio_sound_set_track_position(audioProcessing, loopTime);
				songPosition = audio_sound_get_track_position(audioProcessing);	
			}
			
		// See if either key has been held for an amount of time.
		
		if(keyboard_check(vk_left) || keyboard_check(vk_right)) 
			if(keyTimer / 1000000 < 0.8)
				keyTimer += delta_time;	
			else
			{
				if(keyboard_check(vk_left))
					if(audio_sound_get_track_position(audioProcessing) - 1.0 > 0)
					{
						audio_sound_set_track_position(audioProcessing, audio_sound_get_track_position(audioProcessing) - 0.20);
						songPosition = audio_sound_get_track_position(audioProcessing);
					}
					else
					{
						audio_sound_set_track_position(audioProcessing, 0.0);
						songPosition = audio_sound_get_track_position(audioProcessing);	
					}
				
				
				if(keyboard_check(vk_right))
					if(audio_sound_get_track_position(audioProcessing) + 1.0 < audio_sound_length(audioProcessing))
					{
						audio_sound_set_track_position(audioProcessing, audio_sound_get_track_position(audioProcessing) + 0.20);
						songPosition = audio_sound_get_track_position(audioProcessing);
					}
					else
					{
						audio_sound_set_track_position(audioProcessing, loopTime);
						songPosition = audio_sound_get_track_position(audioProcessing);	
					}
			}
		else
			keyTimer = 0;
		#endregion
		
		switch(currentAudioState)
		{
			case audioState.PROCESSING:
				// Pitch has to be normal in processing mode.
				audio_sound_pitch(audioProcessing, 1.0);
				// Process the audio like normal allowing for on the spot updates.
				if(audio_sound_get_gain(audioProcessing) != songVolume)
					audio_sound_gain(audioProcessing, songVolume, 0);
				break;
			case audioState.FADE_IN:
			
				// Setup audio for fade in.
				if(fadeSetup == false)
				{
					audio_sound_gain(audioProcessing, 0, 0);
					fadeSetup = true;
				}
				// Process fade.
				audio_sound_gain(audioProcessing, songVolume, fadeTime);
				
				// See if audio has gotten to it's target and if 
				// so change state to processing like normal
				if(audio_sound_get_gain(audioProcessing) == songVolume)
				{
					currentAudioState = audioState.PROCESSING;
					fadeSetup = false;
				}
				
				break;
				
			case audioState.FADE_OUT:
			
				// Setup audio for fade in.
				if(fadeSetup == false)
				{
					audio_sound_gain(audioProcessing, songVolume, 0);
					fadeSetup = true;
				}
				// Process fade.
				audio_sound_gain(audioProcessing, 0, fadeTime);
				
				// See if audio has gotten to it's target and if 
				// so change state to processing like normal
				if(audio_sound_get_gain(audioProcessing) == 0)
				{
					currentAudioState = audioState.PROCESSING;
					fadeSetup = false;
				}
			
				break;
			case audioState.PITCH_IN:
				
				// Setup audio for fade in.
				if(fadeSetup == false)
				{
					audio_sound_gain(audioProcessing, 0, 0);
					audio_sound_pitch(audioProcessing, 0);
					fadeSetup = true;
				}
				// Process fade.
				audio_sound_gain(audioProcessing, songVolume, fadeTime);
				audio_sound_pitch(audioProcessing, normalize(audio_sound_get_gain(audioProcessing), 0, songVolume));
				
				// See if audio has gotten to it's target and if 
				// so change state to processing like normal
				if(audio_sound_get_gain(audioProcessing) == songVolume)
				{
					currentAudioState = audioState.PROCESSING;
					audio_sound_pitch(audioProcessing, 1);
					fadeSetup = false;
				}
				
				break;
			case audioState.PITCH_OUT:
				
				// Setup audio for fade in.
				if(fadeSetup == false)
				{
					audio_sound_gain(audioProcessing, songVolume, 0);
					audio_sound_pitch(audioProcessing, 1);
					fadeSetup = true;
				}
				
				// Process fade.
				audio_sound_gain(audioProcessing, 0, fadeTime);
				audio_sound_pitch(audioProcessing, normalize(audio_sound_get_gain(audioProcessing), 0, songVolume));
				
				// See if audio has gotten to it's target and if 
				if(audio_sound_get_gain(audioProcessing) == 0)
				{
					currentAudioState = audioState.PROCESSING;
					audio_sound_pitch(audioProcessing, 1);
					fadeSetup = false;
				}
				
				break;
			case audioState.PITCH_OSCILLATE:
				songPitchOscilation += pi/songPitchOscilationSpeed;
				var sineWave = sin(songPitchOscilation)
				var oscillation = (sineWave + 1.0) * 0.5;
				
				audio_sound_gain(audioProcessing, songVolume, 0);
				audio_sound_pitch(audioProcessing, oscillation);
				break;
			case audioState.PITCH_FREE:
				// Change audio pitch depending allowing for sound warping.
				if(audio_sound_get_pitch(audioProcessing) != songPitch)
					audio_sound_pitch(audioProcessing, songPitch);
				// Process the audio like normal allowing for on the spot updates.
				if(audio_sound_get_gain(audioProcessing) != songVolume)
					audio_sound_gain(audioProcessing, songVolume, 0);
				break;
		}
	}
}

function sfxContext() constructor
{
	audioProcessing = noone;
	sfxVolume = 0.0;
	
	#region SPATIAL_AUDIO_DEFINITIONS
	
	reverb_emitter = audio_emitter_create();
	reverb_bus = audio_bus_create();

	audio_emitter_bus(reverb_emitter, reverb_bus);

	_reverbEffect = audio_effect_create(AudioEffectType.Reverb1);

	_reverbEffect.size = 0;
	_reverbEffect.damp = 0;
	_reverbEffect.mix = 0;

	reverb_bus.effects[0] = _reverbEffect;	
	
	#endregion
	
	function playSFX(_audio, _sfxVolume = 0.1, _enableSpatialAudio = false, _loop = false, _sfxPitch = 1.0)
	{
			if(_enableSpatialAudio == false)
				audioProcessing = audio_play_sound(_audio, 0, _loop, _sfxVolume,,_sfxPitch);
			else
				audioProcessing = audio_play_sound_on(reverb_emitter, _audio, true, 100, _sfxVolume,,sfxPitch);
	}
	
	function spatialAudio(_mix, _damp, _roomSize)
	{
		_reverbEffect.size = _roomSize;
		_reverbEffect.damp = _damp;
		_reverbEffect.mix = _mix;
	}
	
	function sfxUpdate()
	{
		if(audio_sound_get_gain(audioProcessing) != sfxVolume)
			audio_sound_gain(audioProcessing, sfxVolume, 0);
	}
}