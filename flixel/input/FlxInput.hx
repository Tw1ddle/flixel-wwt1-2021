package flixel.input;

import flixel.input.FlxInput.FlxInputState;

class FlxInput<T> implements IFlxInput
{
	public var ID:T;
	
	public var pressed(get, null):Bool;
	public var released(get, null):Bool;
	public var justPressed(get, null):Bool;
	public var justReleased(get, null):Bool;
	
	private var justPressedQueueFalse:Bool;
	private var justReleasedQueueFalse:Bool;
	
	public function new(ID:T)
	{
		this.ID = ID;
		reset();
	}
	
	public function press():Void
	{
		if (released) 
		{
			justPressed = true;
			justPressedQueueFalse = false;
		}
		
		pressed = true;
		released = false;
	}
	
	public function release():Void
	{		
		if (pressed)
		{
			justReleased = true;
			justReleasedQueueFalse = false;
		}
		
		released = true;
		pressed = false;
	}
	
	public function update():Void
	{		
		if (justPressedQueueFalse)
		{
			justPressed = false;
			justPressedQueueFalse = false;
		}
		
		if (justReleasedQueueFalse)
		{
			justReleased = false;
			justReleasedQueueFalse = false;
		}
		
		if (justPressed) 
		{
			justPressedQueueFalse = true;
		}
		
		if (justReleased)
		{
			justReleasedQueueFalse = true;
		}
	}
	
	public function reset():Void
	{
		pressed = false;
		released = true;
		justPressed = false;
		justReleased = false;
		justPressedQueueFalse = false;
		justReleasedQueueFalse = false;
	}
	
	public function hasState(state:FlxInputState):Bool
	{
		return switch (state)
		{
			case JUST_RELEASED: justReleased;
			case RELEASED:      released;
			case PRESSED:       pressed;
			case JUST_PRESSED:  justPressed;
		}
	}
	
	private function get_released():Bool
	{
		return released;
	}
	
	private function get_justReleased():Bool
	{
		return justReleased;
	}
	
	private function get_justPressed():Bool 
	{
		return justPressed;
	}
	
	private function get_pressed():Bool 
	{
		return pressed;
	}
}

@:enum
abstract FlxInputState(Int) from Int
{
	var JUST_RELEASED = -1;
	var RELEASED      =  0;
	var PRESSED       =  1;
	var JUST_PRESSED  =  2;
}