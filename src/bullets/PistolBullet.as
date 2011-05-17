package bullets 
{
	import flash.geom.Vector3D;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class PistolBullet extends Bullet 
	{	
		public var shootSound:Sfx = new Sfx(GC.SFX_PISTOL_SHOOT);
		
		public function PistolBullet(flipped:Boolean, upFlag:Boolean=false, downFlag:Boolean=false, playerVelocity:Vector3D=null) 
		{
			super(flipped, upFlag, downFlag, playerVelocity);
			
			shootSound.play();
			
			if (upFlag)
			{
				velocity = new Vector3D(0, -GC.PISTOL_BULLET_SPEED);
			}
			else if (downFlag)
			{
				velocity = new Vector3D(0, GC.PISTOL_BULLET_SPEED);
			}
			else
			{
				var dir:int = flipped ? -1 : 1;
				velocity = new Vector3D(dir * GC.PISTOL_BULLET_SPEED, 0);
			}
			
			//make bullets follow player along if they are moving, elimainate lag
			if(upFlag || downFlag) velocity.x += this.playerVelocity.x;
			
			hasGravity = false;
			damage = GC.PISTOL_BULLET_DAMAGE;			
			graphic = image;
			
			spread = 15.0;
			velocity.y += getSpread(); //the spread of the bullet, initial dy
		}
		
		override public function update():void 
		{
			//movement
			x += velocity.x * FP.elapsed;
			y += velocity.y * FP.elapsed;
			
			//gravity
			if (hasGravity)
			{
				velocity.y += GC.GRAVITY * FP.elapsed;
			}
			
			//hit checking
			
			
			super.update();
		}
		
	}

}