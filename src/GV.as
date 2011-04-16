/*
 * Container for all of the games global variables
 * */

package  
{
	import flash.filters.BlurFilter;
	import items.RangedWeapon;
	import net.bloom.BloomLighting;
	import net.blur.BlurCanvas;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import worlds.*;
	
	
	public class GV 
	{
		public static var CURRENT_LEVEL:Level; //the currently loaded world tile
		//public static var PLAYER:Player; //the player
		public static var INVENTORY:Array = new Array();
		public static var EQUIPPED_WEAPON:RangedWeapon = null;
		
		public static var BLUR_CANVAS:BlurCanvas = new BlurCanvas(GC.CURSOR_BLUR_LEVEL);
		public static var ITEM_BLOOM_LIGHTING:BloomLighting = new BloomLighting(GC.BLOOM_AMOUNT, GC.BLOOM_QUALITY);
	}
}