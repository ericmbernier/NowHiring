package com.hiring.entities
{    
    import com.hiring.Assets;
    import com.hiring.Global;
    
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
       
    
    public class Player extends Entity
	{
		private const WIDTH:int = 32;
		private const HEIGHT:int = 32;
		private const SHOOT_LAG:Number = 0.15;
		private const STARTING_HP:int = 10;
		
		private var hitPoints_:int = STARTING_HP;
		private var speed_:int = 110;
		private var chaseDistance_:int = 20;
		private var walkDistance_:int = 60;
		private var walked_:int = 0;
		private var direction_:Boolean = true; // False: Left, True: Right
		private var moving_:Boolean = false;
		private var sprite_:Spritemap = new Spritemap(Assets.PLAYER, WIDTH, HEIGHT, animEnd); 
		private var shooting_:Boolean = false;
		private var shootTimer_:Number = 0;
		
		public function Player(xCoord:int, yCoord:int)
		{
            super(xCoord, yCoord);
            type = Global.PLAYER_TYPE;
            
            sprite_.add("walk", [4, 5, 6, 7], 8, true);
            sprite_.add("idle", [0, 1], 6, true);
            sprite_.play("walk");
            graphic = sprite_;
			
			this.setHitbox(WIDTH - 6, HEIGHT - 6);
		}
        
        
        override public function update():void
        {
			FP.console.log(shooting_);
			if (Input.check(Global.keyUp) || Input.check(Global.keyDown) || Input.check(Global.keyLeft) ||
					Input.check(Global.keyRight))
			{
				moving_ = true;	
			}
			else
			{
				moving_ = false;
			}
			
            if (Input.check(Global.keyUp))
            {
                this.y -= speed_ * FP.elapsed;
				moving_ = true;
				
				if (this.collide(Global.PLANT_LIFE_TYPE, x, y))
				{
					this.y += speed_ * FP.elapsed;
				}
            }
            else if (Input.check(Global.keyDown))
            {
                this.y += speed_* FP.elapsed;
				moving_ = true;
            
				if (this.collide(Global.PLANT_LIFE_TYPE, x, y))
				{
					this.y -= speed_ * FP.elapsed;
				}
			}
            
            if (Input.check(Global.keyRight))
            {
                this.x += speed_ * FP.elapsed;
				moving_ = true;
				direction_ = true;
				
				if (this.collide(Global.PLANT_LIFE_TYPE, x, y))
				{
					this.x -= speed_ * FP.elapsed;
				}
            }
            else if (Input.check(Global.keyLeft))
            {
                this.x -= speed_ * FP.elapsed;   
				moving_ = true;
				direction_ = false;
				
				if (this.collide(Global.PLANT_LIFE_TYPE, x, y))
				{
					this.x += speed_ * FP.elapsed;
				}
            }

            if (moving_)
			{
				sprite_.play("walk");
			}
			else
			{
				sprite_.play("idle");
			}
			
			if (!direction_)
			{
				sprite_.flipped = true;
			}
			else
			{
				sprite_.flipped = false;
			}
			
            // Check the shooting controls
			if (!shooting_)
			{
	            if (Input.check(Global.keyW))
	            {
	            	FP.world.add(new Dart(x + 15, y, Global.DIR_UP));
					shooting_ = true;
				}
				else if (Input.check(Global.keyS))
	            {
					FP.world.add(new Dart(x + 15, y + 20, Global.DIR_DOWN));
					shooting_ = true;
	            }            
				else if (Input.check(Global.keyA))
	            {
					FP.world.add(new Dart(x, y + 5, Global.DIR_LEFT));
					shooting_ = true;
					direction_ = false;
	            } 
				else if (Input.check(Global.keyD))
	            {            
					FP.world.add(new Dart(x + 25, y + 5, Global.DIR_RIGHT));
					shooting_ = true;
					direction_ = true;
	            }
			}
			else
			{
				shootTimer_ += FP.elapsed;
				if (shootTimer_ >= SHOOT_LAG)
				{
					shooting_ = false;
					shootTimer_ = 0;
				}
			}
            
            // Check if player dropped Food
            if (Input.check(Global.keyE) && Global.foodCount > 0)
            {
                Global.foodCount--;
                
                if (direction_)
                {
                	FP.world.add(new Food(x + 50, y + 25));
                }
                else
                {
                    FP.world.add(new Food(x - 20, y + 25));
                }
            }            
            
            if (this.collide(Global.SLEEPING_ANIMAL_TYPE, x, y))
            {
                if (Input.check(Global.keySpace))
                {
                    // Add to your zoo shared object
                }
            }
			
			super.update();
        }
        
        
        public function distanceFromPoint(x1:int, y1:int, x2:int, y2:int):Number
		{
			return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
		}
        
        
        private function animEnd():void
        {
        
        }
		
		
		public function takeDamage():void
		{
			hitPoints_--;
		}
		
		
		public function gainHealth():void
		{
			hitPoints_++;
		}
		
		
		public function getHp():int
		{
			return hitPoints_;
		}
	}
}