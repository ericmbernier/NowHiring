package com.hiring.util
{
	/**
	 * 
	 *
	 */
	public class DungeonGen 
	{
		public static var rectangles:Vector.<Rectangle> = new Vector.<Rectangle>();
		
		public function DungeonGen() 
		{
			var root:Rectangle = new Rectangle( 0, 0, Registry.dungeonHeight-1, Registry.dungeonWidth-1 ); 
			rectangles.push(root);
			
			while(rectangles.length < Registry.dungeonDetail) 
			{
				var splitIdx:int = Math.round(Math.random() * (rectangles.length - 1));
				var toSplit:Rectangle = rectangles[splitIdx]; 
				
				if(toSplit.split()) 
				{
					rectangles[splitIdx] = toSplit.leftChild;
					rectangles.push(toSplit.rightChild);
				} 
			}
			
			// Generate dungeons
			root.generateDungeon();
		}
	}	
}
