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
			
			graphic = image = new Image(GC.GFX_UNLOCKS_PISTOL);
		}
		
		override public function update():void 
		{
			var p:Player;
			if ( p = collide(GC.PLAYER_TYPE, x, y) as Player )
			{				
				GV.UNLOCKS.toggleItem(2); //changes double jump icon to enabled
			}
			
			super.update();
		}
		
	}

}