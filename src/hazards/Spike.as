package hazards 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Spike extends Entity 
	{
		protected var image:Spritemap = new Spritemap(GC.GFX_SPIKES, 32, 32);
		
		public function Spike( x:Number, y:Number ) 
		{
			graphic = image;
			image.setFrame( FP.rand(2), 0 ); //set frame randomly
			
			setHitbox(32, 32);
			type = GC.HAZARD_TYPE;
			
			this.x = x;
			this.y = y;
		}
		
	}

}