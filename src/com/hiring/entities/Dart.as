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
		private const MAX_DISTANCE:int = 125;
		
		private var dir_:int = Global.DIR_UP;
		private var img_:Image = new Image(Assets.DART);
		private var traveled_:Number = 0;
		
		public function Dart(xCoord:int, yCoord:int, direction:int)
		{
			super(xCoord, yCoord);
			type = Global.DART_TYPE;
			
			dir_ = direction;
			if (dir_ == Global.DIR_UP)
			{
				img_ = new Image(Assets.DART_UP);
				this.setHitbox(HEIGHT, WIDTH);
			}
			else if (dir_ == Global.DIR_DOWN)
			{
				img_ = new Image(Assets.DART_UP);
				img_.angle = 180;
				
				this.setHitbox(HEIGHT, WIDTH, HEIGHT, WIDTH);
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
		
		
		public function destroy():void
		{
			world.add(new Particle(x, y, .5, .5, .1, 0xFF0000));
			world.add(new Particle(x + 5, y + 5, .5, .5, .1, 0xFFFFFF));
			world.add(new Particle(x - 5, y - 5, .5, .5, .1, 0xFF0000));
			
			FP.world.remove(this);
		}
	}
}