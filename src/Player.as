package  
{
	import enemies.Enemy;
	import interactives.GravityLift;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Vector3D;
	import platforms.Platform;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Player extends Moveable
	{	
		public var image:Spritemap 			= new Spritemap(GC.GFX_PLAYER, 64, 80);
		public var isFlipped:Boolean 		= false;	
		public var isFlippedPrev:Boolean; 	//previous frame's value of isFlipped
		public var canDblJump:Boolean		= false; //true if the player can double jump
		public var hasDblJumped:Boolean 	= false; // true if player has already double jumped
		
		public var hitbox:Hitbox			= new Hitbox(38, 60, 13, 20); //used for masking
		public var feetHitbox:Hitbox		= new Hitbox(38, 5, 13, 75); //used for platform hit detection
		
		public var maxHSpeed:Number		= GC.MAX_H_SPEED; //the maximum horizontal speed
		public var maxVSpeed:Number		= GC.MAX_V_SPEED; //the maximum horizontal speed
		public var moveSpeed:Number		= GC.MOVE_SPEED; //the current value
		
		public var upFlag:Boolean 		= false; //true if up is pressed and held
		public var downFlag:Boolean		= false; //true if down is pressed and held
		
		public var platformFallAlarm:Alarm	= new Alarm(0.10); //disable collision with platfrom for a second, letting the player fall through
		
		public var jumpSound:Sfx 		= new Sfx(GC.SFX_PLAYER_JUMP);
		public var explodeSound:Sfx 	= new Sfx(GC.SFX_EXPLOSION1);
		
		public function Player( x:Number=0, y:Number=0, v:Vector3D=null )
		{
			image.add('run_start', [9, 10, 11], GC.GFX_PLAYER_FPS, false);
			image.add('run_loop', [12, 13 ,14, 15, 16, 17, 18], GC.GFX_PLAYER_FPS, true);
			image.add('idle', [0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1], 12, true);
			image.add('jump', [3, 3, 4, 4, 4, 4, 5], GC.GFX_PLAYER_FPS, false);
			image.add('dbl_jump', [6, 6, 7, 7, 7, 7, 7], GC.GFX_PLAYER_FPS, false);
			image.add('turn', [19], GC.GFX_PLAYER_FPS, false);
			image.add('falling', [8]);
			image.add('ascending', [5]);
			
			type = GC.PLAYER_TYPE;
			
			this.x = x; 
			this.y = y;

			if (!v) velocity = new Vector3D; //make 0 velocity vector if none passed
			else velocity = v; //set the initial velocity vector
			
			graphic = image;
			mask = hitbox;
			
			addTween(platformFallAlarm);
		}
		
		override public function added():void 
		{
			layer = 2;
		}
		
		/*
		 * Kills the player, with explosion sfx
		 * */
		public function kill():void
		{
			//play some explostion animation and remove the player from the world as the callback
			explodeSound.play();
			world.remove(this);
			
			GV.FADE.fadeOut();
		}
		
		//player hit by enemy
		public function hit(e:Entity):void
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
			if ( platformFallAlarm.active ) trace('timer running');
			
			if (Input.pressed('Suicide')) kill();
			
			//check for plyer holding up or down
			if (Input.check(Key.UP)) upFlag = true;
			else upFlag = false;
			if (Input.check(Key.DOWN)) downFlag = true;
			else downFlag = false;
			
			hazardCollision();
			floorCollision();
			enemyCollision();
			gravLiftCollision();
			gravity();
			acceleration();
			jump();
			animate();
			sound();
			shoot();
			move( velocity.x * FP.elapsed, velocity.y * FP.elapsed );
			
			isFlippedPrev = isFlipped;
		}
		
		public function gravLiftCollision():void
		{
			var gl:GravityLift;
			if ( gl = collide(GC.GRAVLIFT_TYPE, x, y) as GravityLift )
			{
				if ( gl.isOn && !isOnGround && velocity.y < 0 ) //then move that playa UP, DAWG
				{
					velocity.y -= gl.speed;
				}
			}
		}
		
		public function hazardCollision():void
		{
			if ( collide(GC.HAZARD_TYPE, x, y) )
			{
				kill();
			}
		}
		
		public function shoot():void
		{
			if (!GV.EQUIPPED_WEAPON) return;
			
			if( (isFlipped && x > 0) || (!isFlipped && x < GV.CURRENT_LEVEL.levelWidth - width) )
			{
				if ( Input.pressed('Shoot') ) 
				{
					GV.EQUIPPED_WEAPON.fire(x, y, isFlipped, upFlag, downFlag, velocity);
				}
			}
		}
		
		/*
		 * Handle the player landing on floors,
		 * as well as platforms (including moving platforms)
		 * */
		public function floorCollision():void
		{			
			var e:Entity;
			
			/*
			 * Just the lame old ground
			 * */
			if ( e = collideTypes([GC.SOLID_TYPE, GC.PLATFORM_TYPE], x, y + 3) )
			{ 
				if (e.type == GC.SOLID_TYPE) 
				{
					velocity.y = 0;
					isOnGround = true;
					canDblJump = false;
					hasDblJumped = false;
				}
				return;
			}
			
			/*
			 * You're falling now, due to not standing on anything!
			 * */
			isOnGround = false;
		}
		
		public function enemyCollision():void
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
		
		public function gravity():void
		{
			if (isOnGround) return;
			velocity.y += Math.round(GC.GRAVITY * FP.elapsed);
			
			//cap vertical speed at maxVSpeed
			//var sign:int = velocity.y > 0 ? 1 : -1;
			//if ( Math.abs(velocity.y) > maxVSpeed ) velocity.y = sign * maxVSpeed;
			if ( velocity.y > maxVSpeed ) velocity.y = maxVSpeed;
		}
		
		public function acceleration():void
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
			
			//cap vertical speed at maxHSpeed
			var sign:int = velocity.x > 0 ? 1 : -1;
			if ( Math.abs(velocity.x) > maxHSpeed ) velocity.x = sign * maxHSpeed;
		}
		
		public function jump():void
		{			
			if( isOnGround && Input.pressed("Jump") )
			{
				if ( downFlag ) 
				{
					platformFallAlarm.start(); //disable platfrom collision of a second
					jumpSound.play();
					velocity.y = -GC.JUMP_SPEED/2;
				}
				else 
				{
					jumpSound.play();
					velocity.y = GC.JUMP_SPEED;
					isOnGround = false;
					if (velocity.x < 0 && image.flipped) velocity.x *= GC.LEAP;
					else if (velocity.x > 0 && !image.flipped) velocity.x *= GC.LEAP;
				}				
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
		
		public function animate():void
		{			
			//walk animation control
			if ( isOnGround && velocity.x == 0 )
			{
				image.play('idle');
			}
			
			//falling animation
			if ( velocity.y > 0 && !isOnGround )
			{
				image.play('falling');
			}
			
			if (isOnGround && image.currentAnim == 'falling')
			{
				image.play('idle');
			}
			
			// control facing direction
			if ( Input.check('Left') ) 
			{
				if ( !isFlipped && isOnGround ) 
				{
					image.play('turn');
				}
				
				image.flipped = true;
				isFlipped = true;
				
				if ( isOnGround )
				{
					if (image.currentAnim == 'idle') 
					{
						image.play('run_start');
					}
					if (image.complete)	
					{
						image.play('run_loop');
					}
				}
			}
			else if ( Input.check('Right') )
			{
				if ( isFlipped && isOnGround ) 
				{
					image.play('turn');
				}
				
				image.flipped = false;
				isFlipped = false;
				
				if ( isOnGround )
				{
					if (image.currentAnim == 'idle') 
					{
						image.play('run_start');
					}
					if (image.complete)	
					{
						image.play('run_loop');
					}
				}
			}
			
			//jump animation
			if ( Input.pressed('Jump') )
			{
				if ( !hasDblJumped )
				{
					image.play('jump', true);
				}
				else
				{
					image.setAnimFrame('dbl_jump', 0);
					image.play('dbl_jump');
				}
			}
		}
		
		public function sound():void
		{
			
		}
		
		override public function collideX(e:Entity):void 
		{
			velocity.x = 0;
		}
		
		override public function collideY(e:Entity):void 
		{
			velocity.y = 0;
		}
		
	}

}