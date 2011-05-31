package enemies 
{
	import flash.geom.Vector3D;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;

	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Enemy extends Moveable 
	{
		public var lethal:Boolean = false; //true if touching the enemy kills the player
		public var hp:int = 1; //how many hits the enemy takes before it dies
		public var moving:Boolean = true; //set to false if you want it to stop moving
		
		public var isFlipped:Boolean = false;
		
		public var	maxHSpeed:Number;
		public var	maxVSpeed:Number;
		public var	moveSpeed:Number;
		
		public var dieSound:Sfx = new Sfx(GC.SFX_EXPLOSION2);
		
		public function Enemy( x:Number=0, y:Number=0 ) 
		{
			type = GC.ENEMY_TYPE;
			
			this.x = x;
			this.y = y;
			
			velocity.x = 0;
			velocity.y = 0;
		}
		
		override public function added():void 
		{
			layer = 1;
		}
		
		/*
		 * Called when the enemy is hit by a bullet
		 * */
		public function hit( damage:int ):void
		{
			hp -= damage;
			
			if (hp <= 0 && type != '')
			{
				type = ''; //make it not kill they player on touch
				moving = false; //stop movement
				kill();
			}
			else if (hp > 0) //react to getting hit
			{
				hitReact();
			}
		}
		
		/*
		 * Called when the enemy's hp is depleted
		 * Override for specific enemy behavior
		 * */
		public function kill():void
		{
			dieSound.play();
			
			//remove from world
			world.remove(this);
		}
		
		/*
		 * Called when hit by bullet, but didn't die.
		 * Override for specific enemy behavior
		 * */
		public function hitReact():void
		{
			
		}
		
	}

}