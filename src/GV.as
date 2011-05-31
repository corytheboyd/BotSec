/*
 * Container for all of the games global variables
 * */

package  
{
	import flash.filters.BlurFilter;
	import flash.utils.Dictionary;
	import items.RangedWeapon;
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.World;
	import ui.FadeScreen;
	import ui.Unlocks;
	import worlds.*;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class GV 
	{
		public static var CURRENT_LEVEL:Level; //the currently loaded world tile
		public static var CURRENT_ZONE:String = ''; //string representing current area (pulled from Level.levelZone)
		public static var WORLD_ITEMS:Object = { }; //keeps track of which items have been collected. use like a Hash: WORLD_ITEMS['door1'] = new Door
		public static var CONTEXT_MESSAGES:Array = new Array;
		public static var VISITED_LEVELS:Dictionary = new Dictionary;
		public static var CURRENT_SAVE_ROOM:String = GC.START_TILE; //the room where the active save beacon is
		
		public static var INVENTORY:Array = new Array();
		public static var EQUIPPED_WEAPON:RangedWeapon;
		public static var ENABLE_DBL_JUMP:Boolean = false;
		
		public static var UNLOCKS:Unlocks = new Unlocks;
		
		public static var FADE:FadeScreen = new FadeScreen; //used to fade in/out
	}
}