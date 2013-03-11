package com.hiring.entities
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author RKDN
	 */
	public class Player extends Entity 
	{
		private var image:Image;
		private var velocity:Point = new Point(0, 0);
		
		
		public function Player(x:uint,y:uint) 
		{
			image = new Image(new BitmapData(8, 8,false,0x0000000));
			graphic = image;
			setHitbox(8, 8, 0, 0);
		}
		
		
		private function updateMovement():void 
		{
			var movement:Point = new Point;
			if (Input.check(Key.LEFT))  movement.x--;
			if (Input.check(Key.RIGHT)) movement.x++;
			if (Input.check(Key.UP))    movement.y--;
			if (Input.check(Key.DOWN))  movement.y++;
			
			velocity.x = 50 * FP.elapsed * movement.x;
			velocity.y = 50 * FP.elapsed * movement.y;
			
		}
		
		override public function update():void 
		{
			
			updateMovement();
			
			FP.camera.x = x - 120; FP.camera.y = y - 120;
			
			x += velocity.x;
			if (collide("level", x, y)) {
				if (FP.sign(velocity.x) > 0) {
					//Moving right
					velocity.x = 0;
					x = Math.floor(x / 16) * 16 + 16 -width;
					
				}
				else {
					//Moving left
					velocity.x = 0;
					x = Math.floor(x / 16) * 16 + 16;
				}
			}
			y += velocity.y;
			if (collide("level", x, y)) {
				if (FP.sign(velocity.y) > 0) {
					//Moving up
					velocity.y = 0;
					y = Math.floor(y / 16) * 16 + 16 -height;
					
				}
				else {
					//Moving down
					velocity.y = 0;
					y = Math.floor(y / 16) * 16 + 16;
				}
			}
			
			super.update();
		}	
	}
}
