package com.physwf.components.effects
{
	import com.physwf.components.charactor.enum.ISODirection;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * 暗黑特效 
	 * @author joe
	 * 
	 */	
	public class DiabloEffect extends Effect
	{
		private var mEffects:Vector.<Vector.<EffectFrame>>;
		private var mSpeed:uint = 5;
		
		public function DiabloEffect(layer:Sprite, life:uint, target:DisplayObject=null)
		{
			super(layer, life, target);
		}
		
		public function setEffects(effects:Vector.<Vector.<EffectFrame>>):void
		{
			mEffects = effects;
		}
		
		override public function update():void
		{
			var distX:int = mTarget.x - x;
			var distY:int = mTarget.y - y - 30;
			var rad:Number = Math.atan2(distY,distX);
			var direct:int = ISODirection.radianToDirect(rad);
			
			setFrames(mEffects[direct]);
			
			x += mSpeed * Math.cos(rad);
			y += mSpeed * Math.sin(rad);
			
			mCurFrame = mFrames[mCurFrameNum];
			mContent.x = mCurFrame.x;
			mContent.y = mCurFrame.y;
			mContent.bitmapData = mCurFrame.frameData;
			mCurFrameNum++;
			if(mCurFrameNum>=mTotalFrame)
			{
				mCurFrameNum = 0;
			}
			if(distX*distX + distY*distY < 3)
			{
				mLayer.removeChild(this);
				effects.splice(effects.indexOf(this),1);;
			}
		}
	}
}