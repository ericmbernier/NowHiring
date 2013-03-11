package com.hiring.util 
{
	/**
	 *
	 * @author xenmas
	 */
	public class FloorGen
	{
		// Map Size
		private var ymax:int = 150;
		private var xmax:int = 150;
		private var mapPos:int = 0;
		public static var mapsize:int = 0;
		
		// Partition size and position
		private var partitionX:Array = [];
		private var partitionY:Array = [];
		private var partitionWidth:Array =[];
		private var partitionHeight:Array =[];
		private var partitionNumber:int = 1;
		private var partitionAdd:int = 0;
		private var partitiionMin:int = 30;
		private var leafX:Array = [];
		private var leafY:Array = [];
		private var leafWidth:Array = [];
		private var leafHeight:Array = [];
		private var leafDirection:Array = [];
		private var leafItteration:Array = [];
		private var leafNumber:int = 0;
		
		// BSP Iterations
		private var iterationBSP:int = 5;
		
		// Room size and position
		private var Roomx:Array = [];
		private var Roomy:Array = [];
		private var RoomWidth:Array = [];
		private var RoomHeight:Array = [];
		private var RoomMinDistance:int = 4;
		private var RoomNumber:int = 0;
		private var RoomMinSize:int = 8;
		
		// Corridor size and position
		private var corridorX:int = 0;
		private var corridorY:int = 0;
		private var corridorWidth:int = 0;
		private var corridorHeight:int = 0;
		private var corridorVariance:int = 2;
				
		//Random Placeholders
		private var directionBSP:int = 0;
		private var positionBSP:int = 0;
		private var splitStable:int = 4;
		
		public static var dungeonMap:Array = [];
		
		
		public function FloorGen()
		{
			// Set Max Map Size
			mapsize = xmax * ymax;
			
			// Clear the map
			for (var i:int = 0; i < mapsize; i++) dungeonMap[i] = 0;
			
			// Generate the map
			PartitionGen();
			RoomGen();
			CorridorGen();
			WallGen();
		}
		
		
		public function WallGen():void
		{
			// Top and Bottom Walls
			for (var i:int = 1; i < ymax; i++)
			{
				for (var j:int = 0; j < xmax; j++)
				{
					mapPos = j + (i * ymax);
					if (dungeonMap[mapPos] == 1)
					{
						if (dungeonMap[mapPos - ymax] == 0)
						{
							if (dungeonMap[(mapPos - ymax) - 1] != 1) dungeonMap[(mapPos - ymax) - 1] = 2;
							if (dungeonMap[(mapPos - ymax) + 1] != 1) dungeonMap[(mapPos - ymax) + 1] = 2;
							dungeonMap[mapPos - ymax] = 2;

						}
						if (dungeonMap[mapPos + ymax] == 0)
						{
							if (dungeonMap[(mapPos + ymax) - 1] != 1) dungeonMap[(mapPos + ymax) - 1] = 2;
							if (dungeonMap[(mapPos + ymax) + 1] != 1) dungeonMap[(mapPos + ymax) + 1] = 2;
							dungeonMap[mapPos + ymax] = 2;
						}
						
					}
				}
			}
			
			// Side Walls
			for (var i:int = 0; i < ymax; i++)
			{
				for (var j:int = 1; j < xmax; j++)
				{
					mapPos = j +(i * ymax);
					if (dungeonMap[mapPos] == 1)
					{
						if (dungeonMap[mapPos - 1] == 0)
						{
							dungeonMap[mapPos - 1] = 2;
						}
						if (dungeonMap[mapPos +1] == 0)
						{
							if (dungeonMap[(mapPos + 1) - ymax] != 1) dungeonMap[(mapPos + 1) - ymax] = 2;
							if (dungeonMap[(mapPos + 1) + ymax] != 1) dungeonMap[(mapPos + 1) + ymax] = 2;
							dungeonMap[mapPos +1] = 2;
						}
					}
				}
			}
		}
		
		
		public function CorridorGen():void
		{
			for (var i:int = (iterationBSP -1); i > -1; i--)
			{
				for (var j:int = (leafNumber-1); j > -1; j--)
				{
					if (int((j+1) / 2) == (j+1) / 2)
					{
						if (leafItteration[j] == i)
						{
							if (leafDirection[j] == 0)
							{
								corridorX = (leafX[j - 1] + (leafWidth[j - 1] / 2))-corridorVariance;
								corridorY = leafY[j] + (leafHeight[j] / 2);
								corridorWidth = ((leafWidth[j] / 2) + (leafWidth[j - 1] / 2)+(corridorVariance*2));
								for (var k:int = 0; k < corridorWidth; k++)
								{
									mapPos = (corridorX + k) + (corridorY * ymax);
									dungeonMap[mapPos] = 1;
								}
							}
							
							if (leafDirection[j] == 1)
							{
								corridorX = (leafX[j] +(leafWidth[j] / 2))-corridorVariance;
								corridorY = leafY[j - 1] +(leafHeight[j - 1] / 2);
								corridorHeight = ((leafHeight[j] / 2) + (leafHeight[j - 1] / 2)+(corridorVariance*2));
								for (var m:int = 0; m < corridorHeight; m++)
								{
									mapPos = corridorX + ((corridorY + m) * ymax);
									dungeonMap[mapPos] = 1;
								}
							}
						}
					}
				}
			}
		}
		
		
		public function RoomGen():void
		{
			for (var i:int = 0; i < partitionNumber; i++)
			{
				RoomWidth[i] = int(Math.random() * (partitionWidth[i]-(RoomMinDistance*3)-(RoomMinSize))+RoomMinDistance)+RoomMinSize;
				RoomHeight[i] = int(Math.random() * (partitionHeight[i]- (RoomMinDistance*3)-(RoomMinSize))+RoomMinDistance)+RoomMinSize;
				Roomx[i] = int(Math.random() * RoomMinDistance) + partitionX[i]+RoomMinDistance;
				Roomy[i] = int(Math.random() * RoomMinDistance) + partitionY[i]+RoomMinDistance;
				//trace ("x:" + Roomx[i] + ", y:" + Roomy[i] + ", Width:" + RoomWidth[i] + ", Height:" + RoomHeight[i]);
				if (RoomWidth[i] <= RoomMinSize) RoomWidth[i] = RoomMinSize;
				if (RoomHeight[i] <= RoomMinSize) RoomHeight[i] = RoomMinSize;
				for (var j:int = Roomy[i]; j < (Roomy[i] + RoomHeight[i]); j++)
				{
					for (var k:int = Roomx[i]; k < (Roomx[i] + RoomWidth[i]); k++)
					{
						mapPos = (k + (j * ymax));
						dungeonMap[mapPos] = 1;
					}
				}
			}
			
		}
		
		
		public function PartitionGen():void
		{
			partitionX[0] = 0;
			partitionY[0] = 0;
			partitionWidth[0] = xmax;
			partitionHeight[0] = ymax;
			for (var i:int = 0; i < iterationBSP; i++)
			{
				partitionAdd = 0;
				for (var j:int = 0; j < partitionNumber; j++)
				{
					directionBSP = int(Math.random() * 2);
					if (partitionWidth[j] < partitiionMin) 
					{
						directionBSP = 1;
					}
					
					if (partitionHeight[j] < partitiionMin) 
					{
						directionBSP = 0;
					}
					
					if ((partitionWidth[j] < partitiionMin) && (partitionHeight[j] < partitiionMin)) 
					{
						directionBSP = 2;
					}

					if (directionBSP == 0)
					{
						positionBSP = (int(Math.random() * (splitStable)) - (splitStable)) + (partitionWidth[j]/2);
						partitionWidth [j + partitionNumber] = partitionWidth[j] - positionBSP;
						partitionWidth [j] = positionBSP;
						partitionHeight [j + partitionNumber ] = partitionHeight[j];
						partitionX [j + partitionNumber] = partitionX[j] + positionBSP;
						partitionY [j + partitionNumber] = partitionY[j];
						partitionAdd++;
					}
					else if (directionBSP == 1)
					{
						positionBSP = (int(Math.random() * (splitStable)) - (splitStable)) + (partitionHeight[j]/2);
						partitionHeight[j + partitionNumber] = partitionHeight[j] - positionBSP;
						partitionHeight[j] = positionBSP;
						partitionWidth[j + partitionNumber] = partitionWidth[j];
						partitionX [j + partitionNumber] = partitionX[j];
						partitionY[j + partitionNumber] = partitionY[j] + positionBSP;
						partitionAdd++;
					}
					
					leafX[leafNumber] = partitionX[j];
					leafY[leafNumber] = partitionY[j];
					leafWidth[leafNumber] = partitionWidth[j];
					leafHeight[leafNumber] = partitionHeight[j];
					leafDirection[leafNumber] = directionBSP;
					leafItteration[leafNumber] = i;
					leafNumber ++;
					leafX[leafNumber] = partitionX[j + partitionNumber];
					leafY[leafNumber] = partitionY[j + partitionNumber];
					leafWidth[leafNumber] = partitionWidth[j + partitionNumber];
					leafHeight[leafNumber] = partitionHeight[j + partitionNumber];
					leafDirection[leafNumber] = directionBSP;
					leafItteration[leafNumber] = i;
					leafNumber++;
				}
				
				partitionNumber += partitionAdd;
			}
			
			for (var k:int = 0; k < partitionNumber; k++)
			{
				trace ("x:" + partitionX[k] + ", y:" + partitionY[k] + ", Width:" + partitionWidth[k] + ", Height:" + partitionHeight[k]);
			}
			
			for (var q:int = 0; q < leafNumber; q++)
			{
				trace (q + "- x:" + leafX[q] + ", y:" + leafY[q] + ", Width:" + leafWidth[q] + ", Height:", leafHeight[q] + ", Direction:" + leafDirection[q] +", Itteration:"+leafItteration[q]);
			}
		}
	}
}
