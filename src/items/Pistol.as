package items 
{
	import flash.utils.Timer;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import bullets.PistolBullet;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Pistol extends RangedWeapon
	{
		public function Pistol(x:int = 0, y:int = 0 ) 
		{
			super(x, y);		
			bulletType = PistolBullet;
			fireTimer = new Timer(750, 0);			
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}