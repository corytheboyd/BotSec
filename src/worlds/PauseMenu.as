package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	public class PauseMenu extends World 
	{
		
		public function PauseMenu() 
		{
			
		}
		
		override public function begin():void 
		{
			FP.console.log('PAUSED')
			addGraphic( new Image(GC.GFX_PAUSE_MENU) );
		}
		
		override public function end():void 
		{
			FP.console.log('UNPAUSED')
		}
		
		override public function update():void 
		{
			if ( Input.pressed('PauseMenu') )
			{
				FP.world = new GameWorld;
			}
		}
		
	}

}