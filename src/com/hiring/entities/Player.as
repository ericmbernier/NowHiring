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
		private const HURT_DURATION:Number = 1;
		private const FLING_DURATION:Number = 0.10;
		private const FLINGBACK_SPEED:int = 250;
		
		private var speed_:int = 110;
		private var chaseDistance_:int = 20;
		private var walkDistance_:int = 60;
		private var walked_:int = 0;
		private var direction_:Boolean = true; // False: Left, True: Right
		private var moving_:Boolean = false;
		private var sprite_:Spritemap = new Spritemap(Assets.PLAYER, WIDTH, HEIGHT, animEnd); 
		private var shooting_:Boolean = false;
		private var shootTimer_:Number = 0;
		private var isHurt_:Boolean = false;
		private var hurtTimer_:Number = 0;
		private var flingTimer_:Number = 0;
		
		
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
			FP.console.log(Global.player.x + " - " + Global.player.y)
			if (isHurt_)
			{
				flingTimer_ += FP.elapsed;
				if (flingTimer_ <= FLING_DURATION)
				{
					flingBack();
				}
				
				hurtTimer_ += FP.elapsed;
				if (hurtTimer_ >= HURT_DURATION)
				{
					sprite_.color = 0xFFFFFF;
					isHurt_ = false;
					hurtTimer_ = 0;
					flingTimer_ = 0;
				}
			}
			
			if (Input.check(Global.keyUp) || Input.check(Global.keyDown) || Input.check(Global.keyLeft) ||
					Input.check(Global.keyRight))
			{
				moving_ = true;	
			}
			else
			{
				moving_ = false;
			}
			
            if (Input.check(Global.keyW))
            {
                this.y -= speed_ * FP.elapsed;
				moving_ = true;
				
				if (this.collide(Global.PLANT_LIFE_TYPE, x, y))
				{
					this.y += speed_ * FP.elapsed;
				}
            }
            else if (Input.check(Global.keyS))
            {
                this.y += speed_* FP.elapsed;
				moving_ = true;
            
				if (this.collide(Global.PLANT_LIFE_TYPE, x, y))
				{
					this.y -= speed_ * FP.elapsed;
				}
			}
            
            if (Input.check(Global.keyD))
            {
                this.x += speed_ * FP.elapsed;
				moving_ = true;
				direction_ = true;
				
				if (this.collide(Global.PLANT_LIFE_TYPE, x, y))
				{
					this.x -= speed_ * FP.elapsed;
				}
            }
            else if (Input.check(Global.keyA))
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
	            if (Input.check(Global.keyUp))
	            {
	            	FP.world.add(new Dart(x + 15, y, Global.DIR_UP));
					shooting_ = true;
				}
				else if (Input.check(Global.keyDown))
	            {
					FP.world.add(new Dart(x + 20, y + 20, Global.DIR_DOWN));
					shooting_ = true;
	            }            
				else if (Input.check(Global.keyLeft))
	            {
					FP.world.add(new Dart(x, y + 5, Global.DIR_LEFT));
					shooting_ = true;
					direction_ = false;
	            } 
				else if (Input.check(Global.keyRight))
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
            if (Input.pressed(Global.keyE) && Global.cookieCount > 0)
            {
                Global.cookieCount--;
                
                if (direction_)
                {
                	FP.world.add(new Cookie(x + 50, y + 25));
                }
                else
                {
                    FP.world.add(new Cookie(x - 20, y + 25));
                }
            }            
            
			var animal:Enemy = this.collide(Global.ENEMY_TYPE, x, y) as Enemy;
			if (animal && !isHurt_)
			{
				isHurt_ = true;
				this.flingBack();
				
				Global.curHealth--;
				Global.hud.updateHealthBar();
			}
			
			var sleepingAnimal:Enemy = this.collide(Global.SLEEPING_ANIMAL_TYPE, x, y) as Enemy;
            if (sleepingAnimal)
            {
				Global.captureTxt.visible = true;
				
                if (Input.check(Global.keySpace))
                {
                    // Add to your zoo shared object
					sleepingAnimal.capture();
                }
            }
			else
			{
				Global.captureTxt.visible = false;
			}
			
			if (this.x <= -16 || this.x >= 656 || this.y <= -16 || this.y >= 496)
			{
				Global.nextLevel = true;
			}
			
			super.update();
        }
        
        
		/*******************************************************************************************
		 * Method: flingBack
		 *
		 * Description: Method that renders a player hurt, due to enemy contact
		 ******************************************************************************************/
		private function flingBack():void
		{
			if (isHurt_)
			{
				sprite_.color = 0xFF0000;
			}
			
			var tempSpd:Number = FLINGBACK_SPEED * FP.elapsed;
			
			if (direction_)
			{
				var checkPlant:PlantLife = this.collide(Global.PLANT_LIFE_TYPE, x - tempSpd, y) as PlantLife;
				if (!checkPlant)
				{
					this.x -= tempSpd; 	
				}	
			}
			else
			{
				var checkPlant2:PlantLife = this.collide(Global.PLANT_LIFE_TYPE, x + tempSpd, y) as PlantLife;	
				if (!checkPlant2)
				{
					this.x += tempSpd;
				}
			}
		}
        
        
        private function animEnd():void
        {
        
        }
	}
}