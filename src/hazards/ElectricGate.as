package hazards 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class ElectricGate extends Entity 
	{
		protected var image:Spritemap = new Spritemap(GC.GFX_ELECTRIC_GATE, 16, 16);
		
		public function ElectricGate( x:Number, y:Number ) 
		{
			graphic = image;
			image.add('on', [0, 1, 2, 3], 8, true);
			image.play('on');
			
			setHitbox(16, 16);
			type = GC.HAZARD_TYPE;
			
			this.x = x;
			this.y = y;
		}
		
	}

}