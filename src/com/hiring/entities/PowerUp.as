package com.hiring.entities
{
	import com.hiring.Assets;
	import com.hiring.Global;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;

	
	public class PowerUp extends Entity
	{
		private const WIDTH:int = 20;
		private const HEIGHT:int = 20;
		private const TYPE_DART:int = 1;
		private const TYPE_COOKIE:int = 2;
		private const SHOW_DURATION:int = 25;
		private const COOKIE_VAL:int = 1;
		private const DART_VAL:int = 15;
		
		private var img_:Image = new Image(Assets.POWERUP_SACK);
		private var showImg_:Image = new Image(Assets.DART);
		private var collected_:Boolean = false;
		private var shown_:int = 0;
		private var powerupType_:int = TYPE_DART;
		
		private var powerupSnd_:Sfx = new Sfx(Assets.SND_POWERUP);
		
		public function PowerUp(xCoord:int, yCoord:int, pType:int)
		{
			super(xCoord, yCoord);
			type = Global.POWERUP_TYPE;
			
			if (pType == TYPE_COOKIE)
			{
				showImg_ = new Image(Assets.COOKIE);
				powerupType_ = TYPE_COOKIE;
			}
			
			this.setHitbox(WIDTH, HEIGHT);
			graphic = img_;
			
			// Ensure we never start in plant life
			while (this.collide(Global.PLANT_LIFE_TYPE, this.x, this.y))
			{
				this.x++;
				this.y--;
			}
		}
		
		
		override public function update():void
		{
			if (collected_)
			{	
				this.y -= 1;
				shown_++;
				
				if (shown_ >= SHOW_DURATION)
				{
					FP.world.remove(this);
				}
			}
		}
		
		
		public function collect():void
		{
			powerupSnd_.play(Global.soundVolume);
			collected_ = true;
			graphic = showImg_;
			setHitbox(0, 0);
			type = "NO MORE POWERUP";
			
			if (powerupType_ == TYPE_DART)
			{
				Global.dartCount += DART_VAL;
				Global.hud.updateDarts();
			}
			else
			{
				Global.cookieCount += COOKIE_VAL;
				Global.hud.updateCookies();
			}
		}
	}
}