package com.hiring.util
{
	import com.greensock.TweenMax;
	
	import com.hiring.Assets;
	import com.hiring.Global;
	
	import net.flashpunk.graphics.Backdrop;

	
	public class Background extends Backdrop
	{
		public function Background(type:uint = 0)
		{	
			var bg:Class = Assets.DIR_BG;			
			super(bg, true, true);
		}
		
		
		override public function update():void
		{	
			super.update();
		}
	}
}