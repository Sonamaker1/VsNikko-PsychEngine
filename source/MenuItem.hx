package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class MenuItem extends FlxSprite
{
	public var targetY:Float = 0;
	public var targetYOffset:Float = 480;
	public var targetYSpacing:Float = 120;
	public var forceX:Float = Math.NEGATIVE_INFINITY;
	public var targetX:Float = Math.NEGATIVE_INFINITY;
	public var flashingInt:Int = 0;

	public function new(x:Float, y:Float, weekName:String = '')
	{
		super(x, y);
		forceX = Math.NEGATIVE_INFINITY;
		targetYOffset = 480;
		targetYSpacing = 120;
		loadGraphic(Paths.image('storymenu/' + weekName));
		//trace('Test added: ' + WeekData.getWeekNumber(weekNum) + ' (' + weekNum + ')');
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	private var isFlashing:Bool = false;

	public function startFlashing():Void
	{
		isFlashing = true;
	}

	// if it runs at 60fps, fake framerate will be 6
	// if it runs at 144 fps, fake framerate will be like 14, and will update the graphic every 0.016666 * 3 seconds still???
	// so it runs basically every so many seconds, not dependant on framerate??
	// I'm still learning how math works thanks whoever is reading this lol
	var fakeFramerate:Int = Math.round((1 / FlxG.elapsed) / 10);

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		var lerpVal:Float = CoolUtil.boundTo(elapsed * 10.2, 0, 1);
			
		y = FlxMath.lerp(y, (targetY * targetYSpacing) + targetYOffset, lerpVal);

		if(forceX != Math.NEGATIVE_INFINITY) {
			x = forceX;
		} 
		else if(targetX !=Math.NEGATIVE_INFINITY){
			x = FlxMath.lerp(x, targetX, lerpVal);
		}

		if (isFlashing)
			flashingInt += 1;

		if (flashingInt % fakeFramerate >= Math.floor(fakeFramerate / 2))
			color = 0xFF33ffff;
		else
			color = FlxColor.WHITE;
	}
}
