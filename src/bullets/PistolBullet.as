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
			hasGravity = true;
			damage = GC.PISTOL_BULLET_DAMAGE;			
			graphic = image;
		}
		
		override public function update():void 
		{
			//direction changing multiplier
			var dir:int = flipped ? -1 : 1;
			
			//movement
			x += speed * FP.elapsed * dir;
			
			//gravity
			if (hasGravity)
			{
				y += GC.GRAVITY * FP.elapsed / 1000;
			}
			
			//hit checking
			
			
			super.update();
		}
		
	}

}