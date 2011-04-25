package worlds 
{
	import doors.Door;
	import enemies.Enemy;
	import flash.ui.ContextMenu;
	import interactives.Respawner;
	import interactives.SaveBeacon;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import items.Item;
	import ui.*;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class GameWorld extends World 
	{
		protected var levelsVisited:Array = new Array;
		protected var paused:Boolean = false;
		protected var pauseMenu:PauseMenu;
		
		public var PLAYER:Player;
		
		public function GameWorld() 
		{
			//nuthin
		}
		
		override public function begin():void 
		{
			switchLevel(GC.START_TILE); //changes to starting tile
			PLAYER = new Player( int(GV.CURRENT_LEVEL.data.objects.player.@x), int(GV.CURRENT_LEVEL.data.objects.player.@y) );
			
			PLAYER.layer	= 0;
			
			add(PLAYER);
			add(GV.CURRENT_LEVEL);
		}
		
		override public function update():void 
		{	
			if ( !PLAYER.world ) //player died, respawn them at the save room
			{
				switchLevel(GV.CURRENT_SAVE_ROOM);
				PLAYER = new Player( int(GV.CURRENT_LEVEL.data.objects.player.@x), int(GV.CURRENT_LEVEL.data.objects.player.@y) );
				GV.CURRENT_LEVEL.levelRespawner.activate();
				add(PLAYER);
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
					PLAYER.x = GV.CURRENT_LEVEL.levelWidth - PLAYER.width / 2;
					switchLevel(GV.CURRENT_LEVEL.tileLeft);
				}
				//switch to right adjacent tile
				if ( PLAYER.x + PLAYER.width/2 > GV.CURRENT_LEVEL.levelWidth )
				{
					PLAYER.x = -PLAYER.width / 2;
					switchLevel(GV.CURRENT_LEVEL.tileRight);
				}
				//switch to top adjacent tile
				if ( PLAYER.y + PLAYER.height/2 < 0 )
				{
					PLAYER.y = GV.CURRENT_LEVEL.levelHeight - PLAYER.width / 2;
					switchLevel(GV.CURRENT_LEVEL.tileUp);
				}
				//switch to bottom adjacent tile
				if ( PLAYER.y - PLAYER.height/2 > GV.CURRENT_LEVEL.levelHeight )
				{
					PLAYER.y = -PLAYER.width / 2;
					switchLevel(GV.CURRENT_LEVEL.tileDown);
				}
				
				//focus camera on player
				FP.setCamera(PLAYER.x - FP.screen.width / 2 + PLAYER.width / 2, PLAYER.y - FP.screen.height / 2);
				FP.camera.x = FP.clamp(FP.camera.x, 0, GV.CURRENT_LEVEL.levelWidth - FP.width);
				FP.camera.y = FP.clamp(FP.camera.y, 0, GV.CURRENT_LEVEL.levelHeight - FP.height);
				
				super.update();
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
			
			//REMOVE THE MESG GRAPHICS OF CONTEXT MESSAGES
			
			GV.CURRENT_LEVEL = new Level(targetTile);
			add(GV.CURRENT_LEVEL);
			
			//get the player out of the level if they get stuck
			if ( PLAYER ) unstuckPlayer();
			
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
				
				FP.console.log('Added ' + item + ' to world');
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

			GV.CURRENT_LEVEL.layer 			= 2;
			
			FP.console.log('...' + targetTile + ' loaded!');			
		}
		
		/*
		 * If the player is stuck inside of a solid, gets them out!
		 * */
		protected function unstuckPlayer():void
		{
			if ( PLAYER.collide(GC.SOLID_TYPE, PLAYER.x, PLAYER.y + 10) )
			{
				trace('stuck');
			}
		}
  
	}

}