package com.hiring.entities
{
	import com.hiring.Assets;
	import com.hiring.util.DungeonGen;
	import com.hiring.util.Registry
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	
	/**
	 * 
	 * 
	 */
	public class Level extends Entity 
	{
		private var tiles_:Tilemap;
		private var grid_:Grid;
		private var openness_:Number = .2 // Value from 0 to 1
			
			
		public function Level() 
		{
			tiles_ = new Tilemap(Assets.TILESHEET, Registry.dungeonWidth * Registry.tileWidth, 
						Registry.dungeonHeight * Registry.tileHeight, Registry.tileWidth, Registry.tileHeight);
			grid_ = new Grid(Registry.dungeonWidth * Registry.tileWidth, Registry.dungeonHeight * Registry.tileHeight, 
						Registry.tileWidth, Registry.tileHeight, 0, 0);
			
			mask = grid_;
			type = "level";
			graphic = tiles_;
			
			for (var i:uint; i < DungeonGen.rectangles.length; i++) 
			{
				if (DungeonGen.rectangles[i].width <= Registry.dungeonWidth && 
						DungeonGen.rectangles[i].height <= Registry.dungeonHeight && Math.random() > openness_) 
				{
					tiles_.setRectOutline(DungeonGen.rectangles[i].left, DungeonGen.rectangles[i].top, 
							DungeonGen.rectangles[i].width, DungeonGen.rectangles[i].height, 2);

					var doorTop:Point = new Point();
					doorTop.x = DungeonGen.rectangles[i].left + Math.round(Math.random()*DungeonGen.rectangles[i].width);
					doorTop.y = DungeonGen.rectangles[i].top;
					
					var doorBottom:Point = new Point();
					doorBottom.x = DungeonGen.rectangles[i].left + Math.round(Math.random()*DungeonGen.rectangles[i].width);
					doorBottom.y = DungeonGen.rectangles[i].top + DungeonGen.rectangles[i].height;
					
					var doorLeft:Point = new Point();
					doorLeft.x = DungeonGen.rectangles[i].left;
					doorLeft.y = DungeonGen.rectangles[i].top + Math.round(Math.random() * DungeonGen.rectangles[i].height);
					
					var doorRight:Point = new Point();
					doorRight.x = DungeonGen.rectangles[i].left + DungeonGen.rectangles[i].width;
					doorRight.y = DungeonGen.rectangles[i].top + Math.round(Math.random() * DungeonGen.rectangles[i].height);
						
					var isDoor:Boolean = false;
					while (isDoor == false) 
					{	
						if (tiles_.getTile(doorTop.x, doorTop.y - 1) == 0 && tiles_.getTile(doorTop.x, doorTop.y + 1) == 0) 
						{
							tiles_.setTile(doorTop.x, doorTop.y, 0);
							isDoor = true;
						}
						
						if (tiles_.getTile(doorBottom.x, doorBottom.y - 1) == 0 && tiles_.getTile(doorBottom.x, doorBottom.y + 1) == 0) 
						{
							tiles_.setTile(doorBottom.x, doorBottom.y, 0);
							isDoor = true;
						}
						
						if (tiles_.getTile(doorLeft.x - 1, doorLeft.y) == 0 && tiles_.getTile(doorLeft.x + 1, doorLeft.y) == 0) 
						{
							tiles_.setTile(doorLeft.x, doorLeft.y, 0);
							isDoor = true;
						}
						
						if (tiles_.getTile(doorRight.x - 1, doorRight.y) == 0 && tiles_.getTile(doorRight.x + 1, doorRight.y) == 0) 
						{
							tiles_.setTile(doorRight.x, doorRight.y, 0);
							isDoor = true;
						}
					}
				}
			}
		
			tiles_.setRectOutline(0, 0, Registry.dungeonWidth - 1, Registry.dungeonHeight - 1, 2);
			for (var x:uint = 0; x < Registry.dungeonWidth; x++) 
			{
				for (var y:uint = 0; y < Registry.dungeonHeight; y++) 
				{	
					if (tiles_.getTile(x, y) != 0) 
					{
						grid_.setTile(x, y, true);
					}
				}
			}
		}		
	}
}
