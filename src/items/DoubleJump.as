package items 
{
	import net.flashpunk.graphics.Image;

	public class DoubleJump extends Item 
	{
		
		public function DoubleJump( x:int, y:int ) 
		{
			super(x, y);
			graphic = image = new Image(GC.GFX_UNLOCKS_DBL_JUMP);
		}	
		
		override public function update():void 
		{
			var p:Player;
			if ( p = collide(GC.PLAYER_TYPE, x, y) as Player )
			{
				GV.ENABLE_DBL_JUMP = true;
				p.enableDblJump = true;
				
				GV.UNLOCKS.toggleItem(1); //changes double jump icon to enabled
			}
			
			super.update();
		}
	}

}