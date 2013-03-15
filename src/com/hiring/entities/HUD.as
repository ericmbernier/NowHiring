package com.hiring.entities
{
	import Playtomic.*;
	
	import com.hiring.Assets;
	import com.hiring.Global;
	import com.hiring.util.Button;
	import com.hiring.util.TextButton;
	import com.hiring.worlds.GameWorld;
	import com.hiring.worlds.TitleWorld;
	import com.hiring.worlds.TransitionWorld;
	
	import flash.display.Graphics;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	
	
	/**
	 * 
	 * @author Eric Bernier <http://www.ericbernier.com>
	 */
	public class HUD extends Entity
	{	
		private const ZERO_HEALTH:int = 0;
		private const ONE_HEALTH:int = 1;
		private const TWO_HEALTH:int = 2;
		private const THREE_HEALTH:int = 3;
		private const FOUR_HEALTH:int = 4;
		private const FIVE_HEALTH:int = 5;
		
		private var levelTxt_:Text = new Text("Level ", 10, 3, {size:20, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:3, font:"Adventure"});
		private var levelNum_:Text = new Text("0", 40, 3, {size:20, 
			outlineColor:0x000000, outlineStrength:3, font:"Adventure"});
		
		private var pauseTxt_:Text = new Text("(P)ause", 0, 0, {size:16, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
		private var pauseTxtHover_:Text = new Text("(P)ause", 0, 0, {size:16, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
		
		private var muteTxt_:Text = new Text("(M)ute", 0, 0, {size:16, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
		private var muteTxtHover_:Text = new Text("(M)ute", 0, 0, {size:16, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
		
		private var lifeTxt_:Text = new Text("-Life-", 0, 0, {size:20, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
		
		private var dartX_:Text = new Text("x", 75, 37, {size:16, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
		private var cookieX_:Text = new Text("x", 135, 37, {size:16, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
		private var dartTxt_:Text;
		private var cookieTxt_:Text;
		
		
		private var hudArrowsImg_:Image = new Image(Assets.HUD_DART);
		private var hudCookieImg_:Image = new Image(Assets.HUD_COOKIE);
		
		private var heart1_:Image = new Image(Assets.HUD_HEART);
		private var heart2_:Image = new Image(Assets.HUD_HEART);
		private var heart3_:Image = new Image(Assets.HUD_HEART);
		private var heart4_:Image = new Image(Assets.HUD_HEART);
		private var heart5_:Image = new Image(Assets.HUD_HEART);
		
		private var gfx_:Graphiclist;
		
		
		public function HUD()
		{	
			Global.captureTxt = new Text("Press SPACE to capture animal for your zoo!", 105, 420, {size:20, color:0xFFFFFF, 
				outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
			Global.captureTxt.visible = false;
			
			dartTxt_ = new Text(Global.dartCount.toString(), 87, 37, {size:16, color:0xFFFFFF, 
				outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
			cookieTxt_ = new Text(Global.cookieCount.toString(), 147, 37, {size:16, color:0xFFFFFF, 
				outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
			
			hudArrowsImg_.x = 30;
			hudArrowsImg_.y = 0;
			hudCookieImg_.x = 115;
			hudCookieImg_..y = 1;
			
			lifeTxt_.x = 540;
			lifeTxt_.y = -5;
			
			levelNum_.text = Global.level.toString();
			levelTxt_.x = 300;
			levelNum_.x = 360;
			levelTxt_.y = -5;
			levelNum_.y = -5;
			
			switch (Global.curHealth)
			{
				case ONE_HEALTH:
				{
					heart2_ = new Image(Assets.HUD_HEART_EMPTY);
					heart3_ = new Image(Assets.HUD_HEART_EMPTY);
					heart4_ = new Image(Assets.HUD_HEART_EMPTY);
					heart5_ = new Image(Assets.HUD_HEART_EMPTY);
					
					break;
				}
				case TWO_HEALTH:
				{
					heart3_ = new Image(Assets.HUD_HEART_EMPTY);
					heart4_ = new Image(Assets.HUD_HEART_EMPTY);
					heart5_ = new Image(Assets.HUD_HEART_EMPTY);
					
					break;
				}
				case THREE_HEALTH:
				{
					heart4_ = new Image(Assets.HUD_HEART_EMPTY);;
					heart5_ = new Image(Assets.HUD_HEART_EMPTY);
					
					break;
				}
				case FOUR_HEALTH:
				{
					heart5_ = new Image(Assets.HUD_HEART_EMPTY);
					break;
				}
			}
			
			heart1_.x = 490;
			heart1_.y = 20;
			heart2_.x = 520;
			heart2_.y = 20;
			heart3_.x = 550;
			heart3_.y = 20;
			heart4_.x = 580;
			heart4_.y = 20;
			heart5_.x = 610;
			heart5_.y = 20;
			
			Global.pauseBtn = new TextButton(pauseTxt_, 490, 455, 65, 30, pauseGame)
			Global.pauseBtn.normal = pauseTxt_;
			Global.pauseBtn.hover = pauseTxtHover_;
			FP.world.add(Global.pauseBtn);
			
			Global.muteBtnTxt = new TextButton(muteTxt_, 570, 455, 65, 30, mute)
			Global.muteBtnTxt.normal = muteTxt_;
			Global.muteBtnTxt.hover = muteTxtHover_;
			FP.world.add(Global.muteBtnTxt);
			
			gfx_ = new Graphiclist(hudArrowsImg_, hudCookieImg_, levelTxt_, levelNum_, lifeTxt_, 
				heart1_, heart2_, heart3_, heart4_, heart5_, Global.captureTxt, dartX_, cookieX_, dartTxt_, cookieTxt_);
			graphic = gfx_;
		}

		
		public function mute():void
		{
			if (Global.musicVolume <= 0 || Global.soundVolume <= 0)
			{
				Global.musicVolume = Global.DEFAULT_MUSIC_VOLUME;				
				Global.soundVolume = Global.DEFAULT_SFX_VOLUME;
			}
			else
			{
				Global.musicVolume = 0;
				Global.soundVolume = 0;
			}
			
			Global.menuMusic.volume = Global.musicVolume;
			Global.gameMusic.volume = Global.musicVolume;
		}
		
		
		public function updateHealthBar():void
		{
			gfx_.removeAll();
			
			switch (Global.curHealth)
			{
				case ZERO_HEALTH:
				{
					heart1_ = new Image(Assets.HUD_HEART_EMPTY);
					heart2_ = new Image(Assets.HUD_HEART_EMPTY);
					heart3_ = new Image(Assets.HUD_HEART_EMPTY);
					heart4_ = new Image(Assets.HUD_HEART_EMPTY);
					heart5_ = new Image(Assets.HUD_HEART_EMPTY);
					
					break;
				}
				case ONE_HEALTH:
				{
					heart2_ = new Image(Assets.HUD_HEART_EMPTY);
					heart3_ = new Image(Assets.HUD_HEART_EMPTY);
					heart4_ = new Image(Assets.HUD_HEART_EMPTY);
					heart5_ = new Image(Assets.HUD_HEART_EMPTY);
					
					break;
				}
				case TWO_HEALTH:
				{
					heart3_ = new Image(Assets.HUD_HEART_EMPTY);
					heart4_ = new Image(Assets.HUD_HEART_EMPTY);
					heart5_ = new Image(Assets.HUD_HEART_EMPTY);
					
					break;
				}
				case THREE_HEALTH:
				{
					heart4_ = new Image(Assets.HUD_HEART_EMPTY);
					heart5_ = new Image(Assets.HUD_HEART_EMPTY);
					
					break;
				}
				case FOUR_HEALTH:
				{
					heart5_ = new Image(Assets.HUD_HEART_EMPTY);
					heart5_.update();
					break;
				}
			}
			
			heart1_.x = 490;
			heart1_.y = 20;
			heart2_.x = 520;
			heart2_.y = 20;
			heart3_.x = 550;
			heart3_.y = 20;
			heart4_.x = 580;
			heart4_.y = 20;
			heart5_.x = 610;
			heart5_.y = 20;
			
			gfx_ = new Graphiclist(hudArrowsImg_, hudCookieImg_, levelTxt_, levelNum_, lifeTxt_, 
				heart1_, heart2_, heart3_, heart4_, heart5_, Global.captureTxt, dartX_, cookieX_, dartTxt_, cookieTxt_);
			graphic = gfx_;
		}
		
		
		public function updateDarts():void
		{
			dartTxt_.text = Global.dartCount.toString();
			dartTxt_.updateBuffer();
		}
		
		
		public function updateCookies():void
		{
			cookieTxt_.text = Global.cookieCount.toString();
			cookieTxt_.updateBuffer();
		}
		
		
		private function pauseGame():void
		{
			if (Global.paused)
			{
				Global.pausedScreen.unpauseGame();
			}
			else
			{
				Global.pausedScreen.pauseGame();
			}
		}
	}
}
