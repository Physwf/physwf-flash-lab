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
		protected var mEffects:Vector.<Vector.<EffectFrame>>;
		protected var mSpeed:uint = 5;
		private var mDirectFun:Function;
		
		public function DiabloEffect(layer:Sprite, life:uint, target:DisplayObject=null)
		{
			super(layer, life, target);
		}
		
		public function setEffects(effects:Vector.<Vector.<EffectFrame>>):void
		{
			mEffects = effects;
			if(mEffects.length==8)
			{
				mDirectFun = ISODirection.radianToDirect8;
			}
			else if(mEffects.length==16)
			{
				mDirectFun = ISODirection.radianToDirect16;
			}
		}
		
		override public function update():void
		{
		}
	}
}