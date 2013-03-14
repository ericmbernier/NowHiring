package com.hiring.worlds
{
	import adobe.utils.CustomActions;
	
	import com.hiring.Assets;
	import com.hiring.Global;
	import com.hiring.entities.*;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	
	public class GameWorld extends World 
	{
		private const LEVEL_TYPES:int = 7;
		private const BUSH:int = 0;
		private const TREE:int = 1;
		
		private const LEVEL_EMPTY:int = 0;
		private const LEVEL_TWO_BUSHES:int = 1;
		private const LEVEL_THREE_TREES:int = 2;
		private const LEVEL_SQUARE:int = 3;
		private const LEVEL_TRIANGLE:int = 4;
		private const LEVEL_RECTANGLE:int = 5;
		private const LEVEL_SAND:int = 6;
		private const LEVEL_WATER:int = 7;
		
		private var tileset_:Tilemap;
		private var loadedDoor_:Boolean = false;
		
		
		public function GameWorld() 
		{
			Global.gameMusic.loop(Global.musicVolume);
		}
		
		
		override public function begin():void 
		{	
			loadWorld();
		}
		
		
		override public function update():void
		{
			if (Input.pressed(Global.keyEnter))
			{
				this.loadWorld();
			}
			
			if (Global.nextLevel)
			{
				Global.nextLevel = false;
				var xCoord:int = Global.player.x;
				var yCoord:int = Global.player.y;

				if (Global.player.x <= -16)
				{
					xCoord = 565;
				}
				else if (Global.player.x >= 656)
				{
					xCoord = 40;
				}
				else if (Global.player.y <= -16)
				{
					yCoord = 410;
				}
				else if (Global.player.y >= 496)
				{
					yCoord = 40;
				}
				
				this.loadWorld(xCoord, yCoord);
			}
			
			super.update();
		}
		
		
		private function loadWorld(xCoord:int = 100, yCoord:int = 100):void
		{
			Global.level++;
			
			removeAll();
			loadedDoor_ = false;
						
			add(new Entity(0, 0, tileset_ = new Tilemap(Assets.TILESET_WORLD, 
				FP.width, FP.height, 32, 32)));
			
			var doorIndex:int = 0;
			var placeDoor:int = FP.rand(42); // 62 spots the door can go
			var xCols:int = 20; //640 / 32
			var yCols:int = 15; //640 / 32
			// We have 300 grid cells
			for (var i:int = 0; i < xCols; i++)
			{
				for (var j:int = 0; j < yCols; j++)
				{		
					var randTile:int = FP.rand(4);
					var tileX:int = 32 * randTile;
					
					tileset_.setTile(i, j, randTile);
					
					if (i == 0 || j == 0 || i == 19 || j == 14)
					{
						if (!loadedDoor_)
						{
							// There are 42 valid spots an open door spot can be placed
							if ((j == 0) || (i == 0 && j == 14) || (i == 19 && j == 14))
							{
								FP.world.add(new PlantLife(i * 32, j * 32, 0));
							}
							else
							{	
								if (placeDoor == doorIndex)
								{
									loadedDoor_ = true;
									continue;
								}
								else
								{
									FP.world.add(new PlantLife(i * 32, j *32, 0));
									doorIndex++;
								}
							}
						}
						else
						{
							FP.world.add(new PlantLife(i * 32, j *32, 0));
						}
					}
				}
			}
			
			// Add randomization here. This is rather weak, as this is my first roguelike
			if (Global.level > 1)
			{
				var levelToLoad:int = FP.rand(Assets.LEVELS.length);
				var file:ByteArray = new Assets.LEVELS[levelToLoad];
				var str:String = file.readUTFBytes(file.length);
				var xml:XML = new XML(str);
				var e:Entity;
				var o:XML;
				var n:XML;
				
				for each (o in xml.entities[0].bush) 
				{ 
					this.add(new PlantLife(o.@x, o.@y, BUSH));
				}
				
				for each (o in xml.entities[0].tree) 
				{ 
					this.add(new PlantLife(o.@x, o.@y, TREE));
				}
				
				if (int(xml.haveTiles) == 1)
				{
					for each (o in xml.tileset[0].tile) 
					{
						tileset_.setTile(o.@x / Global.grid,  o.@y / Global.grid, 
							(4 * (o.@ty / Global.grid)) + (o.@tx/Global.grid));
					}
				}
			}
			
			Global.hud = new HUD();
			FP.world.add(Global.hud);
		
			// Add enemy randomization here, checking to not place in plantlife
			FP.world.add(new Monkey(400, 375));

			// Add powerup randomization here (cookies and ammo)
			
			if (Global.level == 1)
			{
				FP.world.add(new DirectionSign(200, 175, "Testing"));
				FP.world.add(new DirectionSign(350, 175, "testing again"));
				FP.world.add(new DirectionSign(500, 175, "testing again"));
			}
			
			Global.player = new Player(xCoord, yCoord);
			add(Global.player);
		}
		
		

	}
}
