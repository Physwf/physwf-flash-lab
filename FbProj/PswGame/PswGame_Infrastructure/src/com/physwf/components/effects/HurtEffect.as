package com.physwf.components.effects
{
	import com.physwf.components.text.BitmapText;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	public class HurtEffect extends Effect
	{
		private var mDirc:Number;
		private var mText:BitmapText;
		
		public function HurtEffect(layer:Sprite, life:uint, source:DisplayObject=null, target:DisplayObject=null)
		{
			mDirc = (Math.random() * 2 -1) * Math.PI;
			super(layer, life, source, target);
		}
		
		public function setHurt(v:uint,style:String):void
		{
			mText = new BitmapText(style);
			mText.text = "-"+String(v);
			mText.scaleX = mText.scaleY = 0;
			addChild(mText);
			mBornTime = getTimer();
		}
		
		override public function update():void
		{
			var per:Number = (getTimer() - mBornTime) / mLife;
			x = mTarget.x;
			y = mTarget.y - 70;
			var factor:Number = Math.min(1,per);
			mText.x += 10 * Math.cos(mDirc) * (1-factor);
			mText.y += 10 * Math.sin(mDirc) * (1-factor);
			mText.scaleX = mText.scaleY = Math.min(1,per);
			if(per>1)
			{
				trace("hurtted");
				mText.bitmapData && mText.bitmapData.dispose();
				mLayer.removeChild(this);
				effects.splice(effects.indexOf(this),1);;
			}
		}
	}
}