package com.hiring.entities
{
	import com.hiring.Assets;
	import com.hiring.Global;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	
	public class Dart extends Entity
	{
		private const WIDTH:int = 16;
		private const HEIGHT:int = 7;
		private const SPEED:Number = 300;
		private const MAX_DISTANCE:int = 150;
		
		private var dir_:int = Global.DIR_UP;
		private var img_:Image = new Image(Assets.DART);
		private var traveled_:Number = 0;
		
		public function Dart(xCoord:int, yCoord:int, direction:int)
		{
			super(xCoord, yCoord);
			dir_ = direction;
			
			if (dir_ == Global.DIR_UP)
			{
				img_ = new Image(Assets.DART_UP);
				this.setHitbox(HEIGHT, WIDTH);
			}
			else if (dir_ == Global.DIR_DOWN)
			{
				img_ = new Image(Assets.DART_UP);
				img_.flipped = true;	
				this.setHitbox(HEIGHT, WIDTH);
			}
			else if (dir_ == Global.DIR_LEFT)
			{
				img_.flipped = true;
				this.setHitbox(WIDTH, HEIGHT);
			}
			else
			{
				this.setHitbox(WIDTH, HEIGHT);
			}
			
			graphic = img_;
		}
		
		
		override public function update():void
		{
			if (dir_ == Global.DIR_UP)
			{
				traveled_ -= SPEED * FP.elapsed;
				this.y -= SPEED * FP.elapsed;
			}
			else if (dir_ == Global.DIR_DOWN)
			{
				traveled_ += SPEED * FP.elapsed;
				this.y += SPEED * FP.elapsed;
			}
			else if (dir_ == Global.DIR_LEFT)
			{
				traveled_ -= SPEED * FP.elapsed;
				this.x -= SPEED * FP.elapsed;
			}
			else
			{
				traveled_ += SPEED * FP.elapsed;
				this.x += SPEED * FP.elapsed;
			}
			
			if (Math.abs(traveled_) >= MAX_DISTANCE)
			{
				traveled_ = 0;
				FP.world.remove(this);
			}
		}
	}
}