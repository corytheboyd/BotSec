package items 
{
	import flash.utils.Timer;
	import net.bloom.BloomWrapper;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import bullets.PistolBullet;
	
	public class Pistol extends RangedWeapon
	{
		public function Pistol(x:int = 0, y:int = 0 ) 
		{
			super(x, y);		
			bulletType = PistolBullet;
			fireTimer = new Timer(250);			
		}
		
		override public function update():void 
		{
			animate(); //idle animation of item
			
			if ( collide(GC.PLAYER_TYPE, x, y) ) 
			{
				FP.console.log('COLLECTED ITEM:', this);
				GV.INVENTORY.push(this); //add to players inventory
				
				if (!GV.EQUIPPED_WEAPON) GV.EQUIPPED_WEAPON = this;
				
				world.remove(this);
				
				if(!respawns)
				{
					for each(var item:Entity in GV.CURRENT_LEVEL.levelItems)
					{
						if ( item == this ) FP.console.log(item + ' removed from level!');
						spawn = false;
					}
				}
			}
		}
		
	}

}