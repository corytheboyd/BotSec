package interactives 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class Respawner extends Entity 
	{
		protected var image:Spritemap = new Spritemap(GC.GFX_RESPAWN, 96, 128);
		
		public function Respawner( x:Number=0, y:Number=0 ) 
		{
			image.add('closed', [0], 0, false);
			image.add('open', [1, 2, 3, 4, 5], GC.DOOR_OPEN_SPEED, false);
			image.add('close', [4, 3, 2, 1, 0], GC.DOOR_OPEN_SPEED, false);
			
			graphic = image;
			setHitbox(96, 128);
			
			this.x = x;
			this.y = y;
		}
		
		
		
	}

}