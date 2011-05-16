package interactives 
{
	import flash.display.Sprite;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class TV extends Interactive 
	{
		public var image:Spritemap = new Spritemap(GC.GFX_TV, 112, 143);	
		
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
		}
		
		/*
		 * Handle ON signal from switch 
		 */
		override public function sendSignalOn():void 
		{
			image.play('on');			
			isOn = true;
		}
		
		/*
		 * Handle OFF signal from switch 
		 */
		override public function sendSignalOff():void 
		{
			image.play('off');			
			isOn = false;
		}
		
	}

}