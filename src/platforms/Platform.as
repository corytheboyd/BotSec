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
			type = GC.SOLID_TYPE;
			setHitbox(96, 16);
			this.moving = moving;
			
			if (moving)
			{
				if (!node1pos || !node2pos)	
				{
					FP.console.log('PLATFORM.AS: Moving platform must be given 2 nodes in Ogmo!');
					return;
				}
				
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
				var dx:Number = node2pos.x - node1pos.x;
				var dy:Number = node2pos.y - node1pos.y;
				moveVector = new Vector3D( dx, dy );
				moveVector.normalize(); //make it a unit vector
				moveVector.scaleBy(speed); //then scale it to the speed				
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
				}
				
				//special collision detection if platform moves
				movingCollision();
			}
		}
		
		protected function movingCollision():void
		{
			var e:Entity;
			if ( e = collide(GC.PLAYER_TYPE, x, y) )
			{
				if (moveVector.y < 0) //moving up
				{				
					e.y = y - e.height - 20;
				}
				else //moving down
				{
					e.y = y - e.height - 15;
				}
			}
			
			//if on top, follow platforms x position
			if ( e = collide(GC.PLAYER_TYPE, x, y + 10) )
			{
				e.x = x;
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