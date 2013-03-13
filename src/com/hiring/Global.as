package com.hiring 
{
	import com.hiring.entities.HUD;
	import com.hiring.entities.PausedScreen;
	import com.hiring.entities.Player;
	import com.hiring.util.Background;
	import com.hiring.util.Button;
	import com.hiring.util.TextButton;
	
	import flash.net.SharedObject;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Key;
	
	
	/*
	* This class contains a number of global variables to be used throughout the game
	*/
	public class Global
	{
		public static var
			GAME_WIDTH:int = 640,
			GAME_HEIGHT:int = 480,
			level:int = 0,
			levelHeight:int = 0,
			TILE_COLUMNS:int = 4,
			
			DIR_UP:uint = 1,
			DIR_DOWN:uint = 2,
			DIR_LEFT:uint = 3,
			DIR_RIGHT:uint = 4,
			
			menuMusic:Sfx = new Sfx(Assets.MUS_MENU),
			gameMusic:Sfx = new Sfx(Assets.MUS_GAME),
			musicOn:Boolean = true,
			soundOn:Boolean = true,
			
			keyEnter:int = Key.ENTER,
			keyUp:int = Key.UP,
			keyDown:int = Key.DOWN,
			keyLeft:int = Key.LEFT,
			keyRight:int = Key.RIGHT,
			keyW:int = Key.W,
			keyA:int = Key.A,
			keyS:int = Key.S,
			keyD:int = Key.D,
			keyM:int = Key.M,
			keyP:int = Key.P,
			keyQ:int = Key.Q,
			keyR:int = Key.R,
			keyE:int = Key.E,
			keySpace:int = Key.SPACE,
			
			cookieCount:int = 2,			
			hud:HUD,			
			player:Player,
			MAX_HEALTH:int = 5,
			START_HEALTH:int = 5,
			curHealth:int = START_HEALTH,
			captureTxt:Text,
			
			muteBtn:Button,
			muteBtnTxt:TextButton,
			pauseBtn:TextButton,
			restartBtn:TextButton,		
			
			paused:Boolean = false,
			pausedScreen:PausedScreen,
			restart:Boolean = false,
			finished:Boolean = false,
			nextLevel:Boolean = false,
			
			TEXT_BTN_NORMAL:uint = 30,
			TEXT_BTN_HOVER:uint = 34,
			
			JUMP_HEIGHT:int = 8,
			MOVEMENT_SPEED:int = 1,
			
			IDLE:int = 0,
			LEFT:int = -1,
			RIGHT:int = 1,
			UP:int = 2,
			DOWN:int = 3,
			
			TRANSITION_FLIP_SCREEN:uint = 0,
			TRANSITION_CIRCLE:uint = 1,
			TRANSITION_STAR:uint = 2,
			TRANSITION_FADE:uint = 3,
			
			// Suggested: Music 55, Sound 85
			DEFAULT_MUSIC_VOLUME:Number = 0.55,
			DEFAULT_SFX_VOLUME:Number = 0.85 ,
			DEFAULT_VOICE_VOLUME:Number = 1,
			PAUSED_MUSIC_VOLUME:Number = 0.15,
			LEVEL_COMPLETE_VOLUME:Number = 0.15,
			PAUSE_VOLUME:Number = 0.10,
			
			onMovingPlatform:Boolean = false,
			
			musicVolume:Number = DEFAULT_MUSIC_VOLUME,
			soundVolume:Number = DEFAULT_SFX_VOLUME,
			
			ANIMAL_TYPE:String = "ANIMAL",
			DART_TYPE:String = "DART_TYPE",
			DIRECTION_SIGN_TYPE:String = "DIRECTION_SIGN",
			ENEMY_TYPE:String = "ENEMY",
			GROUND_TYPE:String = "GROUND",
			PLANT_LIFE_TYPE:String = "PLANT",
			PLAYER_TYPE:String = "PLAYER",
			SLEEPING_ANIMAL_TYPE:String = "SLEEPING_ANIMAL",
			SOLID_TYPE:String = "SOLID",

			SHARED_OBJECT:String = "NOW_HIRING_ZOO_EB_SO",
			shared:SharedObject;
			
		public static const grid:int = 30;
	}
}
