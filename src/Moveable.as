package 
{
	import flash.geom.Vector3D;
	import net.flashpunk.Entity;
	
	/**
	 * Base class for moving Entities to handle collision.
	 */
	public class Moveable extends Entity 
	{
		public var velocity:Vector3D = new Vector3D
		public var isOnGround:Boolean = false; 
		
		/**
		 * Helper vars used by move().
		 */
		public var __moveX:Number = 0;
		public var __moveY:Number = 0;
		
		public function Moveable() 
		{
			//nuttin
		}
		
		/**
		 * Moves the entity by the specified amount horizontally and vertically.
		 */
		public function move(moveX:Number = 0, moveY:Number = 0):void
		{
			// movement counters
			__moveX += moveX;
			__moveY += moveY;
			moveX = Math.round(__moveX);
			moveY = Math.round(__moveY);
			__moveX -= moveX;
			__moveY -= moveY;
			
			// movement vars
			var sign:int, e:Entity;
			
			// horizontal
			if (moveX != 0)
			{
				sign = moveX > 0 ? 1 : -1;
				while (moveX != 0)
				{
					moveX -= sign; 
					if ((e = collideTypes([GC.SOLID_TYPE], x + sign, y)))
					{
						collideX(e);
						moveX = 0;
					}
					else x += sign;
				}
			}
			
			// vertical
			if (moveY != 0)
			{
				sign = moveY > 0 ? 1 : -1;
				while (moveY != 0)
				{
					moveY -= sign;
					if ((e = collideTypes([GC.SOLID_TYPE], x, y + sign)))
					{
						collideY(e);
						moveY = 0;
						isOnGround = true;
					}
					else y += sign;
				}
			}
		}
		
		/**
		 * Horizontal collision (override for specific behaviour).
		 */
		public function collideX(e:Entity):void
		{
			
		}
		
		/**
		 * Vertical collision (override for specific behaviour).
		 */
		public function collideY(e:Entity):void
		{
			
		}
		
	}

}