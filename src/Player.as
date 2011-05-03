package  
{
	import enemies.Enemy;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Player extends Moveable
	{	
		public var image:Spritemap 			= new Spritemap(GC.GFX_PLAYER, 64, 80);
		public var isFlipped:Boolean 		= false;		
		public var canDblJump:Boolean		= false; //true if the player can double jump
		public var hasDblJumped:Boolean 	= false; // true if player has already double jumped
		
		protected var maxHSpeed:Number		= GC.MAX_H_SPEED; //the maximum horizontal speed
		protected var maxVSpeed:Number		= GC.MAX_V_SPEED; //the maximum horizontal speed
		protected var moveSpeed:Number		= GC.MOVE_SPEED; //the current value
		
		protected var jumpSound:Sfx 		= new Sfx(GC.SFX_PLAYER_JUMP);
		protected var explodeSound:Sfx 		= new Sfx(GC.SFX_EXPLOSION_SMALL);
		
		public function Player( x:Number=0, y:Number=0, v:Vector3D=null )
		{	
			image.add('run_start', [0, 1, 2, 3, 4, 5, 6], GC.GFX_PLAYER_FPS, false);
			image.add('run_loop', [7, 8, 9, 10, 11, 12, 13], GC.GFX_PLAYER_FPS, true);
			image.add('idle', [14, 15], 2, true);
			
			type = GC.PLAYER_TYPE;
			
			this.x = x; 
			this.y = y;

			try 
			{
				if (!v) velocity = new Vector3D;
				else velocity = v;
			} 
			catch (err:Error) 
			{
				
			}
			
			graphic = image;
			setHitbox(38, 60, -13, -20);
		}
		
		//player hit by enemy
		protected function hit(e:Entity):void
		{
			velocity.y = -100;
			if ( x > e.x ) //on right
			{
				velocity.x = 1500;
			}
			else //on left
			{
				velocity.x = -1500;
			}
		}
		
		/*
		 * Handles input and movement of player
		 * */
		override public function update():void
		{
			if (Input.pressed('Suicide'))
			{
				kill();
			}
			
			//trace('isOnGround', isOnGround);
			
			hazardCollision();
			floorCollision();
			enemyCollision();
			changeVelocity();
			acceleration();
			jump();
			animate();
			sound();
			move( velocity.x * FP.elapsed, velocity.y * FP.elapsed );
			shoot();
		}
		
		protected function hazardCollision():void
		{
			if ( collide(GC.HAZARD_TYPE, x, y) )
			{
				kill();
			}
		}
		
		protected function shoot():void
		{
			if (!GV.EQUIPPED_WEAPON) return;
			
			if ( Input.pressed('Shoot') && x > 0 && x < FP.width - width )
			{
				GV.EQUIPPED_WEAPON.fire(isFlipped, x, y);
			}
		}
		
		protected function floorCollision():void
		{			
			var e:Entity;
			if ( e = collideTypes([GC.SOLID_TYPE], x, y + 2) )
			{ 
				velocity.y = 0;
				isOnGround = true;
				canDblJump = false;
				hasDblJumped = false;
			}
			else if ( !collideTypes([GC.PLATFORM_TYPE], x, y + 2) )
			{
				isOnGround = false;
			}
		}
		
		protected function enemyCollision():void
		{
			var e:Enemy;
			if ( e = collide(GC.ENEMY_TYPE, x, y) as Enemy ) 
			{
				if (e.lethal)
				{
					kill();
				} else	hit(e);
			}
		}
		
		protected function kill():void
		{
			//play some explostion animation and remove the player from the world as the callback
			explodeSound.play();
			world.remove(this);
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
				jumpSound.play();

				velocity.y = GC.JUMP_SPEED;
				isOnGround = false;
				if (velocity.x < 0 && image.flipped) velocity.x *= GC.LEAP;
				else if (velocity.x > 0 && !image.flipped) velocity.x *= GC.LEAP;
			}
			if ( Input.released("Jump") && !isOnGround )
			{
				canDblJump = true;
			}
			if ( canDblJump && Input.pressed("Jump") && !hasDblJumped )
			{
				jumpSound.play();

				canDblJump = false;
				hasDblJumped = true;
				velocity.y = GC.DBL_JUMP_SPEED;
			}
		}
		
		protected function animate():void
		{
			//control animation
			if (velocity.x == 0 && isOnGround)
			{
				image.play('idle');
			}
			else if (isOnGround)
			{
				image.play('run_start');
				if (image.complete)
				{
					image.play('run_loop');
				}
			}
			else 
			{
				//in air, replace with jump animation later
				image.setFrame(15, 0);
			}
			
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
		
		protected function sound():void
		{
			
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