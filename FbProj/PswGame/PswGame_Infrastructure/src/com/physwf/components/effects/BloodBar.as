package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class BloodBar extends Effect
	{
		private var shape:Shape;
		
		public function BloodBar(layer:Sprite,target:DisplayObject)
		{
			drawBottom();
			drawShape();
			super(layer,0,target);
		}
		
		public function set progress(v:Number):void
		{
			if(v<0) 
			{
				v=0;
				mLayer.removeChild(this);
			}
			shape.scaleX = v;
			
		}
		
		override public function update():void
		{
			x = mTarget.x;
			y = mTarget.y - mTarget.height;
		}
		
		private function drawBottom():void
		{
			graphics.beginFill(0,1);
			graphics.drawRect(0,0,100,8);
			graphics.endFill();
		}
		
		private function drawShape():void
		{
			shape = new Shape();
			shape.x = 1;
			shape.y = 1;
			shape.graphics.beginFill(0xFF0000,1);
			shape.graphics.drawRect(0,0,98,6);
			shape.graphics.endFill();
			addChild(shape);
		}
	}
}