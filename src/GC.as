/*
 * Container for all of the games constant values
 * */

package  
{
	import flash.desktop.ClipboardFormats;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import items.*;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class GC 
	{
		/*
		 * PYSICS CONSTANTS
		 * all in px/s
		 * */
		public static const	GRAVITY:Number			= 1000;
		public static const	FRICTION:Number			= 1800;
		public static const	DRAG:Number				= 100;
		
		/*
		 * PLAYER CONSTANTS
		 * */
		public static const	START_TILE:String 			= 'h6';
		public static const	MAX_H_SPEED:Number			= 300;
		public static const	MAX_V_SPEED:Number			= 700;
		public static const	MOVE_SPEED:Number			= 2000;
		public static const	JUMP_SPEED:Number			= -400;
		public static const	DBL_JUMP_SPEED:Number		= -300;
		public static const	DBL_JUMP_LIMIT:Number		= 300;
		public static const	LEAP:Number					= 1.5;
		public static const AIR_DRAG:Number				= 0.35;
		public static const RESPAWN_LAUNCH_SPEED:Number = -500;
		
		/*
		 * ENEMY CONSTANTS
		 * */
		public static const E1_MOVE_SPEED:Number		= 100;
		
		/*
		 * UI CONSTANTS
		 * */
		public static const CURSOR_BLUR_LEVEL:Number	= 0.75;
		public static const CURSOR_HEIGHT:Number		= 24;
		public static const CURSOR_WIDTH:Number			= 24;
		public static const MSG_FADE_RATE:Number		= 0.1;
		public static const MSG_DURATION:Number			= 1.5;
		
		/*
		 * BLOOM SETTINGS
		 * */
		public static const BLOOM_AMOUNT:Number = 15;
		public static const BLOOM_QUALITY:Number = 1;
		public static const BLOOM_COLOR:uint = 0xfeff9e;
		
		/*
		 * INPUT CONSTANTS
		 * */
		Input.define("Pause", Key.ENTER, Key.P);
		Input.define('Jump', Key.SPACE, Key.UP);
		Input.define('Left', Key.LEFT);
		Input.define('Right', Key.RIGHT);
		Input.define('Shoot', Key.Z);
		Input.define('Action', Key.X);
		Input.define('Suicide', Key.R);
			
		/*
		 * ITEM CONSTANTS
		 * */
		//PISTOL
		public static const PISTOL_CLASS_REF:Class 		= Pistol; //needed for getDefByName... otherwise it wont be in namespace
		public static const PISTOL_BULLET_SPEED:Number	= 650;
		public static const PISTOL_BULLET_DAMAGE:Number	= 1;
		public static const ITEM_MOVE_HEIGHT:Number		= 10;
		public static const ITEM_MOVE_RATE:Number		= 350;
		
		/*
		 * DOOR CONSTANTS
		 * */
		public static const DOOR_OPEN_SPEED:uint		= 20; //fps of the door open/close animation
		
		/*
		 * ENTITY TYPES
		 * */
		public static const SOLID_TYPE:String			= 'solid';
		public static const PLAYER_TYPE:String			= 'player';
		public static const LEVEL_TYPE:String			= 'level';
		public static const ITEM_TYPE:String			= 'item';
		public static const DOOR_TYPE:String			= 'door';
		public static const RANGED_WEAPON_TYPE:String	= 'rangedWeapon';
		public static const BULLET_TYPE:String			= 'bullet';
		public static const ENEMY_TYPE:String			= 'enemy';
		public static const PLATFORM_TYPE:String		= 'platform';
		public static const MESSAGE_TYPE:String			= 'message';
		public static const HAZARD_TYPE:String			= 'hazard';
		public static const GRAVLIFT_TYPE:String		= 'gravityLift'
		
		/*
		 * Array with all types, for debuggin and stuff
		 * */
		public static const ALL_TYPES:Array = [SOLID_TYPE, PLAYER_TYPE, LEVEL_TYPE, ITEM_TYPE, DOOR_TYPE, RANGED_WEAPON_TYPE, BULLET_TYPE, ENEMY_TYPE, PLATFORM_TYPE, MESSAGE_TYPE, HAZARD_TYPE];
		
		/*
		 * MUSIC
		 * */
		[Embed(source = '../assets/music/title_song.mp3')]
		public static const SFX_TITLE_TRACK:Class;
		
		/*
		 * SFX
		 * */
		[Embed(source = '../assets/sfx/jump.mp3')]
		public static const SFX_PLAYER_JUMP:Class;
		[Embed(source = '../assets/sfx/shoot_pistol.mp3')]
		public static const SFX_PISTOL_SHOOT:Class;
		[Embed(source = '../assets/sfx/ricochet1.mp3')]
		public static const SFX_BULLET_RICOCHET1:Class;
		[Embed(source = '../assets/sfx/ricochet2.mp3')]
		public static const SFX_BULLET_RICOCHET2:Class;
		[Embed(source = '../assets/sfx/ricochet3.mp3')]
		public static const SFX_BULLET_RICOCHET3:Class;
		[Embed(source='../assets/sfx/explosion1.mp3')]
		public static const SFX_EXPLOSION_SMALL:Class;
		[Embed(source = '../assets/sfx/buzzer.mp3')]
		public static const SFX_BUZZER:Class;
		
		/*
		 * GRAPHICS
		 * */
		[Embed(source='../assets/gfx/tileset.png')]
		public static const GFX_TILESET:Class;
		public static const GFX_TILESET_WIDTH:uint 	= 400;
		public static const GFX_TILESET_HEIGHT:uint = 144;
		
		[Embed(source = '../assets/gfx/save_beacon.png')]
		public static const GFX_SAVE:Class;
		public static const GFX_SAVE_WIDTH:uint = 64;
		public static const GFX_SAVE_HEIGHT:uint = 64;
		
		[Embed(source = '../assets/gfx/player/player.png')]
		public static const GFX_PLAYER:Class;
		public static const GFX_PLAYER_FPS:uint = 24;
		
		//make it a tilemap later
		[Embed(source = '../assets/gfx/enemies/E1.png')]
		public static const	GFX_E1:Class;
		
		[Embed(source = '../assets/gfx/blackscreen.png')]
		public static const GFX_BLACKSCREEN:Class;
		[Embed(source = '../assets/gfx/pistol.png')]
		public static const GFX_PISTOL:Class;		
		[Embed(source = '../assets/gfx/item_default.png')]
		public static const GFX_ITEM_DEFAULT:Class;		
		[Embed(source = '../assets/gfx/bullet_default.png')]
		public static const GFX_BULLET_DEFAULT:Class;		
		[Embed(source = '../assets/gfx/cursor_default.png')]
		public static const GFX_CURSOR_DEFAULT:Class;
		[Embed(source = '../assets/gfx/tileset_door.png')]
		public static const GFX_DOOR_TILESET:Class;
		[Embed(source = '../assets/gfx/tileset_doorH.png')]
		public static const GFX_DOORH_TILESET:Class;
		[Embed(source = '../assets/gfx/cursor_menu.png')]
		public static const GFX_CURSOR_MENU:Class;
		[Embed(source = '../assets/gfx/pause_menu.png')]
		public static const	GFX_PAUSE_MENU:Class;
		[Embed(source = '../assets/gfx/minimap/tileset.png')]
		public static const	GFX_MINIMAP_TILESET:Class;
		[Embed(source = '../assets/gfx/main_menu/bg.png')]
		public static const	GFX_MAIN_MENU_BG:Class;
		[Embed(source = '../assets/gfx/main_menu/start_prompt.png')]
		public static const	GFX_MAIN_MENU_START_PROMPT:Class;
		[Embed(source = '../assets/gfx/main_menu/title.png')]
		public static const	GFX_MAIN_MENU_TITLE:Class;
		[Embed(source = '../assets/gfx/main_menu/ng_tank.png')]
		public static const GFX_MAIN_MENU_NG_TANK:Class;
		[Embed(source = '../assets/gfx/message/message.png')]
		public static const	GFX_MESSAGE:Class;
		[Embed(source = '../assets/gfx/message/mini_message.png')]
		public static const	GFX_MINI_MESSAGE:Class;
		[Embed(source = '../assets/gfx/respawn.png')]
		public static const GFX_RESPAWN:Class;
		[Embed(source = '../assets/gfx/platform.png')]
		public static const GFX_PLATFORM:Class;
		[Embed(source = '../assets/gfx/hazards/spikes.png')]
		public static const GFX_SPIKES:Class;
		[Embed(source = '../assets/gfx/hazards/electric_gate.png')]
		public static const GFX_ELECTRIC_GATE:Class;
		[Embed(source = '../assets/gfx/grav_lift.png')]
		public static const GFX_GRAVLIFT:Class;
		
		/*
		* MAP FILES
		* */
		[Embed(source = '../map/h5.oel', mimeType = 'application/octet-stream')] public static const h5:Class;
		[Embed(source = '../map/h6.oel', mimeType = 'application/octet-stream')] public static const h6:Class;
		[Embed(source = '../map/h7.oel', mimeType = 'application/octet-stream')] public static const h7:Class;
		[Embed(source = '../map/h8.oel', mimeType = 'application/octet-stream')] public static const h8:Class;
	}
	
}