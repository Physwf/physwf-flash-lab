package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * 角色头顶的名字特效 ,后期加入头衔 门牌等显示
	 * @author joe
	 * 
	 */	
	public class NameEffect extends Effect
	{
		private var mTxtName:TextField;
		
		public function NameEffect(layer:Sprite, life:uint, source:DisplayObject=null, target:DisplayObject=null)
		{
			super(layer, life, source, target);
		}
		
		public function setName(name:String):void
		{
			mTxtName = new TextField();
			mTxtName.mouseEnabled = false;
			mTxtName.selectable = false;
			mTxtName.autoSize = "center";
			mTxtName.text = name;
			addChild(mTxtName);
		}
		
		override public function update():void
		{
			x = mTarget.x - width * .5;
			y = mTarget.y -  mTarget.height - 30;//暂时先用显示对象的高度 后面要改成配置中的高度
		}
	}
}