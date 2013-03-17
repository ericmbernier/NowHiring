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
		private var playGameTxtHover_:Text = new Text("Play Game", 0, 20, {size:28, color:0xFFFFFF, font:"Adventure", outlineColor:0x000000, outlineStrength:4});
		private var creditsTxt_:Text = new Text("Credits", 0, 20, {size:28, color:0xEDE0CC, font:"Adventure", outlineColor:0x000000, outlineStrength:4});
		private var creditsTxtHover_:Text = new Text("Credits", 0, 20, {size:28, color:0xFFFFFF, font:"Adventure", outlineColor:0x000000, outlineStrength:4});
		private var zooTxt_:Text = new Text("Your Zoo", 0, 20, {size:28, color:0xEDE0CC, font:"Adventure", outlineColor:0x000000, outlineStrength:4});
		private var zooTxtHover_:Text = new Text("Your Zoo", 0, 20, {size:28, color:0xFFFFFF, font:"Adventure", outlineColor:0x000000, outlineStrength:4});
		private var backTxt_:Text = new Text("Back", 0, 20, {size:28, color:0xEDE0CC, font:"Adventure", outlineColor:0x000000, outlineStrength:2});
		private var backTxtHover_:Text = new Text("Back", 0, 20, {size:28, color:0xFFFFFF, font:"Adventure", outlineColor:0x000000, outlineStrength:2});
		private var gameByTxt_:Text = new Text("A Game by Eric Bernier", 0, 0, {size:23, color:0xEDE0CC, 
				font:"Adventure", outlineColor:0x000000, outlineStrength:2});

		// Zoo Stats Text
		private var zooBestLevelTxt_:Text = new Text("Best Level: ", 0, 0, {size:23, color:0xEDE0CC, 
			font:"Adventure", outlineColor:0x000000, outlineStrength:2, visible:false});
		private var zooBestLevelNum_:Text = new Text("", 0, 0, {size:23, color:0xEDE0CC, 
			font:"Adventure", outlineColor:0x000000, outlineStrength:2, visible:false});
		private var zooLastLevelTxt_:Text = new Text("Last Level: ", 0, 0, {size:23, color:0xEDE0CC, 
			font:"Adventure", outlineColor:0x000000, outlineStrength:2, visible:false});
		private var zooLastLevelNum_:Text = new Text("", 0, 0, {size:23, color:0xEDE0CC, 
			font:"Adventure", outlineColor:0x000000, outlineStrength:2, visible:false});
		private var zooMonkeysTxt_:Text = new Text("Monkeys captured: ", 0, 0, {size:23, color:0xEDE0CC, 
			font:"Adventure", outlineColor:0x000000, outlineStrength:2, visible:false});
		private var zooMonkeysNum_:Text = new Text("", 0, 0, {size:23, color:0xEDE0CC, 
			font:"Adventure", outlineColor:0x000000, outlineStrength:2, visible:false});
		private var zooTigersTxt_:Text = new Text("Tigers captured:", 0, 0, {size:23, color:0xEDE0CC, 
			font:"Adventure", outlineColor:0x000000, outlineStrength:2, visible:false});
		private var zooTigersNum_:Text = new Text("", 0, 0, {size:23, color:0xEDE0CC, 
			font:"Adventure", outlineColor:0x000000, outlineStrength:2, visible:false});
		private var zooLionsTxt_:Text = new Text("Lions captured: ", 0, 0, {size:23, color:0xEDE0CC, 
			font:"Adventure", outlineColor:0x000000, outlineStrength:2, visible:false});
		private var zooLionsNum_:Text = new Text("", 0, 0, {size:23, color:0xEDE0CC, 
			font:"Adventure", outlineColor:0x000000, outlineStrength:2, visible:false});
		private var zooBg_:Image = new Image(Assets.TITLE_ZOO_BG);
		
		// Buttons on the title screen
		private var playGameBtn_:TextButton;
		private var creditsBtn_:TextButton;
		private var zooBtn_:TextButton;
		private var backBtn_:TextButton;
		
		// Booleans used to keep track of which screen of the Title World the player is viewing
		private var viewingTitle_:Boolean = true;
		private var viewingCredits_:Boolean = false;
		private var viewingZoo_:Boolean = false;
		
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
			Global.menuMusic.loop(Global.musicVolume);
			Global.gameOver = false;
			Global.paused = false;
			Global.level = 0;
			Global.dartCount = Global.START_DARTS;
			Global.cookieCount = Global.START_COOKIES;
			
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

			playGameTxt_.width = FP.width;
			playGameTxt_.y -= 28;
			playGameTxtHover_.width = FP.width;
			playGameTxtHover_.y -=  28;
			
			creditsTxt_.width = FP.width;
			creditsTxt_.y -= 28;
			creditsTxtHover_.width = FP.width;
			creditsTxtHover_.y -=  28;
			
			zooTxt_.width = FP.width;
			zooTxt_.y -= 28;
			zooTxtHover_.width = FP.width;
			zooTxtHover_.y -=  28;
			
			// Initialize all of the buttons on the main menu
			playGameBtn_ = new TextButton(playGameTxt_, 50, 440, 155, 30, startGame);
			playGameBtn_.normal = playGameTxt_;
			playGameBtn_.hover = playGameTxtHover_;
			playGameBtn_.setRollOverSound(buttonHoverSnd_);
			playGameBtn_.setSelectSound(buttonSelectSnd_);
			this.add(playGameBtn_);
			
			creditsBtn_ = new TextButton(creditsTxt_, 255, 440, 110, 30, viewCredits);
			creditsBtn_.normal = creditsTxt_;
			creditsBtn_.hover = creditsTxtHover_;
			creditsBtn_.setRollOverSound(buttonHoverSnd_);
			creditsBtn_.setSelectSound(buttonSelectSnd_);
			this.add(creditsBtn_);
			
			zooBtn_ = new TextButton(zooTxt_, 420, 440, 130, 30, viewZoo);
			zooBtn_.normal = zooTxt_;
			zooBtn_.hover = zooTxtHover_;
			zooBtn_.setRollOverSound(buttonHoverSnd_);
			zooBtn_.setSelectSound(buttonSelectSnd_);
			this.add(zooBtn_);
			
			this.addGraphic(darkScreen_);
			
			zooBg_.x = 60;
			zooBg_.y = Global.GAME_HEIGHT + 15;
			this.addGraphic(zooBg_);
			
			zooBestLevelTxt_.x = 210;
			zooBestLevelTxt_.y = 115;
			zooBestLevelNum_.x = 345;
			zooBestLevelNum_.y = 115;
			this.addGraphic(zooBestLevelTxt_);
			this.addGraphic(zooBestLevelNum_);
			
			zooLastLevelTxt_.x = 215;
			zooLastLevelTxt_.y = 145;
			zooLastLevelNum_.x = 345;
			zooLastLevelNum_.y = 145;
			this.addGraphic(zooLastLevelTxt_);
			this.addGraphic(zooLastLevelNum_);
			
			zooMonkeysTxt_.x = 160;
			zooMonkeysTxt_.y = 175;
			zooMonkeysNum_.x = 385;
			zooMonkeysNum_.y = 175;
			this.addGraphic(zooMonkeysTxt_);
			this.addGraphic(zooMonkeysNum_);
			
			zooTigersTxt_.x = 185;
			zooTigersTxt_.y = 205;
			zooTigersNum_.x = 385;
			zooTigersNum_.y = 205;
			this.addGraphic(zooTigersTxt_);
			this.addGraphic(zooTigersNum_);
			
			zooLionsTxt_.x = 195;
			zooLionsTxt_.y = 235;
			zooLionsNum_.x = 385;
			zooLionsNum_.y = 235;
			this.addGraphic(zooLionsTxt_);
			this.addGraphic(zooLionsNum_);
			
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
			
			Global.shared = SharedObject.getLocal(Global.SHARED_OBJECT);
			var levelCheck:int = int(Global.shared.data.level);
			if (Global.shared.data.level == undefined || levelCheck == 1)
			{
				Global.shared.flush();			
			}
			
			Global.shared = SharedObject.getLocal(Global.SHARED_OBJECT);
			if (Global.shared.data.bestLevel == undefined)
			{
				// Grey out Zoo button
				zooTxt_.color = 0x333333;
				zooTxtHover_.color = 0x333333;
				zooBtn_.setHitbox(0, 0);
				
				Global.shared.data.bestLevel = 0;
				Global.shared.data.lastLevel = 0;
				Global.shared.data.monkeys = 0;
				Global.shared.data.tigers = 0;
				Global.shared.data.lions = 0;
				
			}
			else
			{
				// Set zoo stats, as well as the zoo button
				zooBestLevelNum_.text = Global.shared.data.bestLevel;
				zooLastLevelNum_.text = Global.shared.data.lastLevel;
				zooMonkeysNum_.text = Global.shared.data.monkeys;
				zooTigersNum_.text = Global.shared.data.tigers;
				zooLionsNum_.text = Global.shared.data.lions;
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
			Global.menuMusic.stop();	
			var bufferImg:Image = new Image(FP.buffer);
			FP.world = new TransitionWorld(GameWorld, bufferImg, Global.TRANSITION_CIRCLE);
		}


		private function viewCredits():void
		{
			this.clearMainTitleScreen();
			viewingCredits_ = true;
			viewingTitle_ = false;
			viewingZoo_ = false;
			
			TweenMax.to(darkScreen_, 0.75, {alpha:0.80, repeat: 0, yoyo:false, ease:Quad.easeIn});
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
		
		
		private function viewZoo():void
		{
			this.clearMainTitleScreen();
			viewingCredits_ = false;
			viewingTitle_ = false;
			viewingZoo_ = true;
			
			TweenMax.to(darkScreen_, 0.75, {alpha:0.80, repeat: 0, yoyo:false, ease:Quad.easeIn});
			TweenMax.to(zooBg_, 1.0, {y: 55, repeat:0, yoyo:false, ease:Back.easeOut, onComplete:showZooInfo});
			
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
			
			zooBtn_.visible = false;
			zooBtn_.setHitbox(0, 0);
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
			else if (viewingZoo_)
			{
				zooBestLevelTxt_.visible = false;
				zooBestLevelNum_.visible = false;
				zooLastLevelTxt_.visible = false;
				zooLastLevelNum_.visible = false;
				zooMonkeysTxt_.visible = false;
				zooMonkeysNum_.visible = false;
				zooTigersTxt_.visible = false;
				zooTigersNum_.visible = false;
				zooLionsTxt_.visible = false;
				zooLionsNum_.visible = false;
				
				TweenMax.to(darkScreen_, 0.50, {alpha:0, repeat: 0, yoyo:false, ease:Quad.easeIn});
				TweenMax.to(zooBg_, 0.50, {y: Global.GAME_HEIGHT + 15, repeat:0, yoyo:false, ease:Back.easeIn});
				
				viewingZoo_ = false;
			}
			
			playGameBtn_.visible = true;
			playGameBtn_.setHitbox(155, 30, 0, 0);
			
			creditsBtn_.visible = true;
			creditsBtn_.setHitbox(120, 30, 0, 0);
			
			zooBtn_.visible = true;
			zooBtn_.setHitbox(130, 30, 0, 0);
			
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
		
		
		private function showZooInfo():void
		{
			zooBestLevelTxt_.visible = true;
			zooBestLevelNum_.visible = true;
			zooLastLevelTxt_.visible = true;
			zooLastLevelNum_.visible = true;
			zooMonkeysTxt_.visible = true;
			zooMonkeysNum_.visible = true;
			zooTigersTxt_.visible = true;
			zooTigersNum_.visible = true;
			zooLionsTxt_.visible = true;
			zooLionsNum_.visible = true;
			
			this.add(backBtn_);
		}
		
		
		private function showBackBtn():void
		{
			this.add(backBtn_);
		}
	}
}
