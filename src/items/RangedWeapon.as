package items
{
	import flash.utils.Timer;
	import net.flashpunk.graphics.Image;
	
	public class RangedWeapon extends Item 
	{	
		public var bulletType:Class; //the class of the bullet
		public var rateOfFire:Number; //how many seconds to wait between each shot
		public var fireTimer:Timer; //the timer that controls rate of fire
		
		public function RangedWeapon( x:int = 0, y:int = 0 ) 
		{
			type = GC.RANGED_WEAPON_TYPE;
			super( x, y );
		}		
	}

}