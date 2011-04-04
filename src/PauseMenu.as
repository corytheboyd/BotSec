package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
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
			
			super.added();
		}
		
		override public function removed():void 
		{
			FP.console.log('UNPAUSED\n');
			
			//super.removed();
		}
		
		protected function buildMinimap():void
		{
			for each( var level:Level in GV.WORLD )
			{
				
			}
		}
		
	}

}