package com.hiring.entities
{
	import com.hiring.Assets;
	import com.hiring.Global;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	
	public class PlantLife extends Entity
	{
		private const BUSH:int = 0;
		private const TREE:int = 1;
		private const BUSH_WIDTH:int = 32;
		private const BUSH_HEIGHT:int = 32;
		private const TREE_WIDTH:int = 32;
		private const TREE_HEIGHT:int = 64;
		
		private var image_:Image = new Image(Assets.BUSH);
		private var plantType_:int = BUSH;
		
		public function PlantLife(xCoord:int, yCoord:int, plantType:int)
		{
			super(xCoord, yCoord);
			type = Global.PLANT_LIFE_TYPE;
			
			if (plantType == BUSH)
			{
				this.setHitbox(BUSH_WIDTH, BUSH_HEIGHT);	
			}
			else
			{
				image_ = new Image(Assets.TREE);
				this.setHitbox(TREE_WIDTH * .33, TREE_HEIGHT * 0.5, -10, -32);
				plantType_ = plantType;
			}
		
			graphic = image_;
		}
	}
}