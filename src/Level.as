package  
{
	import bullets.*;
	import enemies.*;
	import interactives.*;
	import items.*;
	import platforms.*;
	import flash.geom.Point;
	import flash.net.Responder;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import interactives.Respawner;
	import interactives.SaveBeacon;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;	

	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Level extends Entity 
	{		
		protected var grid:Grid;
		protected var tiles:Tilemap;
		protected var decalTiles:Tilemap; //on top of all other tiles
		
		//reference to the loaded XML data of the level
		public var data:XML;
		
		//objects on level
		public var levelBeacon:SaveBeacon = null;
		public var levelRespawner:Respawner = null;
		public var levelItems:Array = [];
		public var levelDoors:Array = [];
		public var levelEnemies:Array = [];
		public var levelPlatforms:Array = [];
		public var levelHazards:Array = [];
		public var levelLifts:Array = [];
		public var levelSwitches:Array = [];
		public var levelInteractives:Array = []; //store all Interactive objects
		
		//set to true if the player has visited the tile
		public var visited:Boolean;
		
		//width and height of the loaded level
		public var levelWidth:uint; 
		public var levelHeight:uint;
		public var levelName:String;
		
		//the zone that the room is in
		public var levelZone:String;
		
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
			type = GC.SOLID_TYPE;
			
			loadLevel(targetTile); //loads the level from file, sets this.data
			
			decalTiles = tiles = new Tilemap(GC.GFX_TILESET, levelWidth, levelHeight, 16, 16);
			grid = 	new Grid(levelWidth, levelHeight, 16, 16);
			
			graphic = tiles;
			mask = grid;
			
			for each ( var e:XML in data.objects.grav_lift )
			{
				FP.console.log('Adding Gravity Lift piece');
				
				var isOn:Boolean = (e.@isOn == 'true') ? true : false;
				
				var lift:GravityLift = new GravityLift(int(e.@x), int(e.@y), int(e.@height), int(e.@speed), e.@id, isOn)
				levelLifts.push(lift);
				levelInteractives.push(lift);
			}
			
			for each ( e in data.objects.electric_gate_v )
			{
				FP.console.log('Adding Vertical Electric Gate');
				
				isOn = (e.@isOn == 'true') ? true : false;
				
				var gate:ElectricGate = new ElectricGate(int(e.@x), int(e.@y), int(e.@height), int(e.@width), e.@id, isOn);
				levelHazards.push(gate);
				levelInteractives.push(gate);
			}
			
			for each ( e in data.objects.electric_gate_h )
			{
				FP.console.log('Adding Horizontal Electric Gate piece');
				
				isOn = (e.@isOn == 'true') ? true : false;
				
				gate = new ElectricGate(int(e.@x), int(e.@y), int(e.@height), int(e.@width), e.@id, isOn);
				levelHazards.push(gate);
				levelInteractives.push(gate)
			}
			
			for each( e in data.objects.platform )
			{
				FP.console.log('Adding Platform');
				
				var nodes:Array = []; //0 is node 1, 1 is node2
				for each ( var n:XML in e.node )
				{
					nodes.push( new Point( int(n.@x), int(n.@y) ) );
				}
				var node1:Point = nodes[0];
				var node2:Point = nodes[1];
				
				var platform:Platform = new Platform( int(e.@x), int(e.@y), int(e.@speed), node1, node2 );
				
				levelPlatforms.push(platform);
			}
			
			for each( e in data.objects.respawn )
			{
				FP.console.log('Adding Respawner');
				var respawner:Respawner = new Respawner( int(e.@x), int(e.@y) );
				
				levelRespawner = respawner;
			}
			
			for each( e in data.objects.saveBeacon )
			{
				try
				{
					FP.console.log('Adding Save Beacon');
					var saveBeacon:SaveBeacon = new SaveBeacon( int(e.@x), int(e.@y) );
					
					saveBeacon.initialSpawn = (e.@isActive == 'true') ? true : false;
					
					levelBeacon = saveBeacon;
				}
				catch (e:Error) { FP.console.log('Unable to add Save Beacon\n' + e); }
			}
			
			for each( e in data.objects.E1 )
			{
				try
				{
					FP.console.log('Adding E1');
					var tenemy:E1 = new E1( int(e.@x), int(e.@y) );
					
					levelEnemies.push(tenemy);
				}
				catch (e:Error) { FP.console.log('Unable to add E1\n' + e); }
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
				var tdoor:Door = new Door( int(door.@x), int(door.@y), door.@id );
				
				tdoor.locked = (door.@locked == 'true') ? true : false;
				
				levelDoors.push( tdoor );
				levelInteractives.push( tdoor );
			}
			
			for each( var doorH:XML in data.objects.doorH )
			{
				var tdoorH:DoorH = new DoorH( int(doorH.@x), int(doorH.@y), doorH.@id );
				
				tdoorH.locked = (doorH.@locked == 'true') ? true : false;
				
				levelDoors.push( tdoorH );
				levelInteractives.push( tdoorH );
			}
			
			for each ( e in data.objects.wall_switch )
			{
				FP.console.log('Adding Switch');
				
				try 
				{
					isOn = (e.@isOn == 'true') ? true : false;
					var useOnce:Boolean = (e.@useOnce == 'true') ? true : false;					
					var s:Switch = new Switch( int(e.@x), int(e.@y), useOnce, isOn, false );
					
					for ( var i:uint = 0; i < levelInteractives.length; i++ )
					{						
						if ( levelInteractives[i].id == e.@t_id )
						{
							s.targetIndexes.push(i);
						}
					}					
					levelSwitches.push(s);
				} 
				catch (err:Error) { FP.console.log('...Unable to add Flipped Switch\n\t' + err); }
			}
			
			for each ( e in data.objects.wall_switch_flipped )
			{
				FP.console.log('Adding Flipped Switch');
				
				try 
				{
					isOn = (e.@isOn == 'true') ? true : false;
					useOnce = (e.@useOnce == 'true') ? true : false;					
					s = new Switch( int(e.@x), int(e.@y), useOnce, isOn, true );
					
					for ( i = 0; i < levelInteractives.length; i++ )
					{						
						if ( levelInteractives[i].id == e.@t_id )
						{
							s.targetIndexes.push(i);
						}
					}					
					levelSwitches.push(s);
				} 
				catch (err:Error) { FP.console.log('...Unable to add Flipped Switch\n\t' + err); }
			}
			
			/*
			 * SOLID
			 * */
			
			//clearTweens grid first just in case it is fucking things up
			//grid.clearRect( 0, 0, levelWidth / 16, levelHeight / 16 );
			
			for each( var solid:XML in data.solid.rect )
			{
				grid.setRect( int(solid.@x) / 16, int(solid.@y) / 16, int(solid.@w) / 16, int(solid.@h) / 16, true );
			}
			
			/*
			 * BG TILES 0
			 * */
			for each( var tile:XML in data.tiles_bg_0.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			for each( tile in data.tiles_bg_0.rect )
			{
				tiles.setRect(int(tile.@x) / 16, int(tile.@y) / 16, int(tile.@w) / 16, int(tile.@h) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			
			/*
			 * BG TILES 1
			 * */
			for each( tile in data.tiles_bg_1.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			for each( tile in data.tiles_bg_1.rect )
			{
				tiles.setRect(int(tile.@x) / 16, int(tile.@y) / 16, int(tile.@w) / 16, int(tile.@h) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			
			/*
			 * BG TILES 2
			 * */
			for each( tile in data.tiles_bg_2.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			for each( tile in data.tiles_bg_2.rect )
			{
				tiles.setRect(int(tile.@x) / 16, int(tile.@y) / 16, int(tile.@w) / 16, int(tile.@h) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			
			/*
			 * BG TILES 3
			 * */
			for each( tile in data.tiles_bg_3.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			for each( tile in data.tiles_bg_3.rect )
			{
				tiles.setRect(int(tile.@x) / 16, int(tile.@y) / 16, int(tile.@w) / 16, int(tile.@h) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			
			/*
			 * TILES
			 * */
			for each( tile in data.tiles.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			for each( tile in data.tiles.rect )
			{
				tiles.setRect(int(tile.@x) / 16, int(tile.@y) / 16, int(tile.@w) / 16, int(tile.@h) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}			
			
			/*
			 * DECALS
			 * */
			for each( tile in data.decals.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			for each( tile in data.decals.rect )
			{
				tiles.setRect(int(tile.@x) / 16, int(tile.@y) / 16, int(tile.@w) / 16, int(tile.@h) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			
			/*
			 * FG TILES
			 * */
			for each( tile in data.tiles_fg.tile )
			{
				tiles.setTile(int(tile.@x) / 16, int(tile.@y) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
			}
			for each( tile in data.tiles_fg.rect )
			{
				tiles.setRect(int(tile.@x) / 16, int(tile.@y) / 16, int(tile.@w) / 16, int(tile.@h) / 16, tiles.getIndex(int(tile.@tx) / 16, int(tile.@ty) / 16) );
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
				data = FP.getXML(tileRef); //reads the level data into XML object
				
				levelName		= data.@tile_name;
				levelZone		= data.@zone;
 				levelWidth 		= data.width;
				levelHeight		= data.height;
				tileLeft 		= data.@tile_left;
				tileRight 		= data.@tile_right;
				tileUp			= data.@tile_up;
				tileDown		= data.@tile_down;
			}
			catch (e:Error)
			{
				FP.console.log('Error loading level ' + targetTile);
				return;
			}
		}
		
	}

}