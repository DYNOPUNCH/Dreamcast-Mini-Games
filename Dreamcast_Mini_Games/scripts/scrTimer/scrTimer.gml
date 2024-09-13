
// Counts in seconds

function timer(_TriggerTime) constructor
{
	_counter = 0;
	_active = false;
	_triggerTime = _TriggerTime;
	
	function runTimer()
	{
		if(_counter >= _triggerTime)
		{
			resetTimer();
			return true;
		}
		else
		{
			_active = true;
			_counter += delta_time / 1000000;
			return false;
		}
	}
	
	function resetTimer()
	{
		_active = false;
		_counter = 0;
	}
}



function simpleTimer(_refTime, _deltaTime, _maxTime)
{
	// Increment the time by the delta time
    _refTime += _deltaTime;

    // Check if the time has reached or exceeded the maximum time
    if (_refTime >= _maxTime) 
	{	
        // Set the time to the maximum time
        _refTime = _maxTime;
        return true;
    } 

    return false;
    
}

function resetTimer(_refTime)
{
	_refTime = 0;
}