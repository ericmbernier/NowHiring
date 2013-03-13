package com.hiring.entities
{
	import com.hiring.Assets;
	import com.hiring.Global;
	
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;

	public class Monkey extends Enemy
	{
		private const WIDTH:int = 30;
		private const HEIGHT:int = 30;
		
		public function Monkey(xCoord:int, yCoord:int)
		{
			super(xCoord, yCoord);
			
			sprite_ = new Spritemap(Assets.ENEMY_MONKEY, WIDTH, HEIGHT, animEnd);
			sprite_.add("idle", [0, 1], 8, true);
			sprite_.add("walk", [4, 5, 6, 7], 8, true);
			sprite_.add("sleep", [2, 3], 3, true);
			
			this.setHitbox(WIDTH - 3, HEIGHT - 5, 0, -5);
			graphic = sprite_;
		}
		
		override public function update():void
		{			
			super.update();
		}
		
		
		override public function capture():void
		{
			world.add(new Particle(x, y, .5, .5, .1, 0xAA7951));
			world.add(new Particle(x + 5, y + 5, .5, .5, .1, 0xF9D9AD));
			world.add(new Particle(x - 5, y - 5, .5, .5, .1, 0xAA7951));
			
			FP.world.remove(this);
		}
		
		
		private function animEnd():void
		{
			
		}
	}
}