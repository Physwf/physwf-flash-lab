package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class TargetEffect extends Effect
	{
		public function TargetEffect(layer:Sprite, life:uint, source:DisplayObject=null, target:DisplayObject=null)
		{
			graphics.lineStyle(2,0xFF0000);
			graphics.drawEllipse(-40,-20,80,40);
			graphics.endFill();
			super(layer, life, source, target);
		}
		
		public function changeTarget(target:DisplayObject):void
		{
			mTarget = target;
			
			if(mLayer.contains(this)) return;
			mLayer.addChild(this);
			effects.push(this);
		}
		
		public function hide():void
		{
			mLayer.removeChild(this);
			effects.splice(effects.indexOf(this),1);
		}
		
		override public function update():void
		{
			if(mTarget)
			{
				x = mTarget.x;
				y = mTarget.y;
			}
		}
	}
}