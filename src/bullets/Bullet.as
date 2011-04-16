package bullets 
{
	import flash.geom.Vector3D;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Bullet extends Moveable 
	{
		public var speed:Number; //how many px/sec the bullet moves in x
		public var hasGravity:Boolean = false; //true if the bullet is affected by gravity
		public var damage:Number; //amount of damage to impart upon its foe
		public var image:Image = new Image(GC.GFX_BULLET_DEFAULT); //the image of the bullet
		public var flipped:Boolean;
		
		public function Bullet(flipped:Boolean)
		{
			type = GC.BULLET_TYPE;
			this.flipped = flipped;
			
			setHitbox(6, 6);
			
			layer = -1;
		}
		
		override public function update():void 
		{
			//check stage bounds for removal
			if (x < 0 || x > GV.CURRENT_LEVEL.levelWidth || y < 0 || y > GV.CURRENT_LEVEL.levelHeight)
			{
				world.remove(this);
			}
			
			//hits a wall of the level
			if (collide(GC.LEVEL_TYPE, x, y) )
			{
				world.remove(this);
			}
			
			super.update();
		}
		
	}

}