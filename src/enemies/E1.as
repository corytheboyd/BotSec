package enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import flash.utils.getTimer;

	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class E1 extends Enemy 
	{
		protected var dir:int = FP.rand(2) == 0 ? 1 : -1; //randomize direction
		
		public function E1( x:Number, y:Number ) 
		{	
			lethal = true;
			
			graphic = image = new Image(GC.GFX_E1);
			setHitbox(16, 48, -8, -16);
			
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
			velocity.x = dir * GC.E1_MOVE_SPEED;
		}
		
		protected function checkBounds():void
		{
			if ( x < 0)
			{
				x = 0;
				dir *= -1;
			}
			if ( x > FP.width - width )
			{
				x = FP.width - width;
				dir *= -1;
			}
		}
		
		//enemies collide with eachother
		protected function enemyCollision():void
		{
			var e:Enemy
			if ( e = collide(GC.ENEMY_TYPE, x, y) as Enemy )
			{
				e.x *= -1;
				x *= -1;
			}
		}
		
		protected function floorCollision():void
		{
			if ( collide(GC.SOLID_TYPE, x, y + 2) )
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
			dir *= -1;
		}
	}

}