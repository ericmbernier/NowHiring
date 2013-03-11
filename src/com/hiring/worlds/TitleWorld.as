package com.hiring.worlds
{
	import Playtomic.*;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Quad;
	import com.greensock.plugins.TransformMatrixPlugin;
	import com.hiring.Assets;
	import com.hiring.Global;
	import com.hiring.util.Background;
	import com.hiring.util.Button;
	import com.hiring.util.TextButton;
	
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.net.NetStreamPlayTransitions;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.debug.Console;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	
	/**
	 * 
	 * @author Eric Bernier <http://www.ericbernier.com>
	 */
	public class TitleWorld extends World
	{ 
		private var titleLogo_:Image = new Image(Assets.TITLE_LOGO);
		private var titleBg_:Image = new Image(Assets.TITLE_BG);
		
		private var darkScreen_:Image = Image.createRect(Global.GAME_WIDTH, Global.GAME_HEIGHT, 0x000000, 0);
		private var creditsBg_:Image = new Image(Assets.TITLE_CREDITS_BG, null);
		private var lion_:Image = new Image(Assets.TITLE_LION);
		
		// Text on the main menu screen
		private var playGameTxt_:Text = new Text("Play Game", 0, 20, {size:28, color:0xEDE0CC, font:"Adventure", outlineColor:0x000000, outlineStrength:4});
		private var playGameTxtHover_:Text = new Text("Play Game", 0, 20, {size:28, color:0xEDE0CC, font:"Adventure", outlineColor:0x000000, outlineStrength:4});
		private var creditsTxt_:Text = new Text("Credits", 0, 20, {size:28, color:0xEDE0CC, font:"Adventure", outlineColor:0x000000, outlineStrength:4});
		private var creditsTxtHover_:Text = new Text("Credits", 0, 20, {size:28, color:0xEDE0CC, font:"Adventure", outlineColor:0x000000, outlineStrength:4});
		private var backTxt_:Text = new Text("Back", 0, 20, {size:28, color:0xEDE0CC, font:"Adventure", outlineColor:0x000000, outlineStrength:2});
		private var backTxtHover_:Text = new Text("Back", 0, 20, {size:28, color:0xEDE0CC, font:"Adventure", outlineColor:0x000000, outlineStrength:2});
		private var gameByTxt_:Text = new Text("A Game by Eric Bernier", 0, 0, {size:23, color:0xEDE0CC, 
				font:"Adventure", outlineColor:0x000000, outlineStrength:2});
		
		// Buttons on the title screen
		private var playGameBtn_:TextButton;
		private var creditsBtn_:TextButton;
		private var backBtn_:TextButton;
		
		// Booleans used to keep track of which screen of the Title World the player is viewing
		private var viewingTitle_:Boolean = true;
		private var viewingCredits_:Boolean = false;
		
		private var buttonHoverSnd_:Sfx = new Sfx(Assets.SND_BUTTON_HOVER);
		private var buttonSelectSnd_:Sfx = new Sfx(Assets.SND_BUTTON_SELECT);
		private var buttonBackSnd_:Sfx = new Sfx(Assets.SND_BUTTON_BACK);
		
		private var muteImg_:Image = new Image(Assets.MUTE_BTN);
		private var muteHover_:Image = new Image(Assets.MUTE_BTN);
		private var unmuteImg_:Image = new Image(Assets.UNMUTE_BTN);
		private var unmuteHover_:Image = new Image(Assets.UNMUTE_BTN);
		
		
		public function TitleWorld() 
		{
			Global.gameMusic.stop();
			Global.endMusic.stop();
			Global.menuMusic.loop(Global.musicVolume);
			
			Global.paused = false;
			
			gameByTxt_.x = 190;
			gameByTxt_.y = 5;
			titleLogo_.x = 110;
			titleLogo_.y = 35;
			
			this.addGraphic(titleBg_);
			this.addGraphic(titleLogo_);
			this.addGraphic(gameByTxt_);
			this.addGraphic(lion_);
			
			lion_.x = 110;
			lion_.y = 80;
			
			// Initialize and set all of the text on the main screen
			playGameTxt_.width = FP.width;
			playGameTxt_.y -= 28;
			playGameTxtHover_.width = FP.width;
			playGameTxtHover_.y -=  28;
			
			creditsTxt_.width = FP.width;
			creditsTxt_.y -= 28;
			creditsTxtHover_.width = FP.width;
			creditsTxtHover_.y -=  28;
			
			// Initialize all of the buttons on the main menu
			playGameBtn_ = new TextButton(playGameTxt_, 160, 440, 155, 30, startGame);
			playGameBtn_.normal = playGameTxt_;
			playGameBtn_.hover = playGameTxtHover_;
			playGameBtn_.setRollOverSound(buttonHoverSnd_);
			playGameBtn_.setSelectSound(buttonSelectSnd_);
			this.add(playGameBtn_);
			
			creditsBtn_ = new TextButton(creditsTxt_, 355, 440, 110, 30, viewCredits);
			creditsBtn_.normal = creditsTxt_;
			creditsBtn_.hover = creditsTxtHover_;
			creditsBtn_.setRollOverSound(buttonHoverSnd_);
			creditsBtn_.setSelectSound(buttonSelectSnd_);
			this.add(creditsBtn_);
			
			this.addGraphic(darkScreen_);
			
			creditsBg_.x = 60;
			creditsBg_.y = Global.GAME_HEIGHT + 15;
			this.addGraphic(creditsBg_);
			
			muteHover_.scale = 1.025;
			muteHover_.updateBuffer();
			
			unmuteHover_.scale = 1.025;
			unmuteHover_.updateBuffer();
			
			Global.muteBtn = new Button(620, 0, 26, 26, mute);
			
			if (Global.soundVolume > 0)
			{
				Global.muteBtn.normal = muteImg_;
				Global.muteBtn.hover = muteHover_;
				Global.muteBtn.down = muteImg_;				
			}
			else
			{
				Global.muteBtn.normal = unmuteImg_;
				Global.muteBtn.hover = unmuteHover_;
				Global.muteBtn.down = unmuteImg_;
			}

			this.add(Global.muteBtn);
			
			// Get our shared object for the game to determine levels beaten
			Global.shared = SharedObject.getLocal(Global.SHARED_OBJECT);
			var levelCheck:int = int(Global.shared.data.level);
			if (Global.shared.data.level == undefined || levelCheck == 1)
			{
				Global.shared.flush();			
			}
		}
		
		
		override public function begin():void
		{                     
			super.begin();
		}
		
		
		override public function update():void
		{  
			if (Input.pressed(Global.keyM))
			{
				this.mute();
			}
			
			super.update();
		}
		
		
		private function main():void
		{
			
		}
		
		
		private function startGame():void
		{
			Playtomic.Log.Play();
			
			var bufferImg:Image = new Image(FP.buffer);
			FP.world = new TransitionWorld(GameWorld, bufferImg, Global.TRANSITION_CIRCLE);
		}


		private function viewCredits():void
		{
			this.clearMainTitleScreen();
			viewingCredits_ = true;
			viewingTitle_ = false;
			
			TweenMax.to(darkScreen_, 0.75, {alpha:0.85, repeat: 0, yoyo:false, ease:Quad.easeIn});
			TweenMax.to(creditsBg_, 1.0, {y: 55, repeat:0, yoyo:false, ease:Back.easeOut, onComplete:showBackBtn});
			
			if (backBtn_ != null)
			{
				this.remove(backBtn_);
			}
			
			if (backBtn_ != null)
			{
				this.remove(backBtn_);
			}
			
			backTxt_.width = FP.width;
			backTxt_.y = 0;
			backTxtHover_.width = FP.width;
			backTxtHover_.y = 0;
			
			backBtn_ = new TextButton(backTxt_, 280, 335, 77, 30, backToTitle);
			backBtn_.normal = backTxt_;
			backBtn_.hover = backTxtHover_;
			backBtn_.setRollOverSound(buttonHoverSnd_);
			backBtn_.setSelectSound(buttonBackSnd_);
		}
		
		
		private function clearMainTitleScreen():void
		{
			playGameBtn_.visible = false;
			playGameBtn_.setHitbox(0, 0);
			
			creditsBtn_.visible = false;
			creditsBtn_.setHitbox(0, 0);
		}
		
		
		private function backToTitle():void
		{
			viewingTitle_ = true;
			
			if (viewingCredits_)
			{
				TweenMax.to(darkScreen_, 0.50, {alpha:0, repeat: 0, yoyo:false, ease:Quad.easeIn});
				TweenMax.to(creditsBg_, 0.50, {y: Global.GAME_HEIGHT + 15, repeat:0, yoyo:false, ease:Back.easeIn});
				this.remove(backBtn_);
				
				viewingCredits_ = false;
			}
			
			playGameBtn_.visible = true;
			playGameBtn_.setHitbox(155, 30, 0, 0);
			
			creditsBtn_.visible = true;
			creditsBtn_.setHitbox(120, 30, 0, 0);
			
			if (backBtn_ != null)
			{
				this.remove(backBtn_);
			}
		}
		
		
		public function mute():void
		{
			if (Global.musicVolume <= 0 || Global.soundVolume <= 0)
			{
				Global.musicVolume = Global.DEFAULT_MUSIC_VOLUME;				
				Global.soundVolume = Global.DEFAULT_SFX_VOLUME;
				
				Global.muteBtn.normal = muteImg_;
				Global.muteBtn.down = muteImg_;
				Global.muteBtn.hover = muteHover_;
			}
			else
			{
				Global.musicVolume = 0;
				Global.soundVolume = 0;
				
				Global.muteBtn.normal = unmuteImg_;
				Global.muteBtn.down = unmuteImg_;
				Global.muteBtn.hover = unmuteHover_;
			}
			
			Global.menuMusic.volume = Global.musicVolume;
			Global.gameMusic.volume = Global.musicVolume;
		}
		
		
		private function resetSharedObjectsData():void
		{
			// Reset the scores for each level
			var levelScores:Array = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			Global.shared.data.levelScores = levelScores;
			Global.shared.flush();
			
			if (Global.shared.data.deaths == undefined)
			{
				Global.shared.data.time = 0;
				Global.shared.data.deaths = 0;
				Global.shared.data.cells = 0;
			}
		}
		
		
		private function goToEricsSite():void
		{	
			var url:String = new String("http://www.ericbernier.com");
			navigateToURL(new URLRequest(url));
		}
		
		
		private function showBackBtn():void
		{
			this.add(backBtn_);
		}
	}
}
