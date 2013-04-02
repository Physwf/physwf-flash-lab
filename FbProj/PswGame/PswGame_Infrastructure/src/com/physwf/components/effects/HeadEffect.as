package com.physwf.components.effects
{
	import com.physwf.components.bitmap.display.BitmapFrame;
	import com.physwf.components.bitmap.display.BitmapPlayer;
	import com.physwf.components.bitmap.events.PackageEvent;
	import com.physwf.components.bitmap.net.SkeletonLoader;
	import com.physwf.components.ui.SpriteLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import mx.messaging.AbstractConsumer;
	import mx.states.OverrideBase;

	/**
	 * 角色头顶的特效,现有包括血条,昵称,后期加入头衔 门牌等显示
	 * @author joe
	 * 
	 */	
	public class HeadEffect extends Effect
	{
		public static const NPC_DIR:String = "resource/ui/npc";
		public static const NPC_QUES_MARK:String = "complete";
		public static const NPC_EXCL_MARK:String = "accept";
		public static const NPC_QUES_MARK_GRAY:String = "process";
		
		private var mNpcStatus:uint = 3;
		private var mNpcMark:BitmapPlayer;
		
		private var mTxtName:TextField;
		
		private var mShape:Shape;
		private var mData:*;
		private const BL:Number = 1/100;
		
		public function HeadEffect(layer:Sprite, life:uint, source:DisplayObject=null, target:DisplayObject=null)
		{
			super(layer, life, source, target);
		}
		
		public function setName(name:String):void
		{
			mTxtName ||= new TextField();
			mTxtName.mouseEnabled = false;
			mTxtName.selectable = false;
			mTxtName.autoSize = "left";
			mTxtName.multiline = false;
			mTxtName.text = name;
			mTxtName.y = -20;
			mTxtName.x = -mTxtName.width * .5
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
			hpMax = hpMax == 0 ? 1000 : hpMax;
			var prog:uint = (hp / hpMax) * 100;
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
			
			mShape.x = -mShape.width * .5;
		}
		
		public function setNPCStatus(status:uint):void
		{
			if(mNpcStatus <= status) return;
			mNpcStatus = status;
			if(mNpcStatus == 3)
			{
				mNpcMark.bitmapData && mNpcMark.bitmapData.dispose();
				mNpcMark.bitmapData.dispose();
				return;
			}
			else if(mNpcStatus == 2)
			{
				var markAsset:String = NPC_EXCL_MARK;
			}
			else if(mNpcStatus == 1)
			{
				markAsset = NPC_QUES_MARK;
			}
			var sLoader:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader(NPC_DIR);
			var effect:Sprite = this;
			function onComplete(e:Event):void 
			{
				sLoader.removeEventListener(PackageEvent.PACKAGE_ALL_INITED,onComplete);
				var action:Vector.<BitmapFrame> = sLoader.getAction(markAsset,"1");
				mNpcMark ||= new BitmapPlayer();
				mNpcMark.bitmapFrames = action;
				mNpcMark.x = - mNpcMark.width * .5; 
				mNpcMark.y = 20; 
				if(!effect.contains(mNpcMark))
				{
					effect.addChild(mNpcMark);
				}
			}
			sLoader.addEventListener(PackageEvent.PACKAGE_ALL_INITED,onComplete);
			sLoader.load();
		}
		
		override public function update():void
		{
			if(visible)
			{
				x = mTarget.x;
				y = mTarget.y -  mTarget.height - 10;//暂时先用显示对象的高度 后面要改成配置中的高度
				mNpcMark && mNpcMark.nextFrame();
			}
		}
		
	}
}