/*
 * Note: Platforms are 'cloud' tiles, which means they only have hit detection on the top when player lands
 *   on it. The player can jump through it right, left, and up, but not fall through it.
 *   this solves a few complications and makes gameplay more intuitive.
 * */
package platforms 
{
	import enemies.E1;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Platform extends Entity
	{
		public var image:Image = new Image(GC.GFX_PLATFORM);
		public var hitbox:Hitbox = new Hitbox(96, 3, 0, 0);
		public var moving:Boolean = false; //true if it moves, false if stationary
		
		public var node1pos:Point; //if it's a moving platform, store the node positions
		public var node2pos:Point;
		public var speed:Number; //how man px/s the platform moves at, if applicable
		public var dir:int = 1; //direction of travel
		
		public function Platform( x:Number, y:Number, speed:Number=100, node1pos:Point=null, node2pos:Point=null ) 
		{
			graphic = image;
			type = GC.PLATFORM_TYPE;
			mask = hitbox;
			
			moving = (node1pos && node2pos && node1pos.y == node2pos.y) ? true : false;
			
			if ( moving )
			{
				this.speed = speed;
				
				if ( node2pos.x < node1pos.x )
				{
					this.node1pos = node2pos;
					this.node2pos = node1pos;
				}
				else
				{
					this.node1pos = node1pos;
					this.node2pos = node2pos;
				}
				
				this.x = node1pos.x;
				this.y = node1pos.y;
			}
			else //not moving
			{
				this.x = x; 
				this.y = y;
			}
		}
		
		override public function added():void 
		{
			layer = 1;
		}
		
		override public function update():void 
		{			
			//player collision
			var e:Player;
			if ( e = collide(GC.PLAYER_TYPE, x, y - 1) as Player )
			{
				if ( !e.platformFallAlarm.active && collideRect(x, y, e.x, e.y + e.image.height - 15, e.width, 15) && (e.velocity.y >= 0) ) //player falling down
				{
					//set player on ground, on top of platform
					e.velocity.y = 0;
					e.isOnGround = true;
					e.canDblJump = false;
					e.hasDblJumped = false;
					
					e.y = y - e.image.height + 1;
					
					//move the player
					if (moving) e.x += speed * dir * FP.elapsed;
				}
				else
				{
					e.isOnGround = false;
				}
			}
			
			//move platform
			if (moving) x += speed * dir * FP.elapsed;
			
			//check bounds
			if (moving && node1pos != null && node2pos != null)
			{
				if ( x < node1pos.x && moving )
				{
					dir *= -1;
					x = node1pos.x;
				}
				if ( x > node2pos.x && moving )
				{
					dir *= -1;
					x = node2pos.x;
				}
			}
		}
		
	}

}