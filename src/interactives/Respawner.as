package interactives 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Respawner extends Entity 
	{
		public var image:Spritemap = new Spritemap(GC.GFX_RESPAWN, 96, 128);
		public var openSound:Sfx = new Sfx(GC.SFX_BUZZER);
		
		public function Respawner( x:Number=0, y:Number=0 ) 
		{	
			image.add('off', [8], 0, true);
			image.add('activate', [0, 1, 2, 3, 4, 5, 6, 7], 12, false);
			
			graphic = image;
			setHitbox(96, 128);
			
			this.x = x;
			this.y = y;
		}
		
		override public function update():void 
		{
			if (image.complete) 
			{
				image.play('off');
			}
		}
		
		override public function added():void 
		{
			layer = 3;
		}
		
		public function activate( callback:Function ):void
		{
			image.callback = callback;
			image.play('activate');
			openSound.play();
		}
		
	}

}