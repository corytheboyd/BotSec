package ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.TiledSpritemap;
	import net.flashpunk.graphics.Tilemap;
	
	public class Unlocks extends Entity 
	{
		public var image:Image = new Image(GC.GFX_UNLOCKS_HUD);
		
		public var unlock1:Image = 	new Image(GC.GFX_UNLOCKS_DBL_JUMP);
		public var unlock2:Image = 	new Image(GC.GFX_UNLOCKS_PISTOL);
		
		protected const NUM_SLOTS:uint = 3;
		protected var addedUnlocks:Array = [];
		
		public function Unlocks() 
		{
			unlock1.scrollX = 0;
			unlock1.scrollY = 0;
			unlock2.scrollX = 0;
			unlock2.scrollY = 0;
			
			graphic = image;
			type = GC.HUD_TYPE;
			
			x = FP.width - image.width;
			image.scrollX = 0;
			image.scrollY = 0;
			
			//add the unlock images. First, sets all to default, then adds the unlocks referencing GV.UNLOCKS
			for ( var i:uint = 1; i <= NUM_SLOTS; i++ )
			{	
				try 
				{
					var newX:int = FP.width - image.width + 48 * i;
					
					var e:Entity = new Entity( newX , 8);
					var img:Image = this['unlock' + i];
					img.alpha = 0.45;
					img.color = 0x630000;
					
					e.graphic = img;
					e.layer = 0;
					e.type = GC.HUD_TYPE;
					
					addedUnlocks.push( e );
				} 
				catch (err:Error) {}
			}
		}
		
		override public function added():void 
		{
			layer = 1;
			
			for each ( var e:Entity in addedUnlocks )
			{
				world.add(e);
			}
		}
		
		public function toggleItem( itemNum:int ):void
		{
			try
			{
				var img:Image = this['unlock' + itemNum];
				img.color = 0xFFFFFF;
				img.alpha = 0.90;
			}
			catch (e:Error)
			{
				trace('UNLOCKS.AS: unable to change upgrade state\n\t', e);
			}
		}
		
	}

}