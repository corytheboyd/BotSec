package worlds 
{
	import enemies.*;
	import items.*;
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
		protected var levelsVisited:Array = new Array;
		protected var paused:Boolean = false;
		protected var pauseMenu:PauseMenu;
		protected var respawnTimer:Timer = new Timer(1000, 0);
		protected var timeVar:Number = 0;
		
		public var PLAYER:Player;
		
		public function GameWorld() 
		{
			//nuthin
		}
		
		override public function begin():void 
		{
			//changes to starting tile
			switchLevel(GC.START_TILE); 
			
			//creates the player based on initial position in room
			PLAYER = new Player( int(GV.CURRENT_LEVEL.data.objects.player.@x), int(GV.CURRENT_LEVEL.data.objects.player.@y), new Vector3D(0, GC.RESPAWN_LAUNCH_SPEED) );			
			PLAYER.layer = 1;			
			GV.CURRENT_LEVEL.levelRespawner.activate();
			add(PLAYER);
			
			respawnTimer.addEventListener(TimerEvent.TIMER, respawnPlayer);
		}
		
		protected function respawnPlayer(e:TimerEvent):void
		{
			respawnTimer.reset();
			
			switchLevel(GV.CURRENT_SAVE_ROOM);
			PLAYER = new Player( int(GV.CURRENT_LEVEL.data.objects.player.@x), int(GV.CURRENT_LEVEL.data.objects.player.@y), new Vector3D(0, GC.RESPAWN_LAUNCH_SPEED) );
			PLAYER.layer = 1;
			GV.CURRENT_LEVEL.levelRespawner.activate();
			add(PLAYER);
		}
		
		override public function update():void 
		{			
			//TAKES YOU TO THE GLORIOUS DEBUG ROOM. ALL HAIL DEBUG.
			if ( (Input.check(Key.CONTROL) && Input.check(Key.SHIFT) && Input.pressed(Key.D)) && GV.CURRENT_LEVEL.levelName != 'a0')
			{
				remove(PLAYER);
				GV.CURRENT_SAVE_ROOM = 'a0';
				switchLevel('a0');
			}
			//END THE DEBUG ZONE ENTRANCE.
			
			if ( PLAYER.collide(GC.SOLID_TYPE, PLAYER.x, PLAYER.y) ) //get the player unstuck
			{
				var signX:int = ( Math.sin(getTimer()) > 0 ) ? 1 : -1;
				var signY:int = ( Math.cos(getTimer()) > 0 ) ? 1 : -1;
				
				var xNew:Number = PLAYER.x + 2 * Math.sin( getTimer() * 100 ) + 5 * signX;
				var yNew:Number = PLAYER.y + 2 * Math.cos( getTimer() * 100 ) + 5 * signY;
				
				if ( !PLAYER.collide(GC.SOLID_TYPE, xNew, yNew) )
				{
					PLAYER.x = xNew;
					PLAYER.y = yNew;
				}
			}
			else 
			{
				//reset the timeVar used to get the player unstuck
				timeVar = 0;
				
				if ( !PLAYER.world ) //player died, respawn them at the save room
				{
					respawnTimer.start(); //when finishes, calls respawn()
				}
				
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
		
		protected function switchLevel(targetTile:String):void
		{			
			FP.console.log('Setting up tile: ' + targetTile + '...');
			
			try { remove(GV.CURRENT_LEVEL); } catch (e:Error) { FP.console.log('Unable to remove level from GameWorld'); }
			try { removeList(GV.CURRENT_LEVEL.levelItems); } catch (e:Error) { FP.console.log('Unable to remove items from GameWorld'); }
			try { removeList(GV.CURRENT_LEVEL.levelDoors); } catch (e:Error) { FP.console.log('Unable to remove doors from GameWorld'); }
			try { removeList(GV.CURRENT_LEVEL.levelEnemies); } catch (e:Error) { FP.console.log('Unable to remove enemies from GameWorld'); }
			try { remove(GV.CURRENT_LEVEL.levelBeacon); } catch (e:Error) { FP.console.log('Unable to remove save beacon from GameWorld'); }
			try { removeList(GV.CONTEXT_MESSAGES); GV.CONTEXT_MESSAGES = []; } catch (e:Error) { FP.console.log('Unable to remove context messages from GameWorld'); }
			try { remove(GV.CURRENT_LEVEL.levelRespawner); } catch (e:Error) { FP.console.log('Unable to remove respawner from GameWorld'); }
			try { removeList(GV.CURRENT_LEVEL.levelPlatforms); } catch (e:Error) { FP.console.log('Unable to remove platforms from GameWorld'); }
			try { removeList(GV.CURRENT_LEVEL.levelHazards); } catch (e:Error) { FP.console.log('Unable to remove hazards from GameWorld'); }
			try { removeList(GV.CURRENT_LEVEL.levelLifts); } catch (e:Error) { FP.console.log('Unable to remove gravity lifts from GameWorld'); }
			try { removeList(GV.CURRENT_LEVEL.levelSwitches); } catch (e:Error) { FP.console.log('Unable to remove switches from GameWorld'); }
			try { removeList(GV.CURRENT_LEVEL.levelTVs); } catch (e:Error) { FP.console.log('Unable to remove TVs from GameWorld'); }
			
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
			
			//if level is saved, load it from memory
			if ( GV.VISITED_LEVELS[targetTile] ) 
			{
				GV.CURRENT_LEVEL = GV.VISITED_LEVELS[targetTile];
				if (GV.CURRENT_LEVEL.type == '') GV.CURRENT_LEVEL.type = GC.SOLID_TYPE;
				add(GV.CURRENT_LEVEL);
			}
			else //instantiate new copy of level and add it to memory
			{
				try 
				{
					GV.CURRENT_LEVEL = new Level(targetTile);
					add(GV.CURRENT_LEVEL);
					
					FP.console.log('Caching level ' + GV.CURRENT_LEVEL.levelName + '...');
					GV.VISITED_LEVELS[GV.CURRENT_LEVEL.levelName] = GV.CURRENT_LEVEL;
				} 
				catch (err:Error) 
				{
					FP.console.log('Tried to load nonexistent room, player is now dead as shit!');
					PLAYER.kill();
					respawnTimer.start();
				}
			}
			
			//add triggers
			for each ( var t:Trigger in GV.CURRENT_LEVEL.levelTriggers )
			{
				t.layer = -1;
				add(t);
			}
			
			//add tvs to world
			for each ( var tv:TV in GV.CURRENT_LEVEL.levelTVs )
			{
				tv.layer = 3;
				add(tv);
			}
			
			//add switches to world
			for each ( var s:Switch in GV.CURRENT_LEVEL.levelSwitches )
			{
				s.layer = 2;
				add(s);
				GV.CONTEXT_MESSAGES.push(s.contextMessage);
			}
			
			//add lifts to world
			for each ( var gl:GravityLift in GV.CURRENT_LEVEL.levelLifts )
			{
				gl.layer = 0;
				add(gl);
			}
			
			//add hazards to world
			for each ( var h:Entity in GV.CURRENT_LEVEL.levelHazards )
			{
				h.layer = 3;
				add(h);
			}
			
			//add platforms to world
			for each( var p:Platform in GV.CURRENT_LEVEL.levelPlatforms )
			{
				p.layer = 0;
				add(p);
			}
			
			//add respawner to world
			var r:Respawner = GV.CURRENT_LEVEL.levelRespawner;
			if ( r )
			{
				r.layer = 2;
				add(r);
			}
			
			//add save beacon to world
			var sb:SaveBeacon = GV.CURRENT_LEVEL.levelBeacon;
			if ( sb )
			{
				sb.layer = 2;
				add(sb);
				GV.CONTEXT_MESSAGES.push(sb.contextMessage);
			}
			
			//add all enemies to world
			for each ( var e:Enemy in GV.CURRENT_LEVEL.levelEnemies )
			{
				e.layer = 1;
				add(e);
			}
			
			//add all items to world
			for each ( var item:Item in GV.CURRENT_LEVEL.levelItems )
			{
				//pass if the item isn't set to spawn
				if ( !item.spawn ) continue;
				
				item.layer = 1;
				add(item);
			}
			
			//add all doors to world
			for each ( var door:Door in GV.CURRENT_LEVEL.levelDoors )
			{
				door.layer = 1;
				add(door);
				GV.CONTEXT_MESSAGES.push(door.contextMessage);
				
				FP.console.log('Added Door to world');
			}
			
			//add context messages
			for each ( var msg:ContextMessage in GV.CONTEXT_MESSAGES )
			{
				msg.layer = 0;
				add(msg);
			}

			GV.CURRENT_LEVEL.layer = 2;
			
			FP.console.log('...' + targetTile + ' loaded!');
		}
  
	}

}