package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import mx.states.OverrideBase;

	/**
	 * 角色头顶的特效,现有包括血条,昵称,后期加入头衔 门牌等显示
	 * @author joe
	 * 
	 */	
	public class HeadEffect extends Effect
	{
		private var mTxtName:TextField;
		
		private var mShape:Shape;
		private var mData:*;
		private const BL:Number = 2/100;
		
		public function HeadEffect(layer:Sprite, life:uint, source:DisplayObject=null, target:DisplayObject=null)
		{
			super(layer, life, source, target);
		}
		
		public function setName(name:String):void
		{
			mTxtName ||= new TextField();
			mTxtName.mouseEnabled = false;
			mTxtName.selectable = false;
			mTxtName.autoSize = "center";
			mTxtName.text = name;
			mTxtName.y = -20;
			addChild(mTxtName);
		}
		
		public function hide():void
		{
			mLayer.removeChild(this);
			effects.splice(effects.indexOf(this),1);
		}
		
		public function show():void
		{
			if(mLayer.contains(this)) return;
			mLayer.addChild(this);
			effects.push(this);
		}
		
		public function setProgress(hp:uint,hpMax:uint):void
		{
			var prog:uint = (hp  / 2000) * 100;
			if(prog<=0) 
			{
				prog=0;
				mData = null;
				removeChild(mShape);
			}
			var n:Number = BL * prog;
			var p:Number = n - Math.floor(n);
			var color:uint = ( 0xFF * (1-p) << 16 ) + ( 0xFF * p << 8 );
			//draw bottom
			mShape ||= (addChild(new Shape()) as Shape);
			mShape.graphics.clear();
			mShape.graphics.beginFill(0,1);
			mShape.graphics.drawRect(0,0,100,8);
			mShape.graphics.endFill();
			
			mShape.graphics.beginFill(color,1);
			mShape.graphics.drawRect(1,1,98*prog/100,6);
			mShape.graphics.endFill();
		}
		
		override public function update():void
		{
			if(visible)
			{
				x = mTarget.x - width * .5;
				y = mTarget.y -  mTarget.height - 10;//暂时先用显示对象的高度 后面要改成配置中的高度
			}
		}
		
	}
}