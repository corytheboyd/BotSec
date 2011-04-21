package enemies 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class Enemy extends Moveable 
	{
		public var image:Image;
		public var isFlipped:Boolean = false;
		public var velocity:Object = new Object;
		
		public var	isOnGround:Boolean		= false; //true if player on ground, false otherwise
		public var	maxHSpeed:Number;
		public var	maxVSpeed:Number;
		public var	moveSpeed:Number;
		
		public function Enemy( x:Number=0, y:Number=0 ) 
		{
			type = GC.ENEMY_TYPE;
			
			this.x = x;
			this.y = y;
			
			velocity.x = 0;
			velocity.y = 0;
		}
		
		/*
		 * Called when the enemy is hit by a bullet
		 * */
		public function hit():void
		{
			velocity.y = -150;
		}
		
	}

}