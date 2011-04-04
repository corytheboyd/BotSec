package bullets 
{
	import net.blur.BlurredGraphic;
	import net.flashpunk.graphics.Image;
	
	public class PistolBullet extends Bullet 
	{		
		public function PistolBullet() 
		{
			speed = GC.PISTOL_BULLET_SPEED;
			hasGravity = false;
			damage = GC.PISTOL_BULLET_DAMAGE;
			
			graphic = new BlurredGraphic(image, GV.BLUR_CANVAS);
		}
		
	}

}