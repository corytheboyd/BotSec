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
		//The tiles to populate minimap with. [0] is dark, [1] is vistied
		protected var minimap:Tilemap = new Tilemap(GC.GFX_MINIMAP_TILESET, 28, 14, 14, 14);
		
		public function PauseMenu() 
		{
			graphic =  new Image(GC.GFX_PAUSE_MENU);
			x = FP.camera.x;
			y = FP.camera.y;
		}
		
		override public function added():void 
		{
			FP.console.log('PAUSED');
			
			super.added();
		}
		
		override public function removed():void 
		{
			FP.console.log('UNPAUSED\n');
			
			//super.removed();
		}
		
		protected function buildMinimap():void
		{
			FP.console.log('Loading minimap...');
			
			var alphabet:Array = ("abcdefghijklmnopqrstuvwxyz").split("");
			for ( var i:uint = 0; i < alphabet.length; i++ )
			{
				for ( var j:uint = 1; j <= 20; j++ )
				{
					try
					{
						GV.WORLD.push( new Level( alphabet[i] + String(j) ) );
					}
					catch(e:Error) {/*Level has its own error checking*/}
				}
			}
			
			FP.console.log('...Minimap loaded!');
		}
		
	}

}