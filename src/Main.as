package 
{
	import flash.ui.Mouse;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import worlds.GameWorld;
	import splash.*;
	import worlds.MainMenu;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Main extends Engine
	{		
		public function Main()
		{
			super(960, 480, 60);
			FP.screen.color = 0x00000000;
			
			//Mouse.hide();
			FP.console.enable();
			
			FP.world = new GameWorld;
			//FP.world = new MainMenu;
		}
	}

}