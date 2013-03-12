package com.hiring.entities
{    
    import com.hiring.Assets;
	import com.hiring.Global;

	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
        
    
    public class Enemy extends Entity
	{
		private var speed_:int = 1;
		private var hitPoints_:int = 1;
		private var chaseDistance_:int = 20;
		private var walkDistance_:int = 60;
		private var walked_:int = 0;
		private var direction_:Boolean = false; // False: Left, True: Right
		private var sprite_:Spritemap = new Spritemap(Assets.ENEMY_MONKEY);
		
		
		public function Enemy(xCoord:int, yCoord:int)
		{
            super(xCoord, yCoord);
            type = Global.ENEMY_TYPE;
            
            sprite_.add("walk", [0], 8, true);
            sprite_.add("idle", [0], 8, true);
            sprite_.play("walk");
            graphic = sprite_;            
		}
        
        
        override public function update():void
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
                // TODO: CHECK IF WE COLLIDE WITH PLANT LIFE, IF SO MOVE AROUND IT
            
                // Walk around 
                if (direction_)
                {
                    this.x += speed_ * FP.elapsed;
                }
                else
                {
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
        
        
        public function distanceFromPoint(x1:int, y1:int, x2:int, y2:int):Number
		{
			return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
		}
	}
}