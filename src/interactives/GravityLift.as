package interactives 
{
	import enemies.E1;
	import enemies.Enemy;
	import flash.display.InteractiveObject;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.graphics.TiledSpritemap;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class GravityLift extends Interactive 
	{
		public var image:TiledSpritemap;
		public var speed:int; //speed in px/s that the lift moves the player at
		public var hitbox:Hitbox;
		public var h:uint;
		
		public var flickerAlarm:Alarm = new Alarm(1);
		
		public function GravityLift( x:Number, y:Number, h:Number, speed:int, id:String, isOn:Boolean ) 
		{
			mask = hitbox = new Hitbox(96, h);
			graphic = image = new TiledSpritemap(GC.GFX_GRAVLIFT, 96, 32, 96, h);
			type = GC.GRAVLIFT_TYPE;
			
			image.add('on', [0], 0, false);
			image.add('off', [1], 0, false);
			
			this.x = x;
			this.y = y;
			this.h = h;
			this.isOn = isOn;
			this.id = id;
			this.speed = speed;
			
			image.play( isOn ? 'on' : 'off' );
			
			addTween(flickerAlarm); //adds alarm to world
		}
		
		override public function update():void 
		{
			if ( flickerAlarm.active ) 
			{
				image.play( FP.rand(2) == 0 ? 'on' : 'off' );
			}
			else
			{
				image.play( isOn ? 'on' : 'off' );
			}
		}
		
		/*
		 * Handle ON signal from switch 
		 */
		override public function sendSignalOn():void 
		{
			isOn = true;
			flickerAlarm.start();
		}
		
		/*
		 * Handle OFF signal from switch 
		 */
		override public function sendSignalOff():void 
		{
			isOn = false;
		}
		
	}

}