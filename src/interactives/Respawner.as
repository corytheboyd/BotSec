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
			image.add('closed', [0], 0, true);
			image.add('open', [1, 2, 3, 4, 5], GC.DOOR_OPEN_SPEED, false);
			image.add('close', [4, 3, 2, 1, 0], GC.DOOR_OPEN_SPEED, false);
			image.add('activate', [1, 2, 3, 4, 5, 5, 5, 5, 4, 3, 2, 1, 0], GC.DOOR_OPEN_SPEED, false);
			
			graphic = image;
			setHitbox(96, 128);
			
			this.x = x;
			this.y = y;
		}
		
		override public function update():void 
		{
			if (image.complete) 
			{
				image.play('closed');
			}
		}
		
		override public function added():void 
		{
			layer = 3;
		}
		
		public function activate():void
		{			
			image.play('activate');
			openSound.play();
		}
		
	}

}