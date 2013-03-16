package com.hiring.entities
{    
    import com.hiring.Assets;
    import com.hiring.Global;
    
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
        
    
    public class Enemy extends Entity
	{
		protected var speed_:int = 100;
		protected var hitPoints_:int = 1;
		protected var chaseDistance_:int = 100;
		protected var walkDistance_:int = 60;
		protected var walked_:int = 0;
		protected var direction_:Boolean = false; // False: Left, True: Right
		protected var sleeping_:Boolean = false;
		protected var sprite_:Spritemap;
		
		private var hurtSnd_:Sfx = new Sfx(Assets.SND_ANIMAL_HURT);
		
		public function Enemy(xCoord:int, yCoord:int)
		{
            super(xCoord, yCoord);
            type = Global.ENEMY_TYPE;          
		}
        
        
        override public function update():void
        {
			if (sleeping_)
			{
				sprite_.play("sleep");
				
			}
			else
			{
				sprite_.play("walk");
				
				var chaseCookies:Boolean = this.checkForCookies();
				if(!chaseCookies)
				{
		            var distanceFromPlayer:Number = distanceFromPoint(this.x, this.y, Global.player.x, Global.player.y);
		            if (Math.abs(distanceFromPlayer) <= chaseDistance_)
		            {
		                // Chase player
		                this.moveTowards(Global.player.x, Global.player.y, speed_ * FP.elapsed, 
									Global.PLANT_LIFE_TYPE, true);
		            }
		            else
		            {
						var checkLeft:Entity = collide(Global.PLANT_LIFE_TYPE, x - 2, y);
						var checkRight:Entity = collide(Global.PLANT_LIFE_TYPE, x + 2, y);
						if ((checkLeft && !direction_) || (checkRight && direction_))
						{
							direction_ = !direction_;
							walked_ = 0;
						}
		            
		                // Walk around 
		                if (direction_)
		                {
							sprite_.flipped = false;
		                    this.x += speed_ * FP.elapsed;
		                }
		                else
		                {
							sprite_.flipped = true;
		                    this.x -= speed_ * FP.elapsed;
		                }
		                
		                walked_ += speed_ * FP.elapsed;
		                if (walked_ >= walkDistance_)
		                {
		                    walked_ = 0;
		                    direction_ = !direction_;
		                }                
		            }
				}
				
				// Check if we collided with a dart
				var dart:Dart = this.collide(Global.DART_TYPE, x, y) as Dart;
				if (dart)
				{
					dart.destroy();
					this.takeDamage();
				}
			}
			
			super.update();
        }
        
        
		private function takeDamage():void
		{
			hurtSnd_.play(Global.soundVolume);
			
			hitPoints_--;
			if (hitPoints_ <= 0)
			{
				this.sleep();
			}
		}
		
		
		private function sleep():void
		{
			type = Global.SLEEPING_ANIMAL_TYPE;
			sleeping_ = true;
			
			sprite_.play("sleep");
		}
		
		
		public function capture():void
		{
			// Override me
		}
		
		
        public function distanceFromPoint(x1:int, y1:int, x2:int, y2:int):Number
		{
			return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
		}
		
		
		private function checkForCookies():Boolean
		{
			// Check for any cookie bait
			var cookieIndex:int = -1;
			var tempIndex:int = 0;
			var closestCookie:int = 9999;
			
			var cookieList:Array = [];
			world.getClass(Cookie, cookieList);
			
			for each (var c:Cookie in cookieList)
			{
				var tempCookie:int = c.distanceFrom(this);
				if (Math.abs(tempCookie) < closestCookie)
				{
					closestCookie = tempCookie;
					cookieIndex = tempIndex;
				}
				
				tempIndex++;
			}
			
			if (cookieIndex > -1)
			{
				var cookie:Cookie = cookieList[cookieIndex];
				this.moveTowards(cookie.x, cookie.y, speed_ * FP.elapsed, Global.PLANT_LIFE_TYPE, true);
				
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}