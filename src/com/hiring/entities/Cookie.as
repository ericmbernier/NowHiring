package com.hiring.entities
{
	import com.hiring.Assets;
	import com.hiring.Global;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	
	public class Cookie extends Entity
	{
		private const WIDTH:int = 24;
		private const HEIGHT:int = 24;
		private const COOKIE_DURATION:Number = 2.0;
		
		private var img_:Image = new Image(Assets.COOKIE);
		private var cookieTimer_:Number = 0;
		
		public function Cookie(xCoord:int, yCoord:int)
		{
			super(xCoord, yCoord);
			this.setHitbox(WIDTH, HEIGHT);
			graphic = img_;
		}


		override public function update():void
		{
			if (this.collide(Global.ENEMY_TYPE, x, y))
			{
				cookieTimer_ += FP.elapsed;	
				if (cookieTimer_ >= COOKIE_DURATION)
				{
					world.add(new Particle(x, y, .5, .5, .1, 0xB0845C));
					world.add(new Particle(x + 5, y + 5, .5, .5, .1, 0x4C3725));
					world.add(new Particle(x - 5, y - 5, .5, .5, .1, 0xB0845C));
					
					FP.world.remove(this);
				}
			}
		}
	}
}