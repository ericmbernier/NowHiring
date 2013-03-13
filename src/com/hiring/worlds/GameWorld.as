package com.hiring.worlds
{
	import adobe.utils.CustomActions;
	
	import com.hiring.Assets;
	import com.hiring.Global;
	import com.hiring.entities.*;
	
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	
	public class GameWorld extends World 
	{
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
					xCoord = 40;
				}
				else if (Global.player.x >= 656)
				{
					xCoord = 565;
				}
				else if (Global.player.y <= -16)
				{
					yCoord = 40;
				}
				else if (Global.player.y >= 496)
				{
					yCoord = 410;
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
			var placeDoor:int = FP.rand(62); // 62 spots the door can go
			var xCols:int = 20; //640 / 32
			var yCols:int = 15; //640 / 32
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
							// There are 62 valid spots an open door spot can be placed
							if ((i == 0 && j == 0) || (i == 19 && j == 0) || (i == 0 && j == 14) || (i == 19 && j == 14))
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
			
			Global.hud = new HUD();
			FP.world.add(Global.hud);
		
			FP.world.add(new Monkey(400, 375));

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
