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
	import net.flashpunk.tweens.misc.VarTween;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Platform extends Entity
	{
		public var image:Image = new Image(GC.GFX_PLATFORM);
		public var moving:Boolean = false; //true if it moves, false if stationary
		public var node1pos:Point; //if it's a moving platform, store the node positions
		public var node2pos:Point;
		public var speed:Number; //how man px/s the platform moves at, if applicable
		public var moveVector:Vector3D = null; //the path of movement, calculated on instantiation
		
		protected var moveTween:VarTween = new VarTween;
		
		public function Platform( x:Number, y:Number, moving:Boolean=false, speed:Number=100, node1pos:Point=null, node2pos:Point=null ) 
		{
			graphic = image;
			type = GC.PLATFORM_TYPE;
			setHitbox(96, 3);
			this.moving = moving;
			
			if (node1pos && node2pos)	
			{
				moving = true;
			}
			
			if (moving)
			{				
				try 
				{
					this.node1pos = node1pos;
					this.node2pos = node2pos;
				} 
				catch (e:Error) 
				{
					FP.console.log('PLATFORM.AS: Unable to assign movement nodes, making stationary\n' + e);
					moving = false;
					return;
				}
				
				//make the first node the starting location
				this.x = node1pos.x;
				this.y = node1pos.y;
				
				this.speed = speed;
				
				//dynamically set the movement vector depending on the node locations
				makeMoveVector()			
			}
			else //just a static platform
			{
				this.x = x;
				this.x = y;
			}
		}
		
		override public function update():void 
		{
			if (moving)
			{				
				if (!moveVector) 
				{
					makeMoveVector();
					return; //don't update if there is no movement vector
				}
				
				x += moveVector.x * FP.elapsed;
				y += moveVector.y * FP.elapsed;
				
				//If platform moves off of node path, reverse its direction
				if ( Math.abs(x) > Math.abs(node2pos.x) || Math.abs(x) < Math.abs(node1pos.x) ||
					 Math.abs(y) < Math.abs(node2pos.y) || Math.abs(y) > Math.abs(node1pos.y) ) 
				{
					moveVector.negate(); //reverse direction
					x += moveVector.x * FP.elapsed;
					y += moveVector.y * FP.elapsed;
				}
				
				//special collision detection if platform moves
				movingCollision();
			}
		}
		
		protected function movingCollision():void
		{
			var e:Moveable;
			var collisions:Array = [];
			collideTypesInto([GC.PLAYER_TYPE, GC.ENEMY_TYPE], x, y, collisions);
			
			for each ( e in collisions )
			{				
				if ( e.velocity.y > 0 ) //player lands if falling down and their feet hit the platform
				{
					e.y = y - 80; //offset to players height
					e.isOnGround = true;
					
					if ( moving ) //make x position follow platform
					{
						//how many pixels the platform has moved in x direction
						var dx:Number = Math.cos( Math.PI / 2 + Math.atan2(moveVector.x, moveVector.y) ) * moveVector.length * FP.elapsed;
						e.x -= dx;
					}
				}
			}
		}
		
		/* 
		 * Create the movement vector after instantiation of the object 
		 */
		public function makeMoveVector():void
		{
			var dx:Number = node2pos.x - node1pos.x;
			var dy:Number = node2pos.y - node1pos.y;
			moveVector = new Vector3D( dx, dy );
			moveVector.normalize(); //make it a unit vector
			moveVector.scaleBy(speed); //then scale it to the speed		
		}
		
	}

}