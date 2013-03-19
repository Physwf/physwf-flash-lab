package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class BloodBar extends Effect
	{
		private var shape:Shape;
		private var mData:*;
		private const BL:Number = 2/100;
		
		public function BloodBar(layer:Sprite,target:DisplayObject,data:*)
		{
			drawBottom();
			drawShape();
			mData = data;
			super(layer,0,null,target);
		}

		public function setProgress(hp:uint,hpMax:uint):void
		{
			var prog:uint = (hp  / 2000) * 100;
			if(prog<=0) 
			{
				prog=0;
				mData = null;
				mLayer.removeChild(this);
			}
			shape.scaleX = prog/100;
			var n:Number = BL * prog;
			var p:Number = n - Math.floor(n);
			var color:uint = ( 0xFF * (1-p) << 16 ) + ( 0xFF * p << 8 );
			shape.graphics.clear();
			shape.graphics.beginFill(color,1);
			shape.graphics.drawRect(0,0,98,6);
			shape.graphics.endFill();
		}
		
		override public function update():void
		{
			x = mTarget.x - width * .5;
			y = mTarget.y -  mTarget.height - 10;//暂时先用显示对象的高度 后面要改成配置中的高度
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