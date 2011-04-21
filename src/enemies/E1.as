package enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import flash.utils.getTimer;

	public class E1 extends Enemy 
	{
		protected var timeElapsed:Number 	= 0; //the elapsed time of movement
		protected var moveDuration:Number	= 0; //the duration of the movement
		protected var moving:Boolean		= false; //true if its moving
		
		public function E1( x:Number, y:Number ) 
		{			
			graphic = image = new Image(GC.GFX_E1);
			setHitbox(32, 64);
			
			super(x, y);
		}
		
		override public function update():void 
		{
			gravity();
			acceleration();
			floorCollision();
			enemyCollision();
			move( velocity.x * FP.elapsed, velocity.y * FP.elapsed );
			checkBounds();
			animate();
			
			super.update();
		}
		
		protected function gravity():void
		{
			if (isOnGround) return;
			velocity.y += Math.round(GC.GRAVITY * FP.elapsed);
			
			var sign:int = velocity.y > 0 ? 1 : -1;
			if ( Math.abs(velocity.y) > maxVSpeed ) velocity.y = sign * maxVSpeed;
		}
		
		protected function acceleration():void
		{
			if (!moving && isOnGround)
			{
				moving = true;
				timeElapsed = 0;
				moveDuration = 1 + Math.random();
				var dir:int = FP.rand(2) == 0 ? 1 : -1; //randomize direction
				
				velocity.x = dir * GC.E1_MOVE_SPEED;
			}
			else
			{
				timeElapsed += FP.elapsed;
				if (timeElapsed >= moveDuration) 
				{
					moving = false;
				}
			}
		}
		
		protected function checkBounds():void
		{
			if ( x < 0)
			{
				x = 0;
				velocity.x *= -1;
			}
			if ( x > FP.width - width )
			{
				x = FP.width - width;
				velocity.x *= -1;
			}
		}
		
		//enemies collide with eachother
		protected function enemyCollision():void
		{
			var e:Enemy
			if ( e = collide(GC.ENEMY_TYPE, x, y) as Enemy )
			{
				if (x < e.x) //collides with enemy on right
				{
					e.x = x + width + 3;
					e.velocity.x *= -1;
				}
				else //collides with enemy on left
				{
					e.x = x - e.width - 3;
					e.velocity.x *= -1;
				}
			}
		}
		
		protected function floorCollision():void
		{
			if ( collide(GC.LEVEL_TYPE, x, y + 2) )
			{
				velocity.y = 0;
				isOnGround = true;
			}
			else isOnGround = false;
		}
		
		protected function animate():void
		{
			image.flipped = velocity.x > 0 ? false : true;
		}
		
		override protected function collideX(e:Entity):void 
		{
			velocity.x *= -1;
		}
	}

}