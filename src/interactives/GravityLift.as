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
		}
		
		override public function added():void 
		{
			if (!isOn) disable();
		}
		
		/*
		 * Enable the lift
		 * */
		public function enable():void
		{
			isOn = true;
		}
		
		/*
		 * Disable the lift
		 * */
		public function disable():void
		{
			isOn = false;
		}
		
	}

}