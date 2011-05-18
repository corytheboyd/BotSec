package interactives 
{
	import flash.display.Sprite;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class TV extends Interactive 
	{
		public var image:Spritemap = new Spritemap(GC.GFX_TV, 112, 143);		
		public var flickerAlarm:Alarm = new Alarm(0.5);
		public var onSound:Sfx = new Sfx(GC.SFX_TV_ON);
		public var offSound:Sfx = new Sfx(GC.SFX_TV_OFF);
		
		public function TV( x:Number, y:Number, id:String, isOn:Boolean ) 
		{
			image.add('on', [1, 2], 10, true);
			image.add('off', [0], 0, false);
			
			image.play( isOn ? 'on' : 'off' );
			
			type = GC.TV_TYPE;
			graphic = image;
			
			this.x = x;
			this.y = y;
			this.id = id;
			this.isOn = isOn;
			
			addTween(flickerAlarm);
		}
		
		override public function added():void 
		{
			//trace('TV ADDED');
			
			layer = 5;
		}
		
		override public function update():void 
		{
			if ( flickerAlarm.active )
			{
				image.play( FP.rand(2) == 0 ? 'on' : 'off' );
			}
			else if (isOn)
			{
				FP.rand(2) == 0 ? image.setAnimFrame('on', 0) : image.setAnimFrame('on', 1);
			}
			else
			{
				image.play('off');
			}
		}
		
		/*
		 * Handle ON signal from switch 
		 */
		override public function sendSignalOn():void 
		{
			isOn = true;
			flickerAlarm.start();
			onSound.play();
		}
		
		/*
		 * Handle OFF signal from switch 
		 */
		override public function sendSignalOff():void 
		{
			image.play('off');		
			isOn = false;
			offSound.play();
		}
		
	}

}