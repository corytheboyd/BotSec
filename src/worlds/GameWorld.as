package worlds 
{
	import doors.Door;
	import flash.filters.BlurFilter;
	import flash.utils.getTimer;
	import net.blur.BlurredGraphic;
	import net.blur.MotionBlur;
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
	import worlds.PauseMenu;

	public class GameWorld extends World 
	{		
		protected var cursor:Entity = new Entity;
		protected var paused:Boolean = false;
		protected var pauseMenu:PauseMenu;
		
		public function GameWorld() 
		{			
			switchLevel(GV.PLAYER.currentTile); //changes to tile the player is on
			GV.PLAYER.x = int(GV.CURRENT_LEVEL.data.objects.player.@x);
			GV.PLAYER.y = int(GV.CURRENT_LEVEL.data.objects.player.@y);
			
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
		}
		
		override public function begin():void 
		{			
			super.begin();
		}
				
		override public function update():void 
		{
			//pause menu
			if ( Input.pressed("PauseMenu") )
			{
				FP.world = new PauseMenu;
			}
			
			//draw cursor, make it follow mouse
			cursor.x = mouseX - GC.CURSOR_WIDTH / 2;
			cursor.y = mouseY - GC.CURSOR_HEIGHT / 2;

			//switch to left adjacent tile
			if ( GV.PLAYER.x + GV.PLAYER.width/2 < 0 )
			{
				GV.PLAYER.currentTile = GV.CURRENT_LEVEL.tileLeft;
				switchLevel(GV.CURRENT_LEVEL.tileLeft);
				GV.PLAYER.x = GV.CURRENT_LEVEL.levelWidth - GV.PLAYER.width / 2;
			}
			//switch to right adjacent tile
			if ( GV.PLAYER.x + GV.PLAYER.width/2 > GV.CURRENT_LEVEL.levelWidth )
			{
				GV.PLAYER.currentTile = GV.CURRENT_LEVEL.tileRight;
				switchLevel(GV.CURRENT_LEVEL.tileRight);
				GV.PLAYER.x = -GV.PLAYER.width / 2;
			}
			//switch to top adjacent tile
			if ( GV.PLAYER.y + GV.PLAYER.height/2 < 0 )
			{
				GV.PLAYER.currentTile = GV.CURRENT_LEVEL.tileUp;
				switchLevel(GV.CURRENT_LEVEL.tileUp);
				GV.PLAYER.y = GV.CURRENT_LEVEL.levelHeight - GV.PLAYER.width / 2;
			}
			//switch to bottom adjacent tile
			if ( GV.PLAYER.y - GV.PLAYER.height/2 > GV.CURRENT_LEVEL.levelHeight )
			{
				GV.PLAYER.currentTile = GV.CURRENT_LEVEL.tileDown;
				switchLevel(GV.CURRENT_LEVEL.tileDown);
				GV.PLAYER.y = -GV.PLAYER.width / 2;
			}
			
			//focus camera on player
			FP.setCamera(GV.PLAYER.x - FP.screen.width / 2 + GV.PLAYER.width / 2, GV.PLAYER.y - FP.screen.height / 2);
			FP.camera.x = FP.clamp(FP.camera.x, 0, GV.CURRENT_LEVEL.levelWidth - FP.width);
			FP.camera.y = FP.clamp(FP.camera.y, 0, GV.CURRENT_LEVEL.levelHeight - FP.height);
			
			super.update();		
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
			
			GV.CURRENT_LEVEL = new Level(targetTile);
			GV.CURRENT_LEVEL.layer 			= 3;
			
			FP.console.log('tile ' + targetTile + ' added!')
		}
		
	}

}