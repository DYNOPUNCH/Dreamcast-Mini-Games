
// takes a minimum Value and Maximum value and normalizes it to be 
function normalize(_value, _min, _max) 
{
	// Normalizes a value between _min and _max.
    return (_value - _min) / (_max - _min);
}

// The intention is to oscilate a value but this probably need to be refactored as a class due to no argument pointers.
function oscillate(_value, _speed) 
{
	_value += 0.1;
    var sine_wave = sin(_value);

    // Scale and shift the sine_wave to oscillate between 0 and 2
    var oscillation = (sine_wave + 1.0) * 1.0;

    return oscillation;
}

// Returns true if a value is in a given range.
function inRange(_number, _minRange, _maxRange)
{
    return (_number >= _minRange) && (_number <= _maxRange);
}

// The intention is to have a number wrap around like a stack overflow
function numberWrap(_min, _max, number)
{
	var displacement = abs(_min);
	var range = abs(_max - _min);
	
	if(number > range)
		number = number % range;
	
	// TODO: Finish
}

// 2D vector math class
function vector2D(_x = 0, _y = 0) constructor
{
	x = _x;
	y = _y;
	
	static set = function(_x, _y)
	{
		x = _x;
		y = _y;
	}
	
	static add = function(_vector)
	{
		x += _vector.x;
		y += _vector.y;
	}
	
	static subtract = function(_vector)
	{
		x -= _vector.x;
		y -= _vector.y;
	}
	
	static multiply = function(_scalar)
	{
		x *= _scalar;
		y *= _scalar;
	}
	
	static divide = function(_scalar)
	{
		x /= _scalar;
		y /= _scalar;
	}
	
	static normalize = function(_vector)
	{
		var magnitude = point_distance(0, 0, _vector.x, _vector.y);
		
		if (magnitude != 0) 
			return new vector2D(_vector.x / magnitude, _vector.y / magnitude);

		return new vector2D(_vector.x, _vector.y);
	}
	
}

// 3D vector math function
function vector3D(_x = 0, _y = 0, _z = 0) constructor
{
	x = _x;
	y = _y;
	z = _z;
	
	static set = function(_x, _y, _z)
	{
		x = _x;
		y = _y;
		z = _z;
	}
	
	static add = function(_vector)
	{
		x += _vector.x;
		y += _vector.y;
		z += _vector.z;
	}
	
	static subtract = function(_vector)
	{
		x -= _vector.x;
		y -= _vector.y;
		z -= _vector.z;
	}
	
	static multiply = function(_scalar)
	{
		x *= _scalar;
		y *= _scalar;
		z *= _scalar;
		
	}
	
	static divide = function(_scalar)
	{
		x /= _scalar;
		y /= _scalar;
		z /= _scalar;
	}
	
	static normalize = function(_vector)
	{
		var magnitude = point_distance(0, 0, _vector.x, _vector.y);
		
		if (magnitude != 0) 
			return new vector3D(_vector.x / magnitude, _vector.y / magnitude, _vector.z / magnitude);

		return new vector3D(_vector.x, _vector.y, _vector.z);
	}
	
}