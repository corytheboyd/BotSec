package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	public class PauseMenu extends Entity
	{		
		public function PauseMenu() 
		{
			graphic =  new Image(GC.GFX_PAUSE_MENU);
			x = FP.camera.x;
			y = FP.camera.y;
		}
		
		override public function added():void 
		{
			FP.console.log('PAUSED');
			buildMinimap();
		}
		
		override public function removed():void 
		{
			FP.console.log('UNPAUSED\n');
		}
		
		protected function buildMinimap():void
		{
			FP.console.log('Loading minimap...');
			
			//creates minimap entity, offset to fit the pause menu graphic
			var minimap:Entity = new Entity(16, 48);
			var tiles:Tilemap = new Tilemap(GC.GFX_MINIMAP_TILESET, 28, 14, 14, 14);
			minimap.graphic = tiles;
			minimap.layer = -1;
			
			const ROW_SIZE	:uint = 20; //how many rows on map
			var count		:uint = 0;
			var index		:uint;		//which tile to use
			
			for each ( var level:Level in GV.WORLD )
			{
				 index = level.visited? 1 : 0;
				 tiles.setTile( 0, 0, 1 );
				 count++;
			}
			
			world.add(minimap);
			
			FP.console.log('...Minimap loaded!');
		}
		
	}

}