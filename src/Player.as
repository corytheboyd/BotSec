package  
{
	import enemies.Enemy;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Vector3D;
	
	public class Player extends Moveable
	{	
		protected var	image:Image	= new Image(GC.GFX_PLAYER);
		protected var	isFlipped:Boolean = false;
		
		protected var	isOnGround:Boolean		= false; //true if player on ground, false otherwise
		protected var	canDblJump:Boolean		= false; //true if the player can double jump
		protected var	hasDblJumped:Boolean 	= false; // true if player has already double jumped
		protected var	maxHSpeed:Number		= GC.MAX_H_SPEED; //the maximum horizontal speed
		protected var	maxVSpeed:Number		= GC.MAX_V_SPEED; //the maximum horizontal speed
		protected var	moveSpeed:Number		= GC.MOVE_SPEED; //the current value
		
		public var velocity:Object = new Object; //the instantaneous velocity vector
		
		public function Player( x:Number=0, y:Number=0 )
		{			
			type = GC.PLAYER_TYPE;
			
			this.x = x; 
			this.y = y;
			
			graphic = image;
			setHitbox(50, 64, -7, 0);
			
			velocity.x = 0;
			velocity.y = 0;
		}
		
		//player hit by enemy
		protected function hit(e:Entity):void
		{
			velocity.y = -300;
			if ( x > e.x ) //on right
			{
				velocity.x = 3000;
			}
			else //on left
			{
				velocity.x = -3000;
			}
		}
		
		/*
		 * Handles input and movement of player
		 * */
		override public function update():void
		{				
			floorCollision();
			enemyCollision();
			changeVelocity();
			acceleration();
			jump();
			animate();
			move( Math.round(velocity.x * FP.elapsed), Math.round(velocity.y * FP.elapsed) );
			shoot();
		}
		
		protected function shoot():void
		{
			if (!GV.EQUIPPED_WEAPON) return;
			
			if ( Input.check('Shoot') && x > 0 && x < FP.width - width )
			{
				GV.EQUIPPED_WEAPON.fire(isFlipped, x, y);
			}
		}
		
		protected function floorCollision():void
		{
			if ( collide(GC.LEVEL_TYPE, x, y + 2) )
			{
				velocity.y = 0;
				isOnGround = true;
				canDblJump = false;
				hasDblJumped = false;
			}
			else
			{
				isOnGround = false;
			}
		}
		
		protected function enemyCollision():void
		{
			var e:Enemy;
			if ( e = collide(GC.ENEMY_TYPE, x, y) as Enemy ) 
			{
				hit(e);
			}
		}
		
		protected function changeVelocity():void
		{
			gravity();			
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
			
			if ( Input.check("Right") ) 
			{
				if (isOnGround)
				{
					velocity.x += moveSpeed * FP.elapsed;
				}
				else
				{
					velocity.x += moveSpeed * GC.AIR_DRAG * FP.elapsed;
				}
			}
			else if ( Input.check("Left") )
			{
				if (isOnGround)
				{
					velocity.x -= moveSpeed * FP.elapsed;
				}
				else
				{
					velocity.x -= moveSpeed * GC.AIR_DRAG * FP.elapsed;
				}
			}
			
			//deceleration forces
			else
			{
				sign = velocity.x > 0 ? 1 : -1;
				
				if (sign == 1) //moving right
				{
					if (isOnGround) //friction
					{
						velocity.x -= GC.FRICTION * FP.elapsed;
						if (velocity.x < 0) velocity.x = 0;
					}
					else //air resistnace
					{
						velocity.x -= GC.DRAG * FP.elapsed;
						if (velocity.x < 0) velocity.x = 0;
					}
					
				}
				else //moving left
				{
					if (isOnGround) //friction
					{
						velocity.x += GC.FRICTION * FP.elapsed;
						if (velocity.x > 0) velocity.x = 0;
					}
					else //air resistnace
					{
						velocity.x += GC.DRAG * FP.elapsed;
						if (velocity.x > 0) velocity.x = 0;
					}
				}
			}
			
			var sign:int = velocity.x > 0 ? 1 : -1;
			if ( Math.abs(velocity.x) > maxHSpeed ) velocity.x = sign * maxHSpeed;
		}
		
		protected function jump():void
		{
			if( isOnGround && Input.pressed("Jump") )
			{
				velocity.y = GC.JUMP_SPEED;
				isOnGround = false;
				if (velocity.x < 0 && image.flipped) velocity.x *= GC.LEAP;
				else if (velocity.x > 0 && !image.flipped) velocity.x *= GC.LEAP;
			}
			if ( Input.released("Jump") && !isOnGround )
			{
				canDblJump = true;
			}
			if ( canDblJump && Input.pressed("Jump") && !hasDblJumped && velocity.y < GC.DBL_JUMP_LIMIT )
			{
				canDblJump = false;
				hasDblJumped = true;
				velocity.y = GC.DBL_JUMP_SPEED;
			}
		}
		
		protected function animate():void
		{
			// control facing direction
			if ( Input.check('Left') ) 
			{
				image.flipped = true;
				isFlipped = true;
			}
			else if ( Input.check('Right') )
			{
				image.flipped = false;
				isFlipped = false;
			}
		}
		
		override protected function collideX(e:Entity):void 
		{
			velocity.x = 0;
		}
		
		override protected function collideY(e:Entity):void 
		{
			if (velocity.y > 0) //falling
			{
				velocity.y *= -1;
			}
			else // jumping
			{
				velocity.y = 0;
			}
		}
		
	}

}