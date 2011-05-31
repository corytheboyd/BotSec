package enemies 
{
	import flash.display.GradientType;
	import interactives.GravityLift;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import flash.utils.getTimer;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Hitbox;

	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class E1 extends Enemy 
	{
		public var image:Spritemap = new Spritemap(GC.GFX_E1, 48, 80);
		public var hitbox:Hitbox;
		//public var dir:int = 1; //the direction of enemies movement, defaults to right
		
		public function E1( x:Number, y:Number ) 
		{
			image.add('walk', [0, 1, 2, 3, 4, 5, 6, 7], GC.E1_FPS, true);
			
			super(x, y);
			lethal = true;
			velocity.x = GC.E1_MOVE_SPEED;
			
			graphic = image;
			mask = hitbox = new Hitbox(32, 50, 8, 30); //change this later
			
			image.play('walk');
		}
		
		override public function added():void 
		{
			hp = GC.E1_HP;
			moving = true;
			type = GC.ENEMY_TYPE;
			
			layer = 2;
		}
		
		override public function update():void 
		{
			//gravity();
			floorCollision();
			checkBounds();
			animate();
			
			if (moving) move( velocity.x * FP.elapsed, velocity.y * FP.elapsed );
			
			super.update();
		}
		
		public function reverseDirection():void
		{
			isFlipped = !isFlipped;
			velocity.x *= -1;
		}
		
		/*
		 * Makes enemy change direction if it's about to fall off of the edge that it is currently on.
		 * Smart little fuckers.
		 */		
		public function checkBounds():void
		{
			//make sure it doesnt fall of ledges
			if ( isOnGround ) //facing left
			{
				if ( !isFlipped && !collide(GC.SOLID_TYPE, x + width, y + 3 ) ) //facing right
				{
					reverseDirection();
				}
				else if ( isFlipped && !collide(GC.SOLID_TYPE, x - width, y + 3 ) ) //facing left
				{
					reverseDirection();
				}
			}
			
			//make sure it doesn't move outside of the level, if possible
			if (x < 0)
			{
				x = 0;
				reverseDirection();	
			}
			if (x + width > GV.CURRENT_LEVEL.levelWidth)
			{
				x = GV.CURRENT_LEVEL.levelWidth - width;
				reverseDirection();
			}
		}
		
		public function gravity():void
		{
			if (isOnGround) return;
			velocity.y += Math.round(GC.GRAVITY * FP.elapsed);
			
			var sign:int = velocity.y > 0 ? 1 : -1;
			if ( Math.abs(velocity.y) > maxVSpeed ) velocity.y = sign * maxVSpeed;
		}
		
		public function floorCollision():void
		{
			if ( collide(GC.SOLID_TYPE, x, y + 2) )
			{
				velocity.y = 0;
				isOnGround = true;
			}
			else isOnGround = false;
		}
		
		public function animate():void
		{
			image.flipped = velocity.x > 0 ? false : true;
		}
		
		override public function collideX(e:Entity):void 
		{
			reverseDirection();
		}
		
		override public function collideY(e:Entity):void 
		{
			if (velocity.y < 0) velocity.y = 0;
		}
	}

}