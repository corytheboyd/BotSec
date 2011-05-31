package worlds 
{
	import enemies.*;
	import items.*;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.utils.Ease;
	import platforms.*;
	import ui.*;
	import interactives.*;
	import flash.utils.getTimer;
	import flash.utils.Dictionary;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.ui.ContextMenu;
	import flash.utils.Timer;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class GameWorld extends World 
	{
		public var levelsVisited:Array = new Array;
		public var paused:Boolean = false;
		public var pauseMenu:PauseMenu;
		public var respawnTimer:Alarm = new Alarm(1, respawnPlayer);
		public var playerStuck:Boolean = false;
		public var playerStuckMoveDir:Vector3D = new Vector3D;
		public var PLAYER:Player;
		
		public var ZONE1_SOUND:Sfx = new Sfx(GC.SFX_ZONE1);
		public var ZONE2_SOUND:Sfx = new Sfx(GC.SFX_ZONE2);
		public var ZONE3_SOUND:Sfx = new Sfx(GC.SFX_ZONE3);
		public var ZONE4_SOUND:Sfx = new Sfx(GC.SFX_ZONE4);
		
		public var discoAlarm:Alarm = new Alarm(0.25, randomBgColor);
		protected var currentColorIndex:uint = 0;
		
		public function GameWorld()
		{		
			addTween(respawnTimer);
			addTween(discoAlarm);
		}
		
		override public function begin():void 
		{
			//add the unlock tracker (hud element)
			add(GV.UNLOCKS);
			
			//add the fader effect
			GV.FADE.layer = 0;
			add(GV.FADE);
			GV.FADE.fadeIn(); //fade in on world start
			
			//changes to starting tile
			switchLevel(GC.START_TILE); //sets gv.current_level		
			
			//creates the player based on initial position in room
			respawnPlayer();
		}
		
		public function respawnPlayer():void
		{
			if (GV.CURRENT_LEVEL.levelName != GV.CURRENT_SAVE_ROOM) switchLevel(GV.CURRENT_SAVE_ROOM);
			
			if ( PLAYER )
			{
				//if (PLAYER.world) PLAYER.kill(); //kill they player if they aren't dead yet
			}
			
			PLAYER = new Player( int(GV.CURRENT_LEVEL.data.objects.player.@x), int(GV.CURRENT_LEVEL.data.objects.player.@y) );
			PLAYER.disabled = true;
			add(PLAYER);
			
			GV.CURRENT_LEVEL.levelRespawners[0].activate( enablePlayer );			
			GV.FADE.fadeIn();
		}
		
		protected function enablePlayer():void
		{
			PLAYER.disabled = false;
		}
		
		protected function randomBgColor():void
		{
			var colors:Array = [
				0xCD0074, //pink
				0xFF4900, //orange
				0xFFEB00, //yellow
				0x33CCCC //blue
			];
			
			FP.screen.color = colors[currentColorIndex];
			currentColorIndex += 1;
			if (currentColorIndex > colors.length - 1) currentColorIndex = 0;
		}
		
		override public function update():void 
		{			
			if ( GV.CURRENT_ZONE == "ZONE4" && !discoAlarm.active )
			{
				discoAlarm.start();
			}
			else if ( GV.CURRENT_ZONE != "ZONE4" && discoAlarm.active ) 
			{
				discoAlarm.reset(0.25);
			}
			
			if ( PLAYER.collide(GC.SOLID_TYPE, PLAYER.x, PLAYER.y) ) //get the player unstuck
			{
				if ( !playerStuck ) //the first from of player being stuck
				{
					if ( !PLAYER.collide(GC.SOLID_TYPE, PLAYER.x, PLAYER.y - 32) ) //check up
					{
						playerStuckMoveDir = new Vector3D(0, -5);
					}
					else if ( !PLAYER.collide(GC.SOLID_TYPE, PLAYER.x - 32, PLAYER.y) ) //check left
					{
						playerStuckMoveDir = new Vector3D(-5, 0);
					}
					else if ( !PLAYER.collide(GC.SOLID_TYPE, PLAYER.x + 32, PLAYER.y) ) //check right
					{
						playerStuckMoveDir = new Vector3D(5, 0);
					}
					else if ( !PLAYER.collide(GC.SOLID_TYPE, PLAYER.x, PLAYER.y - 32) ) //check down
					{
						playerStuckMoveDir = new Vector3D(0, 5);
					}
					else
					{
						respawnPlayer();
					}
				}
				else
				{					
					PLAYER.x += playerStuckMoveDir.x;
					PLAYER.y += playerStuckMoveDir.y;
				}
				
				playerStuck = true; //set player to stuck now
			}
			else if ( !PLAYER.world && !respawnTimer.active ) //player died, respawn them at the save room
			{
				respawnTimer.start(); //when finishes, calls respawn()
				return;
			}
			else if ( PLAYER.world && !respawnTimer.active )
			{
				if(playerStuck) playerStuck = false; //reset playerStuck
				
				//pause menu
				if ( Input.pressed("Pause") )
				{				
					if (!paused)
					{
						pauseMenu = new PauseMenu;
						pauseMenu.layer	= 0;
						add(pauseMenu);
						paused = true;
					}
					else
					{
						remove(pauseMenu);
						paused = false;
					}
				}
				
				//update all this if the game is not paused
				if ( paused )
				{
					pauseMenu.update();
				}
				else
				{				
					//switch to left adjacent tile
					if ( PLAYER.x + PLAYER.width/2 < 0 )
					{
						GV.CURRENT_LEVEL.type = ''; //make current level uncollidable
						switchLevel(GV.CURRENT_LEVEL.tileLeft);
						PLAYER.x = GV.CURRENT_LEVEL.levelWidth - PLAYER.width / 2;
					}
					//switch to right adjacent tile
					if ( PLAYER.x + PLAYER.width/2 > GV.CURRENT_LEVEL.levelWidth )
					{
						GV.CURRENT_LEVEL.type = ''; //make current level uncollidable
						switchLevel(GV.CURRENT_LEVEL.tileRight);
						PLAYER.x = -PLAYER.width / 2;
					}
					//switch to top adjacent tile
					if ( PLAYER.y + PLAYER.height < 0 )
					{
						GV.CURRENT_LEVEL.type = ''; //make current level uncollidable
						switchLevel(GV.CURRENT_LEVEL.tileUp);
						PLAYER.y = GV.CURRENT_LEVEL.levelHeight - PLAYER.width / 2;
					}
					//switch to bottom adjacent tile
					if ( PLAYER.y - PLAYER.height/2 > GV.CURRENT_LEVEL.levelHeight )
					{
						GV.CURRENT_LEVEL.type = ''; //make current level uncollidable
						switchLevel(GV.CURRENT_LEVEL.tileDown);
						PLAYER.y = -PLAYER.width / 2;
					}
					
					//focus camera on player
					FP.setCamera(PLAYER.x - FP.screen.width / 2 + PLAYER.width / 2, PLAYER.y - FP.screen.height / 2);
					FP.camera.x = FP.clamp(FP.camera.x, 0, GV.CURRENT_LEVEL.levelWidth - FP.width);
					FP.camera.y = FP.clamp(FP.camera.y, 0, GV.CURRENT_LEVEL.levelHeight - FP.height);
					
					super.update();
				}
			}		
		}
		
		public function switchLevel(targetTile:String):void
		{			
			FP.console.log('Setting up tile: ' + targetTile + '...');
			
			try { remove(GV.CURRENT_LEVEL); } 									catch (e:Error) {}
			try { removeList(GV.CURRENT_LEVEL.levelItems); }					catch (e:Error) {}
			try { removeList(GV.CURRENT_LEVEL.levelDoors); } 					catch (e:Error) {}
			try { removeList(GV.CURRENT_LEVEL.levelEnemies); } 					catch (e:Error) {}
			try { removeList(GV.CURRENT_LEVEL.levelBeacons); } 					catch (e:Error) {}
			try { removeList(GV.CONTEXT_MESSAGES); GV.CONTEXT_MESSAGES = []; } 	catch (e:Error) {}
			try { removeList(GV.CURRENT_LEVEL.levelRespawners); } 				catch (e:Error) {}
			try { removeList(GV.CURRENT_LEVEL.levelPlatforms); } 				catch (e:Error) {}
			try { removeList(GV.CURRENT_LEVEL.levelHazards); } 					catch (e:Error) {}
			try { removeList(GV.CURRENT_LEVEL.levelLifts); } 					catch (e:Error) {}
			try { removeList(GV.CURRENT_LEVEL.levelSwitches); } 				catch (e:Error) {}
			try { removeList(GV.CURRENT_LEVEL.levelTVs); } 						catch (e:Error) {}
            try { removeList(GV.CURRENT_LEVEL.levelTriggers); } 				catch (e:Error) {}
			
			//clears all other entities without assigned types (basically, antyhing left over that is not the player
			var spareObjects:Array = [];
			getClass(Entity, spareObjects);
			for each( var spareObject:Entity in spareObjects )
			{				
				if (spareObject.type == '')
				{
					remove(spareObject);
				}
			}			
			
			//store previous level zone
			if (GV.CURRENT_LEVEL) var prevZone:String = GV.CURRENT_LEVEL.levelZone;
			
			//if level is saved, load it from memory
			if ( GV.VISITED_LEVELS[targetTile] ) 
			{				
				var newLevel:Level = GV.CURRENT_LEVEL = GV.VISITED_LEVELS[targetTile];
				GV.CURRENT_LEVEL = GV.VISITED_LEVELS[targetTile];
				GV.CURRENT_LEVEL.cached = true;
				add(GV.CURRENT_LEVEL);
			}
			else //instantiate new copy of level and add it to memory
			{ 				
				newLevel = new Level(targetTile);
				GV.VISITED_LEVELS[newLevel.levelName] = GV.CURRENT_LEVEL = newLevel;
				add(newLevel);
			}
			
			//get all loose tweens and remove them
			var sfxFaders:Array = [];
			getClass(SfxFader, sfxFaders);
			for each ( var tempFader:SfxFader in sfxFaders )
			{
				removeTween(tempFader);
			}
			
			//if no zone is found, copy the previous zone over
			if (GV.CURRENT_LEVEL.levelZone == '') GV.CURRENT_LEVEL.levelZone = prevZone;
			
			//add the screen fader effect again
			GV.FADE.layer = 0;
			add(GV.FADE);
			
			//loading the first level
			if (GV.CURRENT_ZONE == '')
			{
				GV.CURRENT_ZONE = GV.CURRENT_LEVEL.levelZone;
				this[GV.CURRENT_ZONE + "_SOUND"].loop();
			}
			
			//if the level zone changes, change the music
			if ( (GV.CURRENT_LEVEL.levelZone != GV.CURRENT_ZONE) )
			{
				//sound
				var oldTrack:Sfx	= this[GV.CURRENT_ZONE + "_SOUND"];
				var newTrack:Sfx	= this[GV.CURRENT_LEVEL.levelZone + "_SOUND"];
				
				var fadeToNew:SfxFader	= new SfxFader(oldTrack);
				fadeToNew.crossFade(newTrack, true, 0.5, 1, Ease.cubeIn);
				addTween(fadeToNew);
				
				fadeToNew.start();
			}
			
			GV.CURRENT_ZONE = GV.CURRENT_LEVEL.levelZone;
			
			//CHANGE SCREEN COLOR
			FP.screen.color = GC[GV.CURRENT_ZONE + "_COLOR"];
			
			//add art assets
			for each ( var aa:Entity in GV.CURRENT_LEVEL.levelArtAssets )
			{
				aa.layer = 4;
				add(aa);
			}
			
			//add triggers
			for each ( var t:Trigger in GV.CURRENT_LEVEL.levelTriggers )
			{
				add(t);
			}
			
			//add tvs to world
			for each ( var tv:TV in GV.CURRENT_LEVEL.levelTVs )
			{
				add(tv);
			}
			
			//add switches to world
			for each ( var s:Switch in GV.CURRENT_LEVEL.levelSwitches )
			{
				add(s);
				GV.CONTEXT_MESSAGES.push(s.contextMessage);
			}
			
			//add lifts to world
			for each ( var gl:GravityLift in GV.CURRENT_LEVEL.levelLifts )
			{
				add(gl);
			}
			
			//add hazards to world
			for each ( var h:Entity in GV.CURRENT_LEVEL.levelHazards )
			{
				add(h);
			}
			
			//add platforms to world
			for each( var p:Platform in GV.CURRENT_LEVEL.levelPlatforms )
			{
				add(p);
			}
			
			//add respawner
			for each ( var r:Respawner in GV.CURRENT_LEVEL.levelRespawners )
			{
				add(r);
			}
			
			//add save beacon
			for each( var sb:SaveBeacon in GV.CURRENT_LEVEL.levelBeacons )
			{
				add(sb);
				GV.CONTEXT_MESSAGES.push(sb.contextMessage);
			}
			
			//add all enemies to world
			for each ( var e:Enemy in GV.CURRENT_LEVEL.levelEnemies )
			{
				add(e);
			}
			
			//add all items to world
			for each ( var item:Item in GV.CURRENT_LEVEL.levelItems )
			{
				//pass if the item isn't set to spawn
				if ( !item.spawn ) continue;
				
				add(item);
			}
			
			//add all doors to world
			for each ( var door:Door in GV.CURRENT_LEVEL.levelDoors )
			{
				add(door);
				GV.CONTEXT_MESSAGES.push(door.contextMessage);
			}
			
			//add context messages
			for each ( var msg:ContextMessage in GV.CONTEXT_MESSAGES )
			{
				add(msg);
			}

			GV.CURRENT_LEVEL.layer = 4;
		}
  
	}

}
