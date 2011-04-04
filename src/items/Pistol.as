package items 
{
	import flash.utils.Timer;
	import net.flashpunk.graphics.Image;
	import bullets.PistolBullet;
	
	public class Pistol extends RangedWeapon 
	{
		public function Pistol(x:int = 0, y:int = 0 ) 
		{
			bulletType = PistolBullet;
			fireTimer = new Timer(250);			
			super(x, y);
		}
		
	}

}