package bullets 
{
	import enemies.Enemy;
	import flash.geom.Vector3D;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import interactives.*;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Bullet extends Moveable 
	{
		protected var ricochet1:Sfx = new Sfx(GC.SFX_BULLET_RICOCHET1);
		protected var ricochet2:Sfx = new Sfx(GC.SFX_BULLET_RICOCHET2);
		protected var ricochet3:Sfx = new Sfx(GC.SFX_BULLET_RICOCHET3);
		protected var ricochets:Array = [ricochet1, ricochet2, ricochet3];
		
		public var spread:Number = 0; //range in which bullet paths slightly fluctuate
		public var hasGravity:Boolean = false; //true if the bullet is affected by gravity
		public var damage:Number; //amount of damage to impart upon its foe
		public var image:Image = new Image(GC.GFX_BULLET_DEFAULT); //the image of the bullet
		public var flipped:Boolean;
		public var spawnRoom:String; //the room that the bullet was spawned in
		
		public var upFlag:Boolean;
		public var downFlag:Boolean;
		public var playerVelocity:Vector3D;
		
		public function Bullet(flipped:Boolean, upFlag:Boolean=false, downFlag:Boolean=false, playerVelocity:Vector3D=null )
		{
			type = GC.BULLET_TYPE;
			this.flipped = flipped;
			spawnRoom = GV.CURRENT_LEVEL.levelName;
			
			this.upFlag = upFlag;
			this.downFlag = downFlag;
			
			if (playerVelocity) this.playerVelocity = playerVelocity;
			else playerVelocity = new Vector3D;
			
			setHitbox(6, 6);
			
			layer = 1;
		}
		
		public function getSpread():Number
		{
			var sign:int = FP.rand(2) == 0 ? 1 : -1;
			return Math.random() * spread * sign;
		}
		
		override public function update():void 
		{
			//remove bullet if moved to new room before hits a wall or moves out of room
			if( GV.CURRENT_LEVEL.levelName != spawnRoom ) world.remove(this);
			
			//check stage bounds for removal
			if (x < 0 || x > GV.CURRENT_LEVEL.levelWidth || y < 0 || y > GV.CURRENT_LEVEL.levelHeight)
			{
				world.remove(this);
			}
			
			//hits wall of the level
			if ( collide(GC.SOLID_TYPE, x, y) )
			{
				var n:int = FP.rand(ricochets.length);
				ricochets[n].play();
				world.remove(this);
			}
			
			//hits a door, checks for open
			var e:Door;
			if (e = collide(GC.DOOR_TYPE, x, y) as Door )
			{
				if(!e.open) world.remove(this);
			}
			
			//hits and enemy, destroys it! muaha
			var enemy:Enemy;
			if ( enemy = collide(GC.ENEMY_TYPE, x, y) as Enemy )
			{
				enemy.hit( damage );
				world.remove(this);
			}
			
			//super.update();
		}
		
	}

}