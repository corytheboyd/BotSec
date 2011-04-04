package 
{
	import flash.ui.Mouse;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import worlds.GameWorld;
	import splash.Splash;
	
	public class Main extends Engine
	{
		public function Main()
		{
			super(960, 480, 60);
			//Mouse.hide();
			FP.console.enable();
			Text.font = 'MyFont';
			
			FP.world = GV.GAME_WORLD;
			
			/*			
			var s:Splash = new Splash;
			FP.world.add(s);
			s.start( GV.GAME_WORLD );
			*/	
		}
	}

}