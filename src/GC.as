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
		public static const	FRICTION:Number			= 1800;
		public static const	DRAG:Number				= 100;
		
		/*
		 * PLAYER CONSTANTS
		 * */
		public static const	START_TILE:String 			= 'd9';		
		public static const	MAX_H_SPEED:Number			= 300;
		public static const	MAX_V_SPEED:Number			= 600;
		public static const	MOVE_SPEED:Number			= 2000;
		public static const	JUMP_SPEED:Number			= -340;
		public static const	DBL_JUMP_SPEED:Number		= -295;
		public static const	DBL_JUMP_LIMIT:Number		= 300;
		public static const	LEAP:Number					= 1.5;
		public static const AIR_DRAG:Number				= 0.35;
		
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
		Input.define("PauseMenu", Key.ENTER);
		Input.define('Jump', Key.SPACE, Key.UP);
		Input.define('Left', Key.LEFT);
		Input.define('Right', Key.RIGHT);
		Input.define('Shoot', Key.Z);
			
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
		[Embed(source = '../assets/gfx/tileset_door.png')]
		public static const GFX_DOOR_TILESET:Class;
		[Embed(source = '../assets/gfx/tileset_doorH.png')]
		public static const GFX_DOORH_TILESET:Class;
		[Embed(source = '../assets/gfx/cursor_menu.png')]
		public static const GFX_CURSOR_MENU:Class;
		[Embed(source='../assets/gfx/reticle1.png')]
		public static const	GFX_RETICLE1:Class;
		[Embed(source = '../assets/gfx/pause_menu.png')]
		public static const	GFX_PAUSE_MENU:Class;
		[Embed(source = '../assets/gfx/minimap/tileset.png')]
		public static const	GFX_MINIMAP_TILESET:Class;
		[Embed(source = '../assets/gfx/main_menu/main_menu_bg.png')]
		public static const	GFX_MAIN_MENU_BG:Class;
		[Embed(source = '../assets/gfx/main_menu/instructions_normal.png')]
		public static const	GFX_INSTRUCTIONS_NORMAL:Class;
		[Embed(source = '../assets/gfx/main_menu/options_normal.png')]
		public static const	GFX_OPTIONS_NORMAL:Class;
		[Embed(source = '../assets/gfx/main_menu/start_normal.png')]
		public static const	GFX_START_NORMAL:Class;
		[Embed(source = '../assets/gfx/main_menu/title.png')]
		public static const	GFX_TITLE:Class;
		[Embed(source = '../assets/gfx/message/message.png')]
		public static const	GFX_MESSAGE:Class;
		
		/*
		* MAP FILES
		* */
		[Embed(source = '../map/a0.oel', mimeType = 'application/octet-stream')]
        public static const a0:Class;
        [Embed(source = '../map/a1.oel', mimeType = 'application/octet-stream')]
        public static const a1:Class;
        [Embed(source = '../map/a2.oel', mimeType = 'application/octet-stream')]
        public static const a2:Class;
        [Embed(source = '../map/a3.oel', mimeType = 'application/octet-stream')]
        public static const a3:Class;
        [Embed(source = '../map/a4.oel', mimeType = 'application/octet-stream')]
        public static const a4:Class;
        [Embed(source = '../map/a5.oel', mimeType = 'application/octet-stream')]
        public static const a5:Class;
        [Embed(source = '../map/a6.oel', mimeType = 'application/octet-stream')]
        public static const a6:Class;
        [Embed(source = '../map/a7.oel', mimeType = 'application/octet-stream')]
        public static const a7:Class;
        [Embed(source = '../map/a8.oel', mimeType = 'application/octet-stream')]
        public static const a8:Class;
        [Embed(source = '../map/a9.oel', mimeType = 'application/octet-stream')]
        public static const a9:Class;
        [Embed(source = '../map/a10.oel', mimeType = 'application/octet-stream')]
        public static const a10:Class;
        [Embed(source = '../map/a11.oel', mimeType = 'application/octet-stream')]
        public static const a11:Class;
        [Embed(source = '../map/a12.oel', mimeType = 'application/octet-stream')]
        public static const a12:Class;
        [Embed(source = '../map/a13.oel', mimeType = 'application/octet-stream')]
        public static const a13:Class;
        [Embed(source = '../map/a14.oel', mimeType = 'application/octet-stream')]
        public static const a14:Class;
        [Embed(source = '../map/a15.oel', mimeType = 'application/octet-stream')]
        public static const a15:Class;
        [Embed(source = '../map/a16.oel', mimeType = 'application/octet-stream')]
        public static const a16:Class;
        [Embed(source = '../map/a17.oel', mimeType = 'application/octet-stream')]
        public static const a17:Class;
        [Embed(source = '../map/a18.oel', mimeType = 'application/octet-stream')]
        public static const a18:Class;
        [Embed(source = '../map/a19.oel', mimeType = 'application/octet-stream')]
        public static const a19:Class;
        [Embed(source = '../map/b0.oel', mimeType = 'application/octet-stream')]
        public static const b0:Class;
        [Embed(source = '../map/b1.oel', mimeType = 'application/octet-stream')]
        public static const b1:Class;
        [Embed(source = '../map/b2.oel', mimeType = 'application/octet-stream')]
        public static const b2:Class;
        [Embed(source = '../map/b3.oel', mimeType = 'application/octet-stream')]
        public static const b3:Class;
        [Embed(source = '../map/b4.oel', mimeType = 'application/octet-stream')]
        public static const b4:Class;
        [Embed(source = '../map/b5.oel', mimeType = 'application/octet-stream')]
        public static const b5:Class;
        [Embed(source = '../map/b6.oel', mimeType = 'application/octet-stream')]
        public static const b6:Class;
        [Embed(source = '../map/b7.oel', mimeType = 'application/octet-stream')]
        public static const b7:Class;
        [Embed(source = '../map/b8.oel', mimeType = 'application/octet-stream')]
        public static const b8:Class;
        [Embed(source = '../map/b9.oel', mimeType = 'application/octet-stream')]
        public static const b9:Class;
        [Embed(source = '../map/b10.oel', mimeType = 'application/octet-stream')]
        public static const b10:Class;
        [Embed(source = '../map/b11.oel', mimeType = 'application/octet-stream')]
        public static const b11:Class;
        [Embed(source = '../map/b12.oel', mimeType = 'application/octet-stream')]
        public static const b12:Class;
        [Embed(source = '../map/b13.oel', mimeType = 'application/octet-stream')]
        public static const b13:Class;
        [Embed(source = '../map/b14.oel', mimeType = 'application/octet-stream')]
        public static const b14:Class;
        [Embed(source = '../map/b15.oel', mimeType = 'application/octet-stream')]
        public static const b15:Class;
        [Embed(source = '../map/b16.oel', mimeType = 'application/octet-stream')]
        public static const b16:Class;
        [Embed(source = '../map/b17.oel', mimeType = 'application/octet-stream')]
        public static const b17:Class;
        [Embed(source = '../map/b18.oel', mimeType = 'application/octet-stream')]
        public static const b18:Class;
        [Embed(source = '../map/b19.oel', mimeType = 'application/octet-stream')]
        public static const b19:Class;
        [Embed(source = '../map/c0.oel', mimeType = 'application/octet-stream')]
        public static const c0:Class;
        [Embed(source = '../map/c1.oel', mimeType = 'application/octet-stream')]
        public static const c1:Class;
        [Embed(source = '../map/c2.oel', mimeType = 'application/octet-stream')]
        public static const c2:Class;
        [Embed(source = '../map/c3.oel', mimeType = 'application/octet-stream')]
        public static const c3:Class;
        [Embed(source = '../map/c4.oel', mimeType = 'application/octet-stream')]
        public static const c4:Class;
        [Embed(source = '../map/c5.oel', mimeType = 'application/octet-stream')]
        public static const c5:Class;
        [Embed(source = '../map/c6.oel', mimeType = 'application/octet-stream')]
        public static const c6:Class;
        [Embed(source = '../map/c7.oel', mimeType = 'application/octet-stream')]
        public static const c7:Class;
        [Embed(source = '../map/c8.oel', mimeType = 'application/octet-stream')]
        public static const c8:Class;
        [Embed(source = '../map/c9.oel', mimeType = 'application/octet-stream')]
        public static const c9:Class;
        [Embed(source = '../map/c10.oel', mimeType = 'application/octet-stream')]
        public static const c10:Class;
        [Embed(source = '../map/c11.oel', mimeType = 'application/octet-stream')]
        public static const c11:Class;
        [Embed(source = '../map/c12.oel', mimeType = 'application/octet-stream')]
        public static const c12:Class;
        [Embed(source = '../map/c13.oel', mimeType = 'application/octet-stream')]
        public static const c13:Class;
        [Embed(source = '../map/c14.oel', mimeType = 'application/octet-stream')]
        public static const c14:Class;
        [Embed(source = '../map/c15.oel', mimeType = 'application/octet-stream')]
        public static const c15:Class;
        [Embed(source = '../map/c16.oel', mimeType = 'application/octet-stream')]
        public static const c16:Class;
        [Embed(source = '../map/c17.oel', mimeType = 'application/octet-stream')]
        public static const c17:Class;
        [Embed(source = '../map/c18.oel', mimeType = 'application/octet-stream')]
        public static const c18:Class;
        [Embed(source = '../map/c19.oel', mimeType = 'application/octet-stream')]
        public static const c19:Class;
        [Embed(source = '../map/d0.oel', mimeType = 'application/octet-stream')]
        public static const d0:Class;
        [Embed(source = '../map/d1.oel', mimeType = 'application/octet-stream')]
        public static const d1:Class;
        [Embed(source = '../map/d2.oel', mimeType = 'application/octet-stream')]
        public static const d2:Class;
        [Embed(source = '../map/d3.oel', mimeType = 'application/octet-stream')]
        public static const d3:Class;
        [Embed(source = '../map/d4.oel', mimeType = 'application/octet-stream')]
        public static const d4:Class;
        [Embed(source = '../map/d5.oel', mimeType = 'application/octet-stream')]
        public static const d5:Class;
        [Embed(source = '../map/d6.oel', mimeType = 'application/octet-stream')]
        public static const d6:Class;
        [Embed(source = '../map/d7.oel', mimeType = 'application/octet-stream')]
        public static const d7:Class;
        [Embed(source = '../map/d8.oel', mimeType = 'application/octet-stream')]
        public static const d8:Class;
        [Embed(source = '../map/d9.oel', mimeType = 'application/octet-stream')]
        public static const d9:Class;
        [Embed(source = '../map/d10.oel', mimeType = 'application/octet-stream')]
        public static const d10:Class;
        [Embed(source = '../map/d11.oel', mimeType = 'application/octet-stream')]
        public static const d11:Class;
        [Embed(source = '../map/d12.oel', mimeType = 'application/octet-stream')]
        public static const d12:Class;
        [Embed(source = '../map/d13.oel', mimeType = 'application/octet-stream')]
        public static const d13:Class;
        [Embed(source = '../map/d14.oel', mimeType = 'application/octet-stream')]
        public static const d14:Class;
        [Embed(source = '../map/d15.oel', mimeType = 'application/octet-stream')]
        public static const d15:Class;
        [Embed(source = '../map/d16.oel', mimeType = 'application/octet-stream')]
        public static const d16:Class;
        [Embed(source = '../map/d17.oel', mimeType = 'application/octet-stream')]
        public static const d17:Class;
        [Embed(source = '../map/d18.oel', mimeType = 'application/octet-stream')]
        public static const d18:Class;
        [Embed(source = '../map/d19.oel', mimeType = 'application/octet-stream')]
        public static const d19:Class;
        [Embed(source = '../map/e0.oel', mimeType = 'application/octet-stream')]
        public static const e0:Class;
        [Embed(source = '../map/e1.oel', mimeType = 'application/octet-stream')]
        public static const e1:Class;
        [Embed(source = '../map/e2.oel', mimeType = 'application/octet-stream')]
        public static const e2:Class;
        [Embed(source = '../map/e3.oel', mimeType = 'application/octet-stream')]
        public static const e3:Class;
        [Embed(source = '../map/e4.oel', mimeType = 'application/octet-stream')]
        public static const e4:Class;
        [Embed(source = '../map/e5.oel', mimeType = 'application/octet-stream')]
        public static const e5:Class;
        [Embed(source = '../map/e6.oel', mimeType = 'application/octet-stream')]
        public static const e6:Class;
        [Embed(source = '../map/e7.oel', mimeType = 'application/octet-stream')]
        public static const e7:Class;
        [Embed(source = '../map/e8.oel', mimeType = 'application/octet-stream')]
        public static const e8:Class;
        [Embed(source = '../map/e9.oel', mimeType = 'application/octet-stream')]
        public static const e9:Class;
        [Embed(source = '../map/e10.oel', mimeType = 'application/octet-stream')]
        public static const e10:Class;
        [Embed(source = '../map/e11.oel', mimeType = 'application/octet-stream')]
        public static const e11:Class;
        [Embed(source = '../map/e12.oel', mimeType = 'application/octet-stream')]
        public static const e12:Class;
        [Embed(source = '../map/e13.oel', mimeType = 'application/octet-stream')]
        public static const e13:Class;
        [Embed(source = '../map/e14.oel', mimeType = 'application/octet-stream')]
        public static const e14:Class;
        [Embed(source = '../map/e15.oel', mimeType = 'application/octet-stream')]
        public static const e15:Class;
        [Embed(source = '../map/e16.oel', mimeType = 'application/octet-stream')]
        public static const e16:Class;
        [Embed(source = '../map/e17.oel', mimeType = 'application/octet-stream')]
        public static const e17:Class;
        [Embed(source = '../map/e18.oel', mimeType = 'application/octet-stream')]
        public static const e18:Class;
        [Embed(source = '../map/e19.oel', mimeType = 'application/octet-stream')]
        public static const e19:Class;
        [Embed(source = '../map/f0.oel', mimeType = 'application/octet-stream')]
        public static const f0:Class;
        [Embed(source = '../map/f1.oel', mimeType = 'application/octet-stream')]
        public static const f1:Class;
        [Embed(source = '../map/f2.oel', mimeType = 'application/octet-stream')]
        public static const f2:Class;
        [Embed(source = '../map/f3.oel', mimeType = 'application/octet-stream')]
        public static const f3:Class;
        [Embed(source = '../map/f4.oel', mimeType = 'application/octet-stream')]
        public static const f4:Class;
        [Embed(source = '../map/f5.oel', mimeType = 'application/octet-stream')]
        public static const f5:Class;
        [Embed(source = '../map/f6.oel', mimeType = 'application/octet-stream')]
        public static const f6:Class;
        [Embed(source = '../map/f7.oel', mimeType = 'application/octet-stream')]
        public static const f7:Class;
        [Embed(source = '../map/f8.oel', mimeType = 'application/octet-stream')]
        public static const f8:Class;
        [Embed(source = '../map/f9.oel', mimeType = 'application/octet-stream')]
        public static const f9:Class;
        [Embed(source = '../map/f10.oel', mimeType = 'application/octet-stream')]
        public static const f10:Class;
        [Embed(source = '../map/f11.oel', mimeType = 'application/octet-stream')]
        public static const f11:Class;
        [Embed(source = '../map/f12.oel', mimeType = 'application/octet-stream')]
        public static const f12:Class;
        [Embed(source = '../map/f13.oel', mimeType = 'application/octet-stream')]
        public static const f13:Class;
        [Embed(source = '../map/f14.oel', mimeType = 'application/octet-stream')]
        public static const f14:Class;
        [Embed(source = '../map/f15.oel', mimeType = 'application/octet-stream')]
        public static const f15:Class;
        [Embed(source = '../map/f16.oel', mimeType = 'application/octet-stream')]
        public static const f16:Class;
        [Embed(source = '../map/f17.oel', mimeType = 'application/octet-stream')]
        public static const f17:Class;
        [Embed(source = '../map/f18.oel', mimeType = 'application/octet-stream')]
        public static const f18:Class;
        [Embed(source = '../map/f19.oel', mimeType = 'application/octet-stream')]
        public static const f19:Class;
        [Embed(source = '../map/g0.oel', mimeType = 'application/octet-stream')]
        public static const g0:Class;
        [Embed(source = '../map/g1.oel', mimeType = 'application/octet-stream')]
        public static const g1:Class;
        [Embed(source = '../map/g2.oel', mimeType = 'application/octet-stream')]
        public static const g2:Class;
        [Embed(source = '../map/g3.oel', mimeType = 'application/octet-stream')]
        public static const g3:Class;
        [Embed(source = '../map/g4.oel', mimeType = 'application/octet-stream')]
        public static const g4:Class;
        [Embed(source = '../map/g5.oel', mimeType = 'application/octet-stream')]
        public static const g5:Class;
        [Embed(source = '../map/g6.oel', mimeType = 'application/octet-stream')]
        public static const g6:Class;
        [Embed(source = '../map/g7.oel', mimeType = 'application/octet-stream')]
        public static const g7:Class;
        [Embed(source = '../map/g8.oel', mimeType = 'application/octet-stream')]
        public static const g8:Class;
        [Embed(source = '../map/g9.oel', mimeType = 'application/octet-stream')]
        public static const g9:Class;
        [Embed(source = '../map/g10.oel', mimeType = 'application/octet-stream')]
        public static const g10:Class;
        [Embed(source = '../map/g11.oel', mimeType = 'application/octet-stream')]
        public static const g11:Class;
        [Embed(source = '../map/g12.oel', mimeType = 'application/octet-stream')]
        public static const g12:Class;
        [Embed(source = '../map/g13.oel', mimeType = 'application/octet-stream')]
        public static const g13:Class;
        [Embed(source = '../map/g14.oel', mimeType = 'application/octet-stream')]
        public static const g14:Class;
        [Embed(source = '../map/g15.oel', mimeType = 'application/octet-stream')]
        public static const g15:Class;
        [Embed(source = '../map/g16.oel', mimeType = 'application/octet-stream')]
        public static const g16:Class;
        [Embed(source = '../map/g17.oel', mimeType = 'application/octet-stream')]
        public static const g17:Class;
        [Embed(source = '../map/g18.oel', mimeType = 'application/octet-stream')]
        public static const g18:Class;
        [Embed(source = '../map/g19.oel', mimeType = 'application/octet-stream')]
        public static const g19:Class;
        [Embed(source = '../map/h0.oel', mimeType = 'application/octet-stream')]
        public static const h0:Class;
        [Embed(source = '../map/h1.oel', mimeType = 'application/octet-stream')]
        public static const h1:Class;
        [Embed(source = '../map/h2.oel', mimeType = 'application/octet-stream')]
        public static const h2:Class;
        [Embed(source = '../map/h3.oel', mimeType = 'application/octet-stream')]
        public static const h3:Class;
        [Embed(source = '../map/h4.oel', mimeType = 'application/octet-stream')]
        public static const h4:Class;
        [Embed(source = '../map/h5.oel', mimeType = 'application/octet-stream')]
        public static const h5:Class;
        [Embed(source = '../map/h6.oel', mimeType = 'application/octet-stream')]
        public static const h6:Class;
        [Embed(source = '../map/h7.oel', mimeType = 'application/octet-stream')]
        public static const h7:Class;
        [Embed(source = '../map/h8.oel', mimeType = 'application/octet-stream')]
        public static const h8:Class;
        [Embed(source = '../map/h9.oel', mimeType = 'application/octet-stream')]
        public static const h9:Class;
        [Embed(source = '../map/h10.oel', mimeType = 'application/octet-stream')]
        public static const h10:Class;
        [Embed(source = '../map/h11.oel', mimeType = 'application/octet-stream')]
        public static const h11:Class;
        [Embed(source = '../map/h12.oel', mimeType = 'application/octet-stream')]
        public static const h12:Class;
        [Embed(source = '../map/h13.oel', mimeType = 'application/octet-stream')]
        public static const h13:Class;
        [Embed(source = '../map/h14.oel', mimeType = 'application/octet-stream')]
        public static const h14:Class;
        [Embed(source = '../map/h15.oel', mimeType = 'application/octet-stream')]
        public static const h15:Class;
        [Embed(source = '../map/h16.oel', mimeType = 'application/octet-stream')]
        public static const h16:Class;
        [Embed(source = '../map/h17.oel', mimeType = 'application/octet-stream')]
        public static const h17:Class;
        [Embed(source = '../map/h18.oel', mimeType = 'application/octet-stream')]
        public static const h18:Class;
        [Embed(source = '../map/h19.oel', mimeType = 'application/octet-stream')]
        public static const h19:Class;
        [Embed(source = '../map/i0.oel', mimeType = 'application/octet-stream')]
        public static const i0:Class;
        [Embed(source = '../map/i1.oel', mimeType = 'application/octet-stream')]
        public static const i1:Class;
        [Embed(source = '../map/i2.oel', mimeType = 'application/octet-stream')]
        public static const i2:Class;
        [Embed(source = '../map/i3.oel', mimeType = 'application/octet-stream')]
        public static const i3:Class;
        [Embed(source = '../map/i4.oel', mimeType = 'application/octet-stream')]
        public static const i4:Class;
        [Embed(source = '../map/i5.oel', mimeType = 'application/octet-stream')]
        public static const i5:Class;
        [Embed(source = '../map/i6.oel', mimeType = 'application/octet-stream')]
        public static const i6:Class;
        [Embed(source = '../map/i7.oel', mimeType = 'application/octet-stream')]
        public static const i7:Class;
        [Embed(source = '../map/i8.oel', mimeType = 'application/octet-stream')]
        public static const i8:Class;
        [Embed(source = '../map/i9.oel', mimeType = 'application/octet-stream')]
        public static const i9:Class;
        [Embed(source = '../map/i10.oel', mimeType = 'application/octet-stream')]
        public static const i10:Class;
        [Embed(source = '../map/i11.oel', mimeType = 'application/octet-stream')]
        public static const i11:Class;
        [Embed(source = '../map/i12.oel', mimeType = 'application/octet-stream')]
        public static const i12:Class;
        [Embed(source = '../map/i13.oel', mimeType = 'application/octet-stream')]
        public static const i13:Class;
        [Embed(source = '../map/i14.oel', mimeType = 'application/octet-stream')]
        public static const i14:Class;
        [Embed(source = '../map/i15.oel', mimeType = 'application/octet-stream')]
        public static const i15:Class;
        [Embed(source = '../map/i16.oel', mimeType = 'application/octet-stream')]
        public static const i16:Class;
        [Embed(source = '../map/i17.oel', mimeType = 'application/octet-stream')]
        public static const i17:Class;
        [Embed(source = '../map/i18.oel', mimeType = 'application/octet-stream')]
        public static const i18:Class;
        [Embed(source = '../map/i19.oel', mimeType = 'application/octet-stream')]
        public static const i19:Class;
        [Embed(source = '../map/j0.oel', mimeType = 'application/octet-stream')]
        public static const j0:Class;
        [Embed(source = '../map/j1.oel', mimeType = 'application/octet-stream')]
        public static const j1:Class;
        [Embed(source = '../map/j2.oel', mimeType = 'application/octet-stream')]
        public static const j2:Class;
        [Embed(source = '../map/j3.oel', mimeType = 'application/octet-stream')]
        public static const j3:Class;
        [Embed(source = '../map/j4.oel', mimeType = 'application/octet-stream')]
        public static const j4:Class;
        [Embed(source = '../map/j5.oel', mimeType = 'application/octet-stream')]
        public static const j5:Class;
        [Embed(source = '../map/j6.oel', mimeType = 'application/octet-stream')]
        public static const j6:Class;
        [Embed(source = '../map/j7.oel', mimeType = 'application/octet-stream')]
        public static const j7:Class;
        [Embed(source = '../map/j8.oel', mimeType = 'application/octet-stream')]
        public static const j8:Class;
        [Embed(source = '../map/j9.oel', mimeType = 'application/octet-stream')]
        public static const j9:Class;
        [Embed(source = '../map/j10.oel', mimeType = 'application/octet-stream')]
        public static const j10:Class;
        [Embed(source = '../map/j11.oel', mimeType = 'application/octet-stream')]
        public static const j11:Class;
        [Embed(source = '../map/j12.oel', mimeType = 'application/octet-stream')]
        public static const j12:Class;
        [Embed(source = '../map/j13.oel', mimeType = 'application/octet-stream')]
        public static const j13:Class;
        [Embed(source = '../map/j14.oel', mimeType = 'application/octet-stream')]
        public static const j14:Class;
        [Embed(source = '../map/j15.oel', mimeType = 'application/octet-stream')]
        public static const j15:Class;
        [Embed(source = '../map/j16.oel', mimeType = 'application/octet-stream')]
        public static const j16:Class;
        [Embed(source = '../map/j17.oel', mimeType = 'application/octet-stream')]
        public static const j17:Class;
        [Embed(source = '../map/j18.oel', mimeType = 'application/octet-stream')]
        public static const j18:Class;
        [Embed(source = '../map/j19.oel', mimeType = 'application/octet-stream')]
        public static const j19:Class;
        [Embed(source = '../map/k0.oel', mimeType = 'application/octet-stream')]
        public static const k0:Class;
        [Embed(source = '../map/k1.oel', mimeType = 'application/octet-stream')]
        public static const k1:Class;
        [Embed(source = '../map/k2.oel', mimeType = 'application/octet-stream')]
        public static const k2:Class;
        [Embed(source = '../map/k3.oel', mimeType = 'application/octet-stream')]
        public static const k3:Class;
        [Embed(source = '../map/k4.oel', mimeType = 'application/octet-stream')]
        public static const k4:Class;
        [Embed(source = '../map/k5.oel', mimeType = 'application/octet-stream')]
        public static const k5:Class;
        [Embed(source = '../map/k6.oel', mimeType = 'application/octet-stream')]
        public static const k6:Class;
        [Embed(source = '../map/k7.oel', mimeType = 'application/octet-stream')]
        public static const k7:Class;
        [Embed(source = '../map/k8.oel', mimeType = 'application/octet-stream')]
        public static const k8:Class;
        [Embed(source = '../map/k9.oel', mimeType = 'application/octet-stream')]
        public static const k9:Class;
        [Embed(source = '../map/k10.oel', mimeType = 'application/octet-stream')]
        public static const k10:Class;
        [Embed(source = '../map/k11.oel', mimeType = 'application/octet-stream')]
        public static const k11:Class;
        [Embed(source = '../map/k12.oel', mimeType = 'application/octet-stream')]
        public static const k12:Class;
        [Embed(source = '../map/k13.oel', mimeType = 'application/octet-stream')]
        public static const k13:Class;
        [Embed(source = '../map/k14.oel', mimeType = 'application/octet-stream')]
        public static const k14:Class;
        [Embed(source = '../map/k15.oel', mimeType = 'application/octet-stream')]
        public static const k15:Class;
        [Embed(source = '../map/k16.oel', mimeType = 'application/octet-stream')]
        public static const k16:Class;
        [Embed(source = '../map/k17.oel', mimeType = 'application/octet-stream')]
        public static const k17:Class;
        [Embed(source = '../map/k18.oel', mimeType = 'application/octet-stream')]
        public static const k18:Class;
        [Embed(source = '../map/k19.oel', mimeType = 'application/octet-stream')]
        public static const k19:Class;
        [Embed(source = '../map/l0.oel', mimeType = 'application/octet-stream')]
        public static const l0:Class;
        [Embed(source = '../map/l1.oel', mimeType = 'application/octet-stream')]
        public static const l1:Class;
        [Embed(source = '../map/l2.oel', mimeType = 'application/octet-stream')]
        public static const l2:Class;
        [Embed(source = '../map/l3.oel', mimeType = 'application/octet-stream')]
        public static const l3:Class;
        [Embed(source = '../map/l4.oel', mimeType = 'application/octet-stream')]
        public static const l4:Class;
        [Embed(source = '../map/l5.oel', mimeType = 'application/octet-stream')]
        public static const l5:Class;
        [Embed(source = '../map/l6.oel', mimeType = 'application/octet-stream')]
        public static const l6:Class;
        [Embed(source = '../map/l7.oel', mimeType = 'application/octet-stream')]
        public static const l7:Class;
        [Embed(source = '../map/l8.oel', mimeType = 'application/octet-stream')]
        public static const l8:Class;
        [Embed(source = '../map/l9.oel', mimeType = 'application/octet-stream')]
        public static const l9:Class;
        [Embed(source = '../map/l10.oel', mimeType = 'application/octet-stream')]
        public static const l10:Class;
        [Embed(source = '../map/l11.oel', mimeType = 'application/octet-stream')]
        public static const l11:Class;
        [Embed(source = '../map/l12.oel', mimeType = 'application/octet-stream')]
        public static const l12:Class;
        [Embed(source = '../map/l13.oel', mimeType = 'application/octet-stream')]
        public static const l13:Class;
        [Embed(source = '../map/l14.oel', mimeType = 'application/octet-stream')]
        public static const l14:Class;
        [Embed(source = '../map/l15.oel', mimeType = 'application/octet-stream')]
        public static const l15:Class;
        [Embed(source = '../map/l16.oel', mimeType = 'application/octet-stream')]
        public static const l16:Class;
        [Embed(source = '../map/l17.oel', mimeType = 'application/octet-stream')]
        public static const l17:Class;
        [Embed(source = '../map/l18.oel', mimeType = 'application/octet-stream')]
        public static const l18:Class;
        [Embed(source = '../map/l19.oel', mimeType = 'application/octet-stream')]
        public static const l19:Class;
        [Embed(source = '../map/m0.oel', mimeType = 'application/octet-stream')]
        public static const m0:Class;
        [Embed(source = '../map/m1.oel', mimeType = 'application/octet-stream')]
        public static const m1:Class;
        [Embed(source = '../map/m2.oel', mimeType = 'application/octet-stream')]
        public static const m2:Class;
        [Embed(source = '../map/m3.oel', mimeType = 'application/octet-stream')]
        public static const m3:Class;
        [Embed(source = '../map/m4.oel', mimeType = 'application/octet-stream')]
        public static const m4:Class;
        [Embed(source = '../map/m5.oel', mimeType = 'application/octet-stream')]
        public static const m5:Class;
        [Embed(source = '../map/m6.oel', mimeType = 'application/octet-stream')]
        public static const m6:Class;
        [Embed(source = '../map/m7.oel', mimeType = 'application/octet-stream')]
        public static const m7:Class;
        [Embed(source = '../map/m8.oel', mimeType = 'application/octet-stream')]
        public static const m8:Class;
        [Embed(source = '../map/m9.oel', mimeType = 'application/octet-stream')]
        public static const m9:Class;
        [Embed(source = '../map/m10.oel', mimeType = 'application/octet-stream')]
        public static const m10:Class;
        [Embed(source = '../map/m11.oel', mimeType = 'application/octet-stream')]
        public static const m11:Class;
        [Embed(source = '../map/m12.oel', mimeType = 'application/octet-stream')]
        public static const m12:Class;
        [Embed(source = '../map/m13.oel', mimeType = 'application/octet-stream')]
        public static const m13:Class;
        [Embed(source = '../map/m14.oel', mimeType = 'application/octet-stream')]
        public static const m14:Class;
        [Embed(source = '../map/m15.oel', mimeType = 'application/octet-stream')]
        public static const m15:Class;
        [Embed(source = '../map/m16.oel', mimeType = 'application/octet-stream')]
        public static const m16:Class;
        [Embed(source = '../map/m17.oel', mimeType = 'application/octet-stream')]
        public static const m17:Class;
        [Embed(source = '../map/m18.oel', mimeType = 'application/octet-stream')]
        public static const m18:Class;
        [Embed(source = '../map/m19.oel', mimeType = 'application/octet-stream')]
        public static const m19:Class;
        [Embed(source = '../map/n0.oel', mimeType = 'application/octet-stream')]
        public static const n0:Class;
        [Embed(source = '../map/n1.oel', mimeType = 'application/octet-stream')]
        public static const n1:Class;
        [Embed(source = '../map/n2.oel', mimeType = 'application/octet-stream')]
        public static const n2:Class;
        [Embed(source = '../map/n3.oel', mimeType = 'application/octet-stream')]
        public static const n3:Class;
        [Embed(source = '../map/n4.oel', mimeType = 'application/octet-stream')]
        public static const n4:Class;
        [Embed(source = '../map/n5.oel', mimeType = 'application/octet-stream')]
        public static const n5:Class;
        [Embed(source = '../map/n6.oel', mimeType = 'application/octet-stream')]
        public static const n6:Class;
        [Embed(source = '../map/n7.oel', mimeType = 'application/octet-stream')]
        public static const n7:Class;
        [Embed(source = '../map/n8.oel', mimeType = 'application/octet-stream')]
        public static const n8:Class;
        [Embed(source = '../map/n9.oel', mimeType = 'application/octet-stream')]
        public static const n9:Class;
        [Embed(source = '../map/n10.oel', mimeType = 'application/octet-stream')]
        public static const n10:Class;
        [Embed(source = '../map/n11.oel', mimeType = 'application/octet-stream')]
        public static const n11:Class;
        [Embed(source = '../map/n12.oel', mimeType = 'application/octet-stream')]
        public static const n12:Class;
        [Embed(source = '../map/n13.oel', mimeType = 'application/octet-stream')]
        public static const n13:Class;
        [Embed(source = '../map/n14.oel', mimeType = 'application/octet-stream')]
        public static const n14:Class;
        [Embed(source = '../map/n15.oel', mimeType = 'application/octet-stream')]
        public static const n15:Class;
        [Embed(source = '../map/n16.oel', mimeType = 'application/octet-stream')]
        public static const n16:Class;
        [Embed(source = '../map/n17.oel', mimeType = 'application/octet-stream')]
        public static const n17:Class;
        [Embed(source = '../map/n18.oel', mimeType = 'application/octet-stream')]
        public static const n18:Class;
        [Embed(source = '../map/n19.oel', mimeType = 'application/octet-stream')]
        public static const n19:Class;
        [Embed(source = '../map/o0.oel', mimeType = 'application/octet-stream')]
        public static const o0:Class;
        [Embed(source = '../map/o1.oel', mimeType = 'application/octet-stream')]
        public static const o1:Class;
        [Embed(source = '../map/o2.oel', mimeType = 'application/octet-stream')]
        public static const o2:Class;
        [Embed(source = '../map/o3.oel', mimeType = 'application/octet-stream')]
        public static const o3:Class;
        [Embed(source = '../map/o4.oel', mimeType = 'application/octet-stream')]
        public static const o4:Class;
        [Embed(source = '../map/o5.oel', mimeType = 'application/octet-stream')]
        public static const o5:Class;
        [Embed(source = '../map/o6.oel', mimeType = 'application/octet-stream')]
        public static const o6:Class;
        [Embed(source = '../map/o7.oel', mimeType = 'application/octet-stream')]
        public static const o7:Class;
        [Embed(source = '../map/o8.oel', mimeType = 'application/octet-stream')]
        public static const o8:Class;
        [Embed(source = '../map/o9.oel', mimeType = 'application/octet-stream')]
        public static const o9:Class;
        [Embed(source = '../map/o10.oel', mimeType = 'application/octet-stream')]
        public static const o10:Class;
        [Embed(source = '../map/o11.oel', mimeType = 'application/octet-stream')]
        public static const o11:Class;
        [Embed(source = '../map/o12.oel', mimeType = 'application/octet-stream')]
        public static const o12:Class;
        [Embed(source = '../map/o13.oel', mimeType = 'application/octet-stream')]
        public static const o13:Class;
        [Embed(source = '../map/o14.oel', mimeType = 'application/octet-stream')]
        public static const o14:Class;
        [Embed(source = '../map/o15.oel', mimeType = 'application/octet-stream')]
        public static const o15:Class;
        [Embed(source = '../map/o16.oel', mimeType = 'application/octet-stream')]
        public static const o16:Class;
        [Embed(source = '../map/o17.oel', mimeType = 'application/octet-stream')]
        public static const o17:Class;
        [Embed(source = '../map/o18.oel', mimeType = 'application/octet-stream')]
        public static const o18:Class;
        [Embed(source = '../map/o19.oel', mimeType = 'application/octet-stream')]
        public static const o19:Class;
        [Embed(source = '../map/p0.oel', mimeType = 'application/octet-stream')]
        public static const p0:Class;
        [Embed(source = '../map/p1.oel', mimeType = 'application/octet-stream')]
        public static const p1:Class;
        [Embed(source = '../map/p2.oel', mimeType = 'application/octet-stream')]
        public static const p2:Class;
        [Embed(source = '../map/p3.oel', mimeType = 'application/octet-stream')]
        public static const p3:Class;
        [Embed(source = '../map/p4.oel', mimeType = 'application/octet-stream')]
        public static const p4:Class;
        [Embed(source = '../map/p5.oel', mimeType = 'application/octet-stream')]
        public static const p5:Class;
        [Embed(source = '../map/p6.oel', mimeType = 'application/octet-stream')]
        public static const p6:Class;
        [Embed(source = '../map/p7.oel', mimeType = 'application/octet-stream')]
        public static const p7:Class;
        [Embed(source = '../map/p8.oel', mimeType = 'application/octet-stream')]
        public static const p8:Class;
        [Embed(source = '../map/p9.oel', mimeType = 'application/octet-stream')]
        public static const p9:Class;
        [Embed(source = '../map/p10.oel', mimeType = 'application/octet-stream')]
        public static const p10:Class;
        [Embed(source = '../map/p11.oel', mimeType = 'application/octet-stream')]
        public static const p11:Class;
        [Embed(source = '../map/p12.oel', mimeType = 'application/octet-stream')]
        public static const p12:Class;
        [Embed(source = '../map/p13.oel', mimeType = 'application/octet-stream')]
        public static const p13:Class;
        [Embed(source = '../map/p14.oel', mimeType = 'application/octet-stream')]
        public static const p14:Class;
        [Embed(source = '../map/p15.oel', mimeType = 'application/octet-stream')]
        public static const p15:Class;
        [Embed(source = '../map/p16.oel', mimeType = 'application/octet-stream')]
        public static const p16:Class;
        [Embed(source = '../map/p17.oel', mimeType = 'application/octet-stream')]
        public static const p17:Class;
        [Embed(source = '../map/p18.oel', mimeType = 'application/octet-stream')]
        public static const p18:Class;
        [Embed(source = '../map/p19.oel', mimeType = 'application/octet-stream')]
        public static const p19:Class;
        [Embed(source = '../map/q0.oel', mimeType = 'application/octet-stream')]
        public static const q0:Class;
        [Embed(source = '../map/q1.oel', mimeType = 'application/octet-stream')]
        public static const q1:Class;
        [Embed(source = '../map/q2.oel', mimeType = 'application/octet-stream')]
        public static const q2:Class;
        [Embed(source = '../map/q3.oel', mimeType = 'application/octet-stream')]
        public static const q3:Class;
        [Embed(source = '../map/q4.oel', mimeType = 'application/octet-stream')]
        public static const q4:Class;
        [Embed(source = '../map/q5.oel', mimeType = 'application/octet-stream')]
        public static const q5:Class;
        [Embed(source = '../map/q6.oel', mimeType = 'application/octet-stream')]
        public static const q6:Class;
        [Embed(source = '../map/q7.oel', mimeType = 'application/octet-stream')]
        public static const q7:Class;
        [Embed(source = '../map/q8.oel', mimeType = 'application/octet-stream')]
        public static const q8:Class;
        [Embed(source = '../map/q9.oel', mimeType = 'application/octet-stream')]
        public static const q9:Class;
        [Embed(source = '../map/q10.oel', mimeType = 'application/octet-stream')]
        public static const q10:Class;
        [Embed(source = '../map/q11.oel', mimeType = 'application/octet-stream')]
        public static const q11:Class;
        [Embed(source = '../map/q12.oel', mimeType = 'application/octet-stream')]
        public static const q12:Class;
        [Embed(source = '../map/q13.oel', mimeType = 'application/octet-stream')]
        public static const q13:Class;
        [Embed(source = '../map/q14.oel', mimeType = 'application/octet-stream')]
        public static const q14:Class;
        [Embed(source = '../map/q15.oel', mimeType = 'application/octet-stream')]
        public static const q15:Class;
        [Embed(source = '../map/q16.oel', mimeType = 'application/octet-stream')]
        public static const q16:Class;
        [Embed(source = '../map/q17.oel', mimeType = 'application/octet-stream')]
        public static const q17:Class;
        [Embed(source = '../map/q18.oel', mimeType = 'application/octet-stream')]
        public static const q18:Class;
        [Embed(source = '../map/q19.oel', mimeType = 'application/octet-stream')]
        public static const q19:Class;
        [Embed(source = '../map/r0.oel', mimeType = 'application/octet-stream')]
        public static const r0:Class;
        [Embed(source = '../map/r1.oel', mimeType = 'application/octet-stream')]
        public static const r1:Class;
        [Embed(source = '../map/r2.oel', mimeType = 'application/octet-stream')]
        public static const r2:Class;
        [Embed(source = '../map/r3.oel', mimeType = 'application/octet-stream')]
        public static const r3:Class;
        [Embed(source = '../map/r4.oel', mimeType = 'application/octet-stream')]
        public static const r4:Class;
        [Embed(source = '../map/r5.oel', mimeType = 'application/octet-stream')]
        public static const r5:Class;
        [Embed(source = '../map/r6.oel', mimeType = 'application/octet-stream')]
        public static const r6:Class;
        [Embed(source = '../map/r7.oel', mimeType = 'application/octet-stream')]
        public static const r7:Class;
        [Embed(source = '../map/r8.oel', mimeType = 'application/octet-stream')]
        public static const r8:Class;
        [Embed(source = '../map/r9.oel', mimeType = 'application/octet-stream')]
        public static const r9:Class;
        [Embed(source = '../map/r10.oel', mimeType = 'application/octet-stream')]
        public static const r10:Class;
        [Embed(source = '../map/r11.oel', mimeType = 'application/octet-stream')]
        public static const r11:Class;
        [Embed(source = '../map/r12.oel', mimeType = 'application/octet-stream')]
        public static const r12:Class;
        [Embed(source = '../map/r13.oel', mimeType = 'application/octet-stream')]
        public static const r13:Class;
        [Embed(source = '../map/r14.oel', mimeType = 'application/octet-stream')]
        public static const r14:Class;
        [Embed(source = '../map/r15.oel', mimeType = 'application/octet-stream')]
        public static const r15:Class;
        [Embed(source = '../map/r16.oel', mimeType = 'application/octet-stream')]
        public static const r16:Class;
        [Embed(source = '../map/r17.oel', mimeType = 'application/octet-stream')]
        public static const r17:Class;
        [Embed(source = '../map/r18.oel', mimeType = 'application/octet-stream')]
        public static const r18:Class;
        [Embed(source = '../map/r19.oel', mimeType = 'application/octet-stream')]
        public static const r19:Class;
        [Embed(source = '../map/s0.oel', mimeType = 'application/octet-stream')]
        public static const s0:Class;
        [Embed(source = '../map/s1.oel', mimeType = 'application/octet-stream')]
        public static const s1:Class;
        [Embed(source = '../map/s2.oel', mimeType = 'application/octet-stream')]
        public static const s2:Class;
        [Embed(source = '../map/s3.oel', mimeType = 'application/octet-stream')]
        public static const s3:Class;
        [Embed(source = '../map/s4.oel', mimeType = 'application/octet-stream')]
        public static const s4:Class;
        [Embed(source = '../map/s5.oel', mimeType = 'application/octet-stream')]
        public static const s5:Class;
        [Embed(source = '../map/s6.oel', mimeType = 'application/octet-stream')]
        public static const s6:Class;
        [Embed(source = '../map/s7.oel', mimeType = 'application/octet-stream')]
        public static const s7:Class;
        [Embed(source = '../map/s8.oel', mimeType = 'application/octet-stream')]
        public static const s8:Class;
        [Embed(source = '../map/s9.oel', mimeType = 'application/octet-stream')]
        public static const s9:Class;
        [Embed(source = '../map/s10.oel', mimeType = 'application/octet-stream')]
        public static const s10:Class;
        [Embed(source = '../map/s11.oel', mimeType = 'application/octet-stream')]
        public static const s11:Class;
        [Embed(source = '../map/s12.oel', mimeType = 'application/octet-stream')]
        public static const s12:Class;
        [Embed(source = '../map/s13.oel', mimeType = 'application/octet-stream')]
        public static const s13:Class;
        [Embed(source = '../map/s14.oel', mimeType = 'application/octet-stream')]
        public static const s14:Class;
        [Embed(source = '../map/s15.oel', mimeType = 'application/octet-stream')]
        public static const s15:Class;
        [Embed(source = '../map/s16.oel', mimeType = 'application/octet-stream')]
        public static const s16:Class;
        [Embed(source = '../map/s17.oel', mimeType = 'application/octet-stream')]
        public static const s17:Class;
        [Embed(source = '../map/s18.oel', mimeType = 'application/octet-stream')]
        public static const s18:Class;
        [Embed(source = '../map/s19.oel', mimeType = 'application/octet-stream')]
        public static const s19:Class;
        [Embed(source = '../map/t0.oel', mimeType = 'application/octet-stream')]
        public static const t0:Class;
        [Embed(source = '../map/t1.oel', mimeType = 'application/octet-stream')]
        public static const t1:Class;
        [Embed(source = '../map/t2.oel', mimeType = 'application/octet-stream')]
        public static const t2:Class;
        [Embed(source = '../map/t3.oel', mimeType = 'application/octet-stream')]
        public static const t3:Class;
        [Embed(source = '../map/t4.oel', mimeType = 'application/octet-stream')]
        public static const t4:Class;
        [Embed(source = '../map/t5.oel', mimeType = 'application/octet-stream')]
        public static const t5:Class;
        [Embed(source = '../map/t6.oel', mimeType = 'application/octet-stream')]
        public static const t6:Class;
        [Embed(source = '../map/t7.oel', mimeType = 'application/octet-stream')]
        public static const t7:Class;
        [Embed(source = '../map/t8.oel', mimeType = 'application/octet-stream')]
        public static const t8:Class;
        [Embed(source = '../map/t9.oel', mimeType = 'application/octet-stream')]
        public static const t9:Class;
        [Embed(source = '../map/t10.oel', mimeType = 'application/octet-stream')]
        public static const t10:Class;
        [Embed(source = '../map/t11.oel', mimeType = 'application/octet-stream')]
        public static const t11:Class;
        [Embed(source = '../map/t12.oel', mimeType = 'application/octet-stream')]
        public static const t12:Class;
        [Embed(source = '../map/t13.oel', mimeType = 'application/octet-stream')]
        public static const t13:Class;
        [Embed(source = '../map/t14.oel', mimeType = 'application/octet-stream')]
        public static const t14:Class;
        [Embed(source = '../map/t15.oel', mimeType = 'application/octet-stream')]
        public static const t15:Class;
        [Embed(source = '../map/t16.oel', mimeType = 'application/octet-stream')]
        public static const t16:Class;
        [Embed(source = '../map/t17.oel', mimeType = 'application/octet-stream')]
        public static const t17:Class;
        [Embed(source = '../map/t18.oel', mimeType = 'application/octet-stream')]
        public static const t18:Class;
        [Embed(source = '../map/t19.oel', mimeType = 'application/octet-stream')]
        public static const t19:Class;
        [Embed(source = '../map/u0.oel', mimeType = 'application/octet-stream')]
        public static const u0:Class;
        [Embed(source = '../map/u1.oel', mimeType = 'application/octet-stream')]
        public static const u1:Class;
        [Embed(source = '../map/u2.oel', mimeType = 'application/octet-stream')]
        public static const u2:Class;
        [Embed(source = '../map/u3.oel', mimeType = 'application/octet-stream')]
        public static const u3:Class;
        [Embed(source = '../map/u4.oel', mimeType = 'application/octet-stream')]
        public static const u4:Class;
        [Embed(source = '../map/u5.oel', mimeType = 'application/octet-stream')]
        public static const u5:Class;
        [Embed(source = '../map/u6.oel', mimeType = 'application/octet-stream')]
        public static const u6:Class;
        [Embed(source = '../map/u7.oel', mimeType = 'application/octet-stream')]
        public static const u7:Class;
        [Embed(source = '../map/u8.oel', mimeType = 'application/octet-stream')]
        public static const u8:Class;
        [Embed(source = '../map/u9.oel', mimeType = 'application/octet-stream')]
        public static const u9:Class;
        [Embed(source = '../map/u10.oel', mimeType = 'application/octet-stream')]
        public static const u10:Class;
        [Embed(source = '../map/u11.oel', mimeType = 'application/octet-stream')]
        public static const u11:Class;
        [Embed(source = '../map/u12.oel', mimeType = 'application/octet-stream')]
        public static const u12:Class;
        [Embed(source = '../map/u13.oel', mimeType = 'application/octet-stream')]
        public static const u13:Class;
        [Embed(source = '../map/u14.oel', mimeType = 'application/octet-stream')]
        public static const u14:Class;
        [Embed(source = '../map/u15.oel', mimeType = 'application/octet-stream')]
        public static const u15:Class;
        [Embed(source = '../map/u16.oel', mimeType = 'application/octet-stream')]
        public static const u16:Class;
        [Embed(source = '../map/u17.oel', mimeType = 'application/octet-stream')]
        public static const u17:Class;
        [Embed(source = '../map/u18.oel', mimeType = 'application/octet-stream')]
        public static const u18:Class;
        [Embed(source = '../map/u19.oel', mimeType = 'application/octet-stream')]
        public static const u19:Class;
        [Embed(source = '../map/v0.oel', mimeType = 'application/octet-stream')]
        public static const v0:Class;
        [Embed(source = '../map/v1.oel', mimeType = 'application/octet-stream')]
        public static const v1:Class;
        [Embed(source = '../map/v2.oel', mimeType = 'application/octet-stream')]
        public static const v2:Class;
        [Embed(source = '../map/v3.oel', mimeType = 'application/octet-stream')]
        public static const v3:Class;
        [Embed(source = '../map/v4.oel', mimeType = 'application/octet-stream')]
        public static const v4:Class;
        [Embed(source = '../map/v5.oel', mimeType = 'application/octet-stream')]
        public static const v5:Class;
        [Embed(source = '../map/v6.oel', mimeType = 'application/octet-stream')]
        public static const v6:Class;
        [Embed(source = '../map/v7.oel', mimeType = 'application/octet-stream')]
        public static const v7:Class;
        [Embed(source = '../map/v8.oel', mimeType = 'application/octet-stream')]
        public static const v8:Class;
        [Embed(source = '../map/v9.oel', mimeType = 'application/octet-stream')]
        public static const v9:Class;
        [Embed(source = '../map/v10.oel', mimeType = 'application/octet-stream')]
        public static const v10:Class;
        [Embed(source = '../map/v11.oel', mimeType = 'application/octet-stream')]
        public static const v11:Class;
        [Embed(source = '../map/v12.oel', mimeType = 'application/octet-stream')]
        public static const v12:Class;
        [Embed(source = '../map/v13.oel', mimeType = 'application/octet-stream')]
        public static const v13:Class;
        [Embed(source = '../map/v14.oel', mimeType = 'application/octet-stream')]
        public static const v14:Class;
        [Embed(source = '../map/v15.oel', mimeType = 'application/octet-stream')]
        public static const v15:Class;
        [Embed(source = '../map/v16.oel', mimeType = 'application/octet-stream')]
        public static const v16:Class;
        [Embed(source = '../map/v17.oel', mimeType = 'application/octet-stream')]
        public static const v17:Class;
        [Embed(source = '../map/v18.oel', mimeType = 'application/octet-stream')]
        public static const v18:Class;
        [Embed(source = '../map/v19.oel', mimeType = 'application/octet-stream')]
        public static const v19:Class;
        [Embed(source = '../map/w0.oel', mimeType = 'application/octet-stream')]
        public static const w0:Class;
        [Embed(source = '../map/w1.oel', mimeType = 'application/octet-stream')]
        public static const w1:Class;
        [Embed(source = '../map/w2.oel', mimeType = 'application/octet-stream')]
        public static const w2:Class;
        [Embed(source = '../map/w3.oel', mimeType = 'application/octet-stream')]
        public static const w3:Class;
        [Embed(source = '../map/w4.oel', mimeType = 'application/octet-stream')]
        public static const w4:Class;
        [Embed(source = '../map/w5.oel', mimeType = 'application/octet-stream')]
        public static const w5:Class;
        [Embed(source = '../map/w6.oel', mimeType = 'application/octet-stream')]
        public static const w6:Class;
        [Embed(source = '../map/w7.oel', mimeType = 'application/octet-stream')]
        public static const w7:Class;
        [Embed(source = '../map/w8.oel', mimeType = 'application/octet-stream')]
        public static const w8:Class;
        [Embed(source = '../map/w9.oel', mimeType = 'application/octet-stream')]
        public static const w9:Class;
        [Embed(source = '../map/w10.oel', mimeType = 'application/octet-stream')]
        public static const w10:Class;
        [Embed(source = '../map/w11.oel', mimeType = 'application/octet-stream')]
        public static const w11:Class;
        [Embed(source = '../map/w12.oel', mimeType = 'application/octet-stream')]
        public static const w12:Class;
        [Embed(source = '../map/w13.oel', mimeType = 'application/octet-stream')]
        public static const w13:Class;
        [Embed(source = '../map/w14.oel', mimeType = 'application/octet-stream')]
        public static const w14:Class;
        [Embed(source = '../map/w15.oel', mimeType = 'application/octet-stream')]
        public static const w15:Class;
        [Embed(source = '../map/w16.oel', mimeType = 'application/octet-stream')]
        public static const w16:Class;
        [Embed(source = '../map/w17.oel', mimeType = 'application/octet-stream')]
        public static const w17:Class;
        [Embed(source = '../map/w18.oel', mimeType = 'application/octet-stream')]
        public static const w18:Class;
        [Embed(source = '../map/w19.oel', mimeType = 'application/octet-stream')]
        public static const w19:Class;
        [Embed(source = '../map/x0.oel', mimeType = 'application/octet-stream')]
        public static const x0:Class;
        [Embed(source = '../map/x1.oel', mimeType = 'application/octet-stream')]
        public static const x1:Class;
        [Embed(source = '../map/x2.oel', mimeType = 'application/octet-stream')]
        public static const x2:Class;
        [Embed(source = '../map/x3.oel', mimeType = 'application/octet-stream')]
        public static const x3:Class;
        [Embed(source = '../map/x4.oel', mimeType = 'application/octet-stream')]
        public static const x4:Class;
        [Embed(source = '../map/x5.oel', mimeType = 'application/octet-stream')]
        public static const x5:Class;
        [Embed(source = '../map/x6.oel', mimeType = 'application/octet-stream')]
        public static const x6:Class;
        [Embed(source = '../map/x7.oel', mimeType = 'application/octet-stream')]
        public static const x7:Class;
        [Embed(source = '../map/x8.oel', mimeType = 'application/octet-stream')]
        public static const x8:Class;
        [Embed(source = '../map/x9.oel', mimeType = 'application/octet-stream')]
        public static const x9:Class;
        [Embed(source = '../map/x10.oel', mimeType = 'application/octet-stream')]
        public static const x10:Class;
        [Embed(source = '../map/x11.oel', mimeType = 'application/octet-stream')]
        public static const x11:Class;
        [Embed(source = '../map/x12.oel', mimeType = 'application/octet-stream')]
        public static const x12:Class;
        [Embed(source = '../map/x13.oel', mimeType = 'application/octet-stream')]
        public static const x13:Class;
        [Embed(source = '../map/x14.oel', mimeType = 'application/octet-stream')]
        public static const x14:Class;
        [Embed(source = '../map/x15.oel', mimeType = 'application/octet-stream')]
        public static const x15:Class;
        [Embed(source = '../map/x16.oel', mimeType = 'application/octet-stream')]
        public static const x16:Class;
        [Embed(source = '../map/x17.oel', mimeType = 'application/octet-stream')]
        public static const x17:Class;
        [Embed(source = '../map/x18.oel', mimeType = 'application/octet-stream')]
        public static const x18:Class;
        [Embed(source = '../map/x19.oel', mimeType = 'application/octet-stream')]
        public static const x19:Class;
        [Embed(source = '../map/y0.oel', mimeType = 'application/octet-stream')]
        public static const y0:Class;
        [Embed(source = '../map/y1.oel', mimeType = 'application/octet-stream')]
        public static const y1:Class;
        [Embed(source = '../map/y2.oel', mimeType = 'application/octet-stream')]
        public static const y2:Class;
        [Embed(source = '../map/y3.oel', mimeType = 'application/octet-stream')]
        public static const y3:Class;
        [Embed(source = '../map/y4.oel', mimeType = 'application/octet-stream')]
        public static const y4:Class;
        [Embed(source = '../map/y5.oel', mimeType = 'application/octet-stream')]
        public static const y5:Class;
        [Embed(source = '../map/y6.oel', mimeType = 'application/octet-stream')]
        public static const y6:Class;
        [Embed(source = '../map/y7.oel', mimeType = 'application/octet-stream')]
        public static const y7:Class;
        [Embed(source = '../map/y8.oel', mimeType = 'application/octet-stream')]
        public static const y8:Class;
        [Embed(source = '../map/y9.oel', mimeType = 'application/octet-stream')]
        public static const y9:Class;
        [Embed(source = '../map/y10.oel', mimeType = 'application/octet-stream')]
        public static const y10:Class;
        [Embed(source = '../map/y11.oel', mimeType = 'application/octet-stream')]
        public static const y11:Class;
        [Embed(source = '../map/y12.oel', mimeType = 'application/octet-stream')]
        public static const y12:Class;
        [Embed(source = '../map/y13.oel', mimeType = 'application/octet-stream')]
        public static const y13:Class;
        [Embed(source = '../map/y14.oel', mimeType = 'application/octet-stream')]
        public static const y14:Class;
        [Embed(source = '../map/y15.oel', mimeType = 'application/octet-stream')]
        public static const y15:Class;
        [Embed(source = '../map/y16.oel', mimeType = 'application/octet-stream')]
        public static const y16:Class;
        [Embed(source = '../map/y17.oel', mimeType = 'application/octet-stream')]
        public static const y17:Class;
        [Embed(source = '../map/y18.oel', mimeType = 'application/octet-stream')]
        public static const y18:Class;
        [Embed(source = '../map/y19.oel', mimeType = 'application/octet-stream')]
        public static const y19:Class;
        [Embed(source = '../map/z0.oel', mimeType = 'application/octet-stream')]
        public static const z0:Class;
        [Embed(source = '../map/z1.oel', mimeType = 'application/octet-stream')]
        public static const z1:Class;
        [Embed(source = '../map/z2.oel', mimeType = 'application/octet-stream')]
        public static const z2:Class;
        [Embed(source = '../map/z3.oel', mimeType = 'application/octet-stream')]
        public static const z3:Class;
        [Embed(source = '../map/z4.oel', mimeType = 'application/octet-stream')]
        public static const z4:Class;
        [Embed(source = '../map/z5.oel', mimeType = 'application/octet-stream')]
        public static const z5:Class;
        [Embed(source = '../map/z6.oel', mimeType = 'application/octet-stream')]
        public static const z6:Class;
        [Embed(source = '../map/z7.oel', mimeType = 'application/octet-stream')]
        public static const z7:Class;
        [Embed(source = '../map/z8.oel', mimeType = 'application/octet-stream')]
        public static const z8:Class;
        [Embed(source = '../map/z9.oel', mimeType = 'application/octet-stream')]
        public static const z9:Class;
        [Embed(source = '../map/z10.oel', mimeType = 'application/octet-stream')]
        public static const z10:Class;
        [Embed(source = '../map/z11.oel', mimeType = 'application/octet-stream')]
        public static const z11:Class;
        [Embed(source = '../map/z12.oel', mimeType = 'application/octet-stream')]
        public static const z12:Class;
        [Embed(source = '../map/z13.oel', mimeType = 'application/octet-stream')]
        public static const z13:Class;
        [Embed(source = '../map/z14.oel', mimeType = 'application/octet-stream')]
        public static const z14:Class;
        [Embed(source = '../map/z15.oel', mimeType = 'application/octet-stream')]
        public static const z15:Class;
        [Embed(source = '../map/z16.oel', mimeType = 'application/octet-stream')]
        public static const z16:Class;
        [Embed(source = '../map/z17.oel', mimeType = 'application/octet-stream')]
        public static const z17:Class;
        [Embed(source = '../map/z18.oel', mimeType = 'application/octet-stream')]
        public static const z18:Class;
        [Embed(source = '../map/z19.oel', mimeType = 'application/octet-stream')]
        public static const z19:Class;
	 
	}
	
}