package bullets 
{
	import flash.geom.Vector3D;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class Bullet extends Moveable 
	{
		public var speed:Number; //how many px/sec the bullet moves
		public var startAngle:Number; //the angle of the bullets movement at firing
		public var hasGravity:Boolean = false; //true if the bullet is affected by gravity
		public var damage:Number; //amount of damage to impart upon its foe
		public var image:Image = new Image(GC.GFX_BULLET_DEFAULT); //the image of the bullet
		protected var velocity:Vector3D = new Vector3D();
		
		public function Bullet()
		{
			//nuthin
		}
		
	}

}