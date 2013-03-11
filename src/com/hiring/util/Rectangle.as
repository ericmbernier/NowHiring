package com.hiring.util
{
	public class Rectangle 
	{
		private var MIN_SIZE:uint = 5;

		public var top:uint;
		public var left:uint;
		public var width:uint;
		public var height:uint;
		public var leftChild:Rectangle;
		public var rightChild:Rectangle;
		private var dungeon:Rectangle;

		public function Rectangle(top:uint, left:uint, height:uint, width:uint) 
		{
			this.top = top;
			this.left = left;
			this.width = width;
			this.height = height;
		}
		
		public function split():Boolean 
		{
			// If already split, bail out
	        if(leftChild != null)
			{
	            return false;
			}
			
			// Direction of split
			var horizontal:Boolean = (Math.random() > .5) ? true : false;
			
			// Maximum height/width we can split off
	        var max:int = (horizontal ? height : width ) - MIN_SIZE; 
			
			// Area too small to split, bail out
	        if( max <= MIN_SIZE ) 
			{
	            return false;
			}
				
			// Generate split point 
			var split:int = Math.round(Math.random() * max); 
			
			// Adjust split point so there's at least MIN_SIZE in both partitions
	        if( split < MIN_SIZE )  
			{
				split = MIN_SIZE;
			}
			
			// Populate child areas
	        if( horizontal )
			{
	            leftChild = new Rectangle( top, left, split, width ); 
	            rightChild = new Rectangle( top+split, left, height-split, width );
	        } 
			else 
			{
	            leftChild = new Rectangle( top, left, height, split );
	            rightChild = new Rectangle( top, left+split, height, width-split );
	        }
			
			// Split successful
	        return true;
		}
		
		public function generateDungeon():void 
		{
			if( leftChild != null ) 
			{ 
				// If current are has child areas, propagate the call
				leftChild.generateDungeon();
				rightChild.generateDungeon();
			} 
			else 
			{ 
				// If leaf node, create a dungeon within the minimum size constraints
				var dungeonTop:int = (height - MIN_SIZE <= 0) ? 0 : Math.round(Math.random()*( height - MIN_SIZE));
				var dungeonLeft:int =  (width - MIN_SIZE <= 0) ? 0 : Math.round(Math.random()*( width - MIN_SIZE));
				var dungeonHeight:int = Math.max(Math.round(Math.random() * ( height - dungeonTop )), MIN_SIZE );
				var dungeonWidth:int = Math.max(Math.round(Math.random() * ( width - dungeonLeft )), MIN_SIZE );
				
				dungeon = new Rectangle( top + dungeonTop, left + dungeonLeft, dungeonHeight, dungeonWidth);
			}
		}	
	}
}
