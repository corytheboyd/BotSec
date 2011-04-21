package  
{
	import bullets.PistolBullet;
	import doors.*;
	import enemies.E1;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import items.*;

	public class Level extends Entity 
	{		
		protected var grid:Grid;
		protected var tiles:Tilemap;
		protected var decalTiles:Tilemap; //on top of all other tiles
		
		//reference to the loaded XML data of the level
		public var data:XML;
		
		//objects on level
		public var levelItems:Array = new Array;
		public var levelDoors:Array = new Array;
		public var levelEnemies:Array = new Array;
		
		//set to true if the player has visited the tile
		public var visited:Boolean;
		
		//width and height of the loaded level
		public var levelWidth:uint; 
		public var levelHeight:uint;
		public var levelName:String;
		public var index:int;
		
		//references to the adjacent tiles
		public var tileLeft:String; 
		public var tileRight:String;
		public var tileUp:String;
		public var tileDown:String;
		
		/*
		 * Makes a new level based off of the tile name passed
		 * */
		public function Level(targetTile:String) 
		{
			type = GC.LEVEL_TYPE;
			
			loadLevel(targetTile); //loads the level from file, sets this.data
			
			decalTiles = tiles = new Tilemap(GC.GFX_TILESET, levelWidth, levelHeight, 16, 16);
			grid = 	new Grid(levelWidth, levelHeight, 16, 16);
			
			graphic = tiles;
			mask = grid;
			
			for each( var e:XML in data.objects.E1 )
			{
				try
				{
					FP.console.log('Adding E1');
					var tenemy:E1 = new E1( int(e.@x), int(e.@y) );
					
					levelEnemies.push(tenemy);
				}
				catch(e:Error) { FP.console.log('Unable to add E1\n' + e) }
			}
			
			for each( var item:XML in data.objects.item )
			{
				try
				{
					FP.console.log('*** Attempting to add item ' + item.@Class + '...');
					if (item.@Class == 'none') throw new Error('Item not assigned a class name in Ogmo!');
					
					var itemRef:Class = getDefinitionByName('items.' + item.@Class) as Class;
					var itemObj:Entity = new itemRef(int(item.@x), int(item.@y));
					
					levelItems.push(itemObj);
					
					FP.console.log('\t' + item.@Class + ' added!');
				}
				catch (e:Error) { FP.console.log('\tUnable to add ' + item.@Class + '\n\t' + e) }
			}
			
			for each( var door:XML in data.objects.door )
			{
				var tdoor:Door = new Door( int(door.@x), int(door.@y) );
				
				tdoor.locked = (door.@locked == 'true') ? true : false;
				
				levelDoors.push( tdoor );
			}
			
			for each( var doorH:XML in data.objects.doorH )
			{
				var tdoorH:DoorH = new DoorH( int(doorH.@x), int(doorH.@y) );
				
				tdoorH.locked = (doorH.@locked == 'true') ? true : false;
				
				levelDoors.push( tdoorH );
			}
			
			for each( var rect:XML in data.tiles_bg_0.rect )
			{
				tiles.setRect(int(rect.@x) / 16, int(rect.@y) / 16, int(rect.w) / 16, int(rect.h) / 16, tiles.getIndex(int(rect.@tx) / 16, int(rect.@ty) / 16) );
			}
			
			for each( var tile:XML in data.tiles_bg_1.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			
			for each( tile in data.tiles_bg_2.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			
			for each( tile in data.tiles_bg_3.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			
			for each( tile in data.tiles.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			
			for each( tile in data.decals.tile )
			{
				decalTiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, decalTiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			
			for each( tile in data.tiles_fg.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			
			for each( var solid:XML in data.solid.rect )
			{
				grid.setRect(int(solid.@x) / 16, int(solid.@y) / 16, int(solid.@w) / 16, int(solid.@h) / 16, true); 
			}
		}
		
		/*
		 * Loads level from an oel (xml) file
		 * */
		protected function loadLevel(targetTile:String):void
		{
			try 
			{
				//tries to load the tile from GC. returns null if not present
				var tileRef:Class = getDefinitionByName( 'GC_' + targetTile.toLowerCase() ) as Class;
				data = FP.getXML(tileRef);
				
				levelName		= data.@tile_name;
				levelWidth 		= data.width;
				levelHeight		= data.height;
				tileLeft 		= data.@tile_left;
				tileRight 		= data.@tile_right;
				tileUp			= data.@tile_up;
				tileDown		= data.@tile_down;
			}
			catch (e:Error)
			{
				//FP.console.log('WARNING: Unable to load tile:',targetTile);
				return;
			}
			FP.console.log('Loaded tile:',targetTile);
		}
		
	}

}