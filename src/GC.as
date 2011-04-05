/*
 * Container for all of the games constant values
 * */

package  
{
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import items.*;
	public class GC 
	{
		/*
		 * PYSICS CONSTANTS
		 * all in px/s
		 * */
		public static const	GRAVITY:Number			= 800;
		public static const	FRICTION:Number			= 1200;
		public static const	DRAG:Number				= 100;
		
		/*
		 * UI CONSTANTS
		 * */
		public static const CURSOR_BLUR_LEVEL:Number	= 0.75;
		public static const CURSOR_HEIGHT:Number		= 24;
		public static const CURSOR_WIDTH:Number			= 24;
		[Embed(source = '../assets/font/AlphaQuadrant.ttf', embedAsCFF = "false", fontFamily = 'MyFont')]
		public static const MY_FONT:Class;
		
		
		/*
		 * BLOOM SETTINGS
		 * */
		public static const BLOOM_AMOUNT:Number = 15;
		public static const BLOOM_QUALITY:Number = 1;
		
		/*
		 * INPUT CONSTANTS
		 * */
		Input.define("PauseMenu", Key.TAB);
		Input.define('Jump', Key.SPACE, Key.W, Key.UP);
		Input.define('Dash', Key.SHIFT);
		Input.define('Left', Key.A, Key.LEFT);
		Input.define('Right', Key.D, Key.RIGHT);
		
		/*
		 * PLAYER CONSTANTS
		 * */
		public static const	START_TILE:String 			= 'd9';		
		public static const	MAX_H_SPEED:Number			= 200;
		public static const	MAX_V_SPEED:Number			= 600;
		public static const	MOVE_SPEED:Number			= 800; 
		public static const	DASH_SPEED_MOD:Number		= 150;
		public static const	JUMP_SPEED:Number			= -340;
		public static const	DBL_JUMP_SPEED:Number		= -295;
		public static const	DBL_JUMP_LIMIT:Number		= 215;
		public static const	LEAP:Number					= 1.5;
		public static const BACKWARDS_SPEED_MOD:Number	= 0.85;
		
		/*
		 * ITEM CONSTANTS
		 * */
		//PISTOL
		public static const PISTOL_CLASS_REF:Class 		= Pistol;
		public static const PISTOL_BULLET_SPEED:Number	= 1200;
		public static const PISTOL_BULLET_DAMAGE:Number	= 1;
		public static const ITEM_MOVE_HEIGHT:Number		= 10;
		public static const ITEM_MOVE_RATE:Number		= 350;
		
		/*
		 * ENTITY TYPES
		 * */
		public static const SOLID_TYPE:String			= 'solid';
		public static const PLAYER_TYPE:String			= 'player';
		public static const LEVEL_TYPE:String			= 'level';
		public static const ITEM_TYPE:String			= 'item';
		public static const RANGED_WEAPON_TYPE:String	= 'rangedWeapon';
		
		/*
		 * GRAPHICS
		 * */
		[Embed(source='../assets/gfx/tileset.png')]
		public static const GFX_TILESET:Class;
		public static const GFX_TILESET_WIDTH:uint 	= 400;
		public static const GFX_TILESET_HEIGHT:uint = 144;
		
		[Embed(source = '../assets/gfx/player.png')]
		public static const	GFX_PLAYER:Class;		
		[Embed(source = '../assets/gfx/pistol.png')]
		public static const GFX_PISTOL:Class;		
		[Embed(source = '../assets/gfx/item_default.png')]
		public static const GFX_ITEM_DEFAULT:Class;		
		[Embed(source = '../assets/gfx/bullet_default.png')]
		public static const GFX_BULLET_DEFAULT:Class;		
		[Embed(source = '../assets/gfx/cursor_default.png')]
		public static const GFX_CURSOR_DEFAULT:Class;
		[Embed(source = '../assets/gfx/cursor_menu.png')]
		public static const GFX_CURSOR_MENU:Class;
		[Embed(source='../assets/gfx/reticle1.png')]
		public static const	GFX_RETICLE1:Class;
		[Embed(source = '../assets/gfx/pause_menu.png')]
		public static const	GFX_PAUSE_MENU:Class;
		[Embed(source = '../assets/gfx/minimap/tile_dark.png')]
		public static const	GFX_MINIMAP_DARK:Class;
		[Embed(source = '../assets/gfx/minimap/tile_visited.png')]
		public static const	GFX_MINIMAP_VISITED:Class;
		
		/*
		 * LEVEL XML DATA
		 * */
		[Embed(source = '../map/d9.oel', mimeType = 'application/octet-stream')]
		public static const d9:Class;		
		[Embed(source = '../map/d8.oel', mimeType = 'application/octet-stream')]
		public static const d8:Class;		
		[Embed(source = '../map/d7.oel', mimeType = 'application/octet-stream')]
		public static const d7:Class;
	}

}