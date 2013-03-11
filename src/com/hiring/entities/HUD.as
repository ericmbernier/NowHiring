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
		private var levelTxt_:Text = new Text("Level", 10, 3, {size:16, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:3, font:"Adventure"});
		private var levelNum_:Text = new Text("0", 40, 3, {size:16, 
			outlineColor:0x000000, outlineStrength:3, font:"Adventure"});
		private var levelName_:Text = new Text("The Forest", 50, 3, {size:16, 
			outlineColor:0x000000, outlineStrength:3, font:"Adventure"});
		
		private var pauseTxt_:Text = new Text("(P)ause", 0, 0, {size:16, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
		private var pauseTxtHover_:Text = new Text("(P)ause", 0, 0, {size:16, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
		
		private var muteTxt_:Text = new Text("(M)ute", 0, 0, {size:16, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
		private var muteTxtHover_:Text = new Text("(M)ute", 0, 0, {size:16, color:0xFFFFFF, 
			outlineColor:0x000000, outlineStrength:2, font: "Adventure"});
		
		private var restartTxt_:Text = new Text("(R)estart", 0, 0, {size:16, outlineColor:0x000000, 
			outlineStrength:2, font: "Adventure"});
		private var restartTxtHover_:Text = new Text("(R)estart", 0, 0, {size:16, outlineColor:0x000000, 
			outlineStrength:2, font: "Adventure"});
		
		private var gfx_:Graphiclist;
		
		
		public function HUD()
		{	
			Global.pauseBtn = new TextButton(pauseTxt_, 400, 3, 30, 13, pauseGame)
			Global.pauseBtn.normal = pauseTxt_;
			Global.pauseBtn.hover = pauseTxtHover_;
			FP.world.add(Global.pauseBtn);
			
			Global.muteBtnTxt = new TextButton(muteTxt_, 480, 3, 30, 13, mute)
			Global.muteBtnTxt.normal = muteTxt_;
			Global.muteBtnTxt.hover = muteTxtHover_;
			FP.world.add(Global.muteBtnTxt);
			
			Global.restartBtn = new TextButton(restartTxt_, 530, 3, 65, 16, restartLevel);
			Global.restartBtn.normal = restartTxt_;
			Global.restartBtn.hover = restartTxtHover_;
			FP.world.add(Global.restartBtn);
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
		

		private function restartLevel():void
		{
			if (!Global.paused)
			{				
				// Global.player.killMe();
			}
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
