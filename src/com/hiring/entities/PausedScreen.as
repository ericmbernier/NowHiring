package com.hiring.entities
{
	import com.hiring.Global;
    
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Quad;
	import com.greensock.plugins.TransformMatrixPlugin;
	
	import flash.display.Graphics;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	
	public class PausedScreen extends Entity
	{
		private var pausedScreen_:Image = Image.createRect(Global.GAME_WIDTH, Global.GAME_HEIGHT, 
			0x000000, 0);
		private var pTxt_:Text = new Text("P ", 0, 0, {size:40, outlineColor:0x000000, 
			outlineStrength:3, visible:true, font:"Adventure"});
		private var aTxt_:Text = new Text("A ", 0, 0, {size:40, outlineColor:0x000000, 
			outlineStrength:3, visible:true, font:"Adventure"});
		private var uTxt_:Text = new Text("U ", 0, 0, {size:40, outlineColor:0x000000, 
			outlineStrength:3, visible:true, font:"Adventure"});
		private var sTxt_:Text = new Text("S ", 0, 0, {size:40, outlineColor:0x000000, 
			outlineStrength:3, visible:true, font:"Adventure"});
		private var eTxt_:Text = new Text("E ", 0, 0, {size:40, outlineColor:0x000000, 
			outlineStrength:3, visible:true, font:"Adventure"});
		private var dTxt_:Text = new Text("D ", 0, 0, {size:40, outlineColor:0x000000, 
			outlineStrength:3, visible:true, font:"Adventure"});
		private var enterTxt_:Text = new Text("Press ENTER to resume", 0, 0, {size:24, 
			outlineColor:0x000000, outlineStrength:3, visible:true, font:"Adventure"});
		private var quitTxt_:Text = new Text("Press Q to quit", 0, 0, {size:24, 
			outlineColor:0x000000, outlineStrength:3, visible:true, font:"Adventure"});
		
		private var gfx_:Graphiclist;

		
		public function PausedScreen(xCoord:int, yCoord:int)
		{	
			super(xCoord, yCoord);

			pTxt_.x = this.x + 220;
			pTxt_.y = this.y + 135;
			
			aTxt_.x = this.x + 247;
			aTxt_.y = this.y + 135;
			
			uTxt_.x = this.x + 280;
			uTxt_.y = this.y + 135;
			
			sTxt_.x = this.x + 315;
			sTxt_.y = this.y + 135;
			
			eTxt_.x = this.x + 340;
			eTxt_.y = this.y + 135;
			
			dTxt_.x = this.x + 370;
			dTxt_.y = this.y + 135;

			enterTxt_.x = this.x + 175;
			enterTxt_.y = this.y + 210;
			
			quitTxt_.x = this.x + 215;
			quitTxt_.y = this.y + 250;
			
			gfx_ = new Graphiclist(pausedScreen_, pTxt_, aTxt_, uTxt_, sTxt_, eTxt_, dTxt_, enterTxt_, quitTxt_);
			this.graphic = gfx_;
			
			this.layer = -99999;
		}
		
		
		override public function update():void
		{
			super.update();
		}
		
		
		public function pauseGame():void
		{
			TweenMax.to(pausedScreen_, 0.25, {alpha:0.75, repeat: 0, yoyo:false, ease:Quad.easeIn});
			Global.paused = true;
			
			this.visible = true;
			pTxt_.visible = true;
			aTxt_.visible = true;
			uTxt_.visible = true;
			sTxt_.visible = true;
			eTxt_.visible = true;
			dTxt_.visible = true;
			
			TweenMax.to(pTxt_, 0.3, {y: pTxt_.y + 5, repeat: -1, yoyo:true, delay:0, ease:Quad.easeInOut});
			TweenMax.to(aTxt_, 0.3, {y: aTxt_.y + 5, repeat: -1, yoyo:true, delay:0.2, ease:Quad.easeInOut});
			TweenMax.to(uTxt_, 0.3, {y: uTxt_.y + 5, repeat: -1, yoyo:true, delay:0.4, ease:Quad.easeInOut});
			TweenMax.to(sTxt_, 0.3, {y: sTxt_.y + 5, repeat: -1, yoyo:true, delay:0.6, ease:Quad.easeInOut});
			TweenMax.to(eTxt_, 0.3, {y: eTxt_.y + 5, repeat: -1, yoyo:true, delay:0.8, ease:Quad.easeInOut});
			TweenMax.to(dTxt_, 0.3, {y: dTxt_.y + 5, repeat: -1, yoyo:true, delay:1.0, ease:Quad.easeInOut});
			
			enterTxt_.visible = true;
			quitTxt_.visible = true;
			
			if (Global.musicVolume > 0)
			{
				Global.gameMusic.volume = Global.PAUSED_MUSIC_VOLUME;
			}
		}
		
		
		public function unpauseGame():void
		{
			TweenMax.to(pausedScreen_, 0.25, {alpha:0, repeat: 0, yoyo:false, ease:Quad.easeIn});
			Global.paused = false;
			
			pTxt_.visible = false;
			aTxt_.visible = false;
			uTxt_.visible = false;
			sTxt_.visible = false;
			eTxt_.visible = false;
			dTxt_.visible = false;
			
			enterTxt_.visible = false;
			quitTxt_.visible = false;
			
			if (Global.musicVolume > 0)
			{
				Global.gameMusic.volume = Global.DEFAULT_MUSIC_VOLUME;
			}
			
			TweenMax.killTweensOf(pTxt_);
			TweenMax.killTweensOf(aTxt_);
			TweenMax.killTweensOf(uTxt_);
			TweenMax.killTweensOf(sTxt_);
			TweenMax.killTweensOf(eTxt_);
			TweenMax.killTweensOf(dTxt_);
		}
		
		
		public function pausedMute():void
		{
			if (Global.musicVolume <= 0 || Global.soundVolume <= 0)
			{
				Global.musicVolume = Global.PAUSED_MUSIC_VOLUME;				
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
	}
}
