package com.hiring 
{
	/**
	 * 
	 * @author Eric Bernier <http://www.ericbernier.com>
	 */
	public class Assets
	{	
		// Embed the levels
		[Embed(source = '../assets/levels/Level1.oel',  mimeType = "application/octet-stream")] public static const LEVEL1:Class;
		[Embed(source = '../assets/levels/Level2.oel',  mimeType = "application/octet-stream")] public static const LEVEL2:Class;
		[Embed(source = '../assets/levels/Level3.oel',  mimeType = "application/octet-stream")] public static const LEVEL3:Class;
		[Embed(source = '../assets/levels/Level4.oel',  mimeType = "application/octet-stream")] public static const LEVEL4:Class;
		[Embed(source = '../assets/levels/Level5.oel',  mimeType = "application/octet-stream")] public static const LEVEL5:Class;
		[Embed(source = '../assets/levels/Level6.oel',  mimeType = "application/octet-stream")] public static const LEVEL6:Class;
		[Embed(source = '../assets/levels/Level7.oel',  mimeType = "application/octet-stream")] public static const LEVEL7:Class;
		[Embed(source = '../assets/levels/Level8.oel',  mimeType = "application/octet-stream")] public static const LEVEL8:Class;
		
		public static const LEVELS:Array = new Array(LEVEL1, LEVEL2, LEVEL3, LEVEL4, LEVEL5,
				LEVEL6, LEVEL7, LEVEL8);
		
		// TitleWorld art and logos
		[Embed(source = '../assets/graphics/ebLogo.png')] public static const EB_LOGO:Class;
		[Embed(source = '../assets/graphics/titleBg.png')] public static const TITLE_BG:Class;
		[Embed(source = '../assets/graphics/titleLogo.png')] public static const TITLE_LOGO:Class;
		[Embed(source = '../assets/graphics/credits.png')] public static const TITLE_CREDITS_BG:Class;
		[Embed(source = '../assets/graphics/buffer.png')] public static const TITLE_BUFFER:Class;
		[Embed(source = '../assets/graphics/titleLion.png')] public static const TITLE_LION:Class;
		[Embed(source = '../assets/graphics/zooBg.png')] public static const TITLE_ZOO_BG:Class;
		
		// Ending
		[Embed(source = '../assets/graphics/endingScreen.png')] public static const END_SCREEN:Class;
		
		// Tilesets	
		[Embed(source = '../assets/graphics/tileset.png')] public static const TILESET_WORLD:Class;
		
		// Gameworld graphics
		[Embed(source = '../assets/graphics/mute.png')] public static const MUTE_BTN:Class;
		[Embed(source = '../assets/graphics/unmute.png')] public static const UNMUTE_BTN:Class;
		[Embed(source = '../assets/graphics/sign.png')] public static const DIR_SIGN:Class;
		[Embed(source = '../assets/graphics/dirBg.png')] public static const DIR_BG:Class;
		[Embed(source = '../assets/graphics/bush.png')] public static const BUSH:Class;
		[Embed(source = '../assets/graphics/tree.png')] public static const TREE:Class;
		
		// Objects     
		[Embed(source = '../assets/graphics/cookie.png')] public static const COOKIE:Class;

		// Collectables
		
		// HUD
		[Embed(source = '../assets/graphics/hudHeart.png')] public static const HUD_HEART:Class;
		[Embed(source = '../assets/graphics/hudHeartEmpty.png')] public static const HUD_HEART_EMPTY:Class;
		[Embed(source = '../assets/graphics/hudLife.png')] public static const HUD_LIFE:Class;
		[Embed(source = '../assets/graphics/hudDart.png')] public static const HUD_DART:Class;
		[Embed(source = '../assets/graphics/hudCookie.png')] public static const HUD_COOKIE:Class;
		
		// Player
		[Embed(source = '../assets/graphics/player.png')] public static const PLAYER:Class;
		[Embed(source = '../assets/graphics/dart.png')] public static const DART:Class;
		[Embed(source = '../assets/graphics/dartUp.png')] public static const DART_UP:Class;
		
		// Enemies
		[Embed(source = '../assets/graphics/monkeySprite.png')] public static const ENEMY_MONKEY:Class;
		[Embed(source = '../assets/graphics/tigerSprite.png')] public static const ENEMY_TIGER:Class;
		
		// Music
		[Embed(source = '../assets/music/HappyWalk.mp3')] public static const MUS_GAME:Class;
		[Embed(source = '../assets/music/ChoroBavario.mp3')] public static const MUS_MENU:Class;
		
		// Sound
		[Embed(source = '../assets/sound/buttonSelect.mp3')] public static const SND_BUTTON_BACK:Class;
		[Embed(source = '../assets/sound/buttonHover.mp3')] public static const SND_BUTTON_HOVER:Class;
		[Embed(source = '../assets/sound/buttonSelect.mp3')] public static const SND_BUTTON_SELECT:Class;
		[Embed(source = '../assets/sound/hurt.mp3')] public static const SND_HURT:Class;
		[Embed(source = '../assets/sound/animalHurt.mp3')] public static const SND_ANIMAL_HURT:Class;
		[Embed(source = '../assets/sound/dartShoot.mp3')] public static const SND_DART_SHOOT:Class;
		[Embed(source = '../assets/sound/nextLevel.mp3')] public static const SND_NEXT_LEVEL:Class;
		[Embed(source = '../assets/sound/captureAnimal.mp3')] public static const SND_CAPTURE_ANIMAL:Class;
		[Embed(source = '../assets/sound/powerup.mp3')] public static const SND_POWERUP:Class;
		[Embed(source = '../assets/sound/dropCookie.mp3')] public static const SND_DROP_COOKIE:Class;
	}
}