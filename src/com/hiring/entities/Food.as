package com.hiring.entities
{
	import com.hiring.Assets;
	import com.hiring.Global;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	
	public class Food extends Entity
	{
		private const WIDTH:int = 24;
		private const HEIGHT:int = 24;
		
		private var img_:Image = new Image(Assets.COOKIE);
		
		public function Food(xCoord:int, yCoord:int)
		{
			super(xCoord, yCoord);
			this.setHitbox(WIDTH, HEIGHT);
			graphic = img_;
		}


		override public function update():void
		{
			
		}
	}
}