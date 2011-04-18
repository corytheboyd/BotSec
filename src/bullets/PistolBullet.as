package bullets 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class PistolBullet extends Bullet 
	{		
		public function PistolBullet(flipped:Boolean) 
		{
			super(flipped);
			
			speed = GC.PISTOL_BULLET_SPEED;
			hasGravity = false;
			damage = GC.PISTOL_BULLET_DAMAGE;			
			graphic = image;
			
			spread = 15.0;
			dy = getSpread(); //the spread of the bullet, initial dy
		}
		
		override public function update():void 
		{
			//direction changing multiplier
			var dir:int = flipped ? -1 : 1;
			
			//movement
			x += speed * FP.elapsed * dir;
			y += dy * FP.elapsed;
			
			//gravity
			if (hasGravity)
			{
				dy += GC.GRAVITY * FP.elapsed;
			}
			
			//hit checking
			
			
			super.update();
		}
		
	}

}