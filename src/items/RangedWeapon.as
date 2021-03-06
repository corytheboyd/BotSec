package items
{
	import flash.geom.Vector3D;
	import flash.utils.Endian;
	import flash.utils.Timer;
	import bullets.*;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class RangedWeapon extends Item 
	{	
		public var bulletType:Class; //the class of the bullet
		public var rateOfFire:Number; //how many seconds to wait between each shot
		public var fireTimer:Timer; //the timer that controls rate of fire
		
		public function RangedWeapon( x:int = 0, y:int = 0 ) 
		{
			type = GC.RANGED_WEAPON_TYPE;
			
			bulletType = Bullet; //default bullet type
			
			super( x, y );
		}
		
		override public function update():void 
		{			
			if ( collide(GC.PLAYER_TYPE, x, y) )
			{
				if (GV.EQUIPPED_WEAPON == null) GV.EQUIPPED_WEAPON = this;
			}
			
			super.update();
		}
		
		/*
		 * Spawns bullets traveling in the given direction
		 * @param flipped: true if the player is facing left, false if right
		 * @param x: x position of player
		 * @param y: y position of player
		 * */
		public function fire( x:Number, y:Number, flipped:Boolean):void
		{
			if (!fireTimer.running)
			{
				fireTimer.reset();
				var bullet:Bullet = new bulletType(flipped);
				
				
				bullet.x = (flipped) ? (x) : (x + 64);
				bullet.y =  y + 32;
				
				GV.CURRENT_LEVEL.world.add(bullet);
			}
			else fireTimer.start();
		}
	}

}