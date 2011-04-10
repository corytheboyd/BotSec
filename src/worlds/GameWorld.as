package worlds 
{
	import doors.Door;
	import flash.filters.BlurFilter;
	import net.blur.BlurredGraphic;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.blur.BlurCanvas;
	import items.Item;

	public class GameWorld extends World 
	{		
		protected var cursor:Entity = new Entity;
		protected var paused:Boolean = false;
		protected var pauseMenu:PauseMenu;
		
		public function GameWorld() 
		{
			FP.console.enable();
			//nuthin
		}
		
		override public function begin():void 
		{	
			buildWorld(); //builds all world tiles
			switchLevel(GC.START_TILE); //changes to starting tile
			GV.PLAYER = new Player( int(GV.CURRENT_LEVEL.data.objects.player.@x), int(GV.CURRENT_LEVEL.data.objects.player.@y) );
			cursor.graphic = new BlurredGraphic(new Image(GC.GFX_CURSOR_DEFAULT), GV.BLUR_CANVAS);
			
			cursor.layer 					= -1;
			GV.ITEM_BLOOM_LIGHTING.layer 	= 0;
			GV.BLUR_CANVAS.layer			= 1;
			GV.PLAYER.layer 				= 0;
			GV.CURRENT_LEVEL.layer 			= 3;
			
			GV.ITEM_BLOOM_LIGHTING.color 	= GC.BLOOM_COLOR;
			
			add(GV.PLAYER);
			add(GV.CURRENT_LEVEL);
			add(GV.BLUR_CANVAS);
			add(GV.ITEM_BLOOM_LIGHTING);
			add(cursor);
			
			super.begin();
		}
				
		override public function update():void 
		{				
			//pause menu
			if ( Input.pressed("PauseMenu") )
			{				
				if (!paused)
				{
					pauseMenu = new PauseMenu;
					pauseMenu.layer	= 0;
					cursor.graphic = new Image(GC.GFX_CURSOR_MENU);
					add(pauseMenu);
					paused = true;
				}
				else
				{
					remove(pauseMenu);
					cursor.graphic = new BlurredGraphic(new Image(GC.GFX_CURSOR_DEFAULT), GV.BLUR_CANVAS);
					paused = false;
				}
			}
			
			//draw cursor, make it follow mouse
			cursor.x = mouseX - GC.CURSOR_WIDTH / 2;
			cursor.y = mouseY - GC.CURSOR_HEIGHT / 2;
			
			//update all this if the game is not paused
			if ( paused )
			{
				pauseMenu.update();
			}
			else
			{				
				//switch to left adjacent tile
				if ( GV.PLAYER.x + GV.PLAYER.width/2 < 0 )
				{
					switchLevel(GV.CURRENT_LEVEL.tileLeft);
					GV.PLAYER.x = GV.CURRENT_LEVEL.levelWidth - GV.PLAYER.width / 2;
				}
				//switch to right adjacent tile
				if ( GV.PLAYER.x + GV.PLAYER.width/2 > GV.CURRENT_LEVEL.levelWidth )
				{
					switchLevel(GV.CURRENT_LEVEL.tileRight);
					GV.PLAYER.x = -GV.PLAYER.width / 2;
				}
				//switch to top adjacent tile
				if ( GV.PLAYER.y + GV.PLAYER.height/2 < 0 )
				{
					switchLevel(GV.CURRENT_LEVEL.tileUp);
					GV.PLAYER.y = GV.CURRENT_LEVEL.levelHeight - GV.PLAYER.width / 2;
				}
				//switch to bottom adjacent tile
				if ( GV.PLAYER.y - GV.PLAYER.height/2 > GV.CURRENT_LEVEL.levelHeight )
				{
					switchLevel(GV.CURRENT_LEVEL.tileDown);
					GV.PLAYER.y = -GV.PLAYER.width / 2;
				}
				
				//focus camera on player
				FP.setCamera(GV.PLAYER.x - FP.screen.width / 2 + GV.PLAYER.width / 2, GV.PLAYER.y - FP.screen.height / 2);
				FP.camera.x = FP.clamp(FP.camera.x, 0, GV.CURRENT_LEVEL.levelWidth - FP.width);
				FP.camera.y = FP.clamp(FP.camera.y, 0, GV.CURRENT_LEVEL.levelHeight - FP.height);
				
				super.update();
			}		
		}
		
		private function switchLevel(targetTile:String):void
		{				
			FP.console.log('Setting up tile: ' + targetTile + '...');
			try
			{
				remove(GV.CURRENT_LEVEL);
				removeList(GV.CURRENT_LEVEL.levelItems);
				removeList(GV.CURRENT_LEVEL.levelDoors);
			}
			catch (e:Error) { FP.console.log('HAY, YOU: Tried to remove something that does not exist'); }
			
			for (var i:uint = 0; i < GV.WORLD.length; i++ )
			{
				if ( GV.WORLD[i].levelName == targetTile )
				{
					FP.console.log('...' + targetTile + ' loaded!');
					GV.CURRENT_LEVEL = GV.WORLD[i];
					GV.CURRENT_LEVEL.layer = 2;
					if(!GV.CURRENT_LEVEL.visited) GV.CURRENT_LEVEL.visited = true;
					
					//add the level to world
					add(GV.CURRENT_LEVEL);
					
					//add all items to world
					for each ( var item:Item in GV.CURRENT_LEVEL.levelItems )
					{
						//pass if the item isn't set to spawn
						if ( !item.spawn ) continue;
						
						item.layer = 1;
						add(item);
						
						FP.console.log('Added ' + item + ' to world');
					}
					
					for each ( var door:Entity in GV.CURRENT_LEVEL.levelDoors )
					{
						door.layer = 2;
						add(door);
						
						FP.console.log('Added Door to world');
					}
					
					return;
				}
			}			
		}
		
		private function buildWorld():void
		{
			FP.console.log('Loading world...');
			
			var alphabet:Array = ("abcdefghijklmnopqrstuvwxyz").split("");
			for ( var i:uint = 0; i < alphabet.length; i++ )
			{
				for ( var j:uint = 1; j <= 20; j++ )
				{
					try
					{
						var newLevel:Level = new Level( alphabet[i] + String(j) )						
						GV.WORLD.push( newLevel );
					}
					catch(e:Error) {/*Level has its own error checking*/}
				}
			}
			
			FP.console.log('...World loaded!');
		}		
	}

}