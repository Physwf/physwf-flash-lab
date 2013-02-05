package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class BloodBar extends Effect
	{
		private var shape:Shape;
		private var mData:*;
		
		public function BloodBar(layer:Sprite,target:DisplayObject,data:*)
		{
			drawBottom();
			drawShape();
			mData = data;
			super(layer,0,target);
		}

		override public function update():void
		{
//			var prog:Number = mData.hp  / mData.hp_max;
			var prog:Number = 10  / 100;
			if(prog<0) 
			{
				prog=0;
				mData = null;
				mLayer.removeChild(this);
			}
			shape.scaleX = prog;
			
			x = mTarget.x - width * .5;
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