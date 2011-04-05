package items 
{
	import flash.utils.Timer;
	import net.bloom.BloomWrapper;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import bullets.PistolBullet;
	
	public class Pistol extends RangedWeapon
	{
		public function Pistol(x:int = 0, y:int = 0 ) 
		{
			super(x, y);		
			bulletType = PistolBullet;
			fireTimer = new Timer(250);			
		}
		
	}

}