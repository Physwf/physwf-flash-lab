package com.physwf.components.ui.controls
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.assets.CellAssets;
	import com.physwf.components.utils.AlgebraUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class Cell extends Sprite implements IUpdatable,IDisposible
	{
		public static const STATE_UP:uint = 0;
		public static const STATE_OVER:uint = 1;
		public static const STATE_DOWN:uint = 2;
		
		public static const LOCATION_SKILLBAR:String = "l_s";
		public static const LOCATION_BAG:String = "l_b";
		
		public static var shareCdTime:uint = 2000;//公共cd时间
		
		public var data:*;//格子所对应的数据
		public var location:String;//格子所属的位置 如背包，技能栏等,其值为LOCATION_SKILLBAR，LOCATION_BAG
		public var cdTime:uint;
		
		private var mBg:Bitmap;
		private var mContent:Bitmap;
		private var mCdShape:Shape;
		private var mStateView:Bitmap;
		
		private var assets:CellAssets;
		
		private var mState:uint = STATE_UP;
		
		private var mCdTime:uint;//cd时间
		private var mTime:uint;//cd计时
		private var sHelpPoint:Point;
		private var mIsCding:Boolean = false;
		private var sHelpTime:uint;
		
		public function Cell(assets:CellAssets)
		{
			this.assets = assets;
			
			mBg = new Bitmap();
			addChild(mBg);
			
			mContent = new Bitmap();
			addChild(mContent);
			
			mCdShape = new Shape();
			mCdShape.x = assets.size * .5;
			mCdShape.y = assets.size * .5;
			addChild(mCdShape);
			
			mStateView = new Bitmap();
			addChild(mStateView);
			configListeners();
		}
		
		private function configListeners():void
		{
			addEventListener(MouseEvent.MOUSE_OVER,onMouseEvent,false,Number.POSITIVE_INFINITY,false);
			addEventListener(MouseEvent.MOUSE_OUT,onMouseEvent,false,Number.POSITIVE_INFINITY,false);
			
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseEvent,false,Number.POSITIVE_INFINITY,false);
			addEventListener(MouseEvent.MOUSE_UP,onMouseEvent,false,Number.POSITIVE_INFINITY,false);
		}
		
		private function onMouseEvent(e:MouseEvent):void
		{
			switch(e.type)
			{
				case MouseEvent.MOUSE_OVER:
					mState = STATE_OVER;
					break;
				case MouseEvent.MOUSE_OUT:
					mState = STATE_UP;
					break;
				case MouseEvent.MOUSE_DOWN:
					mState = STATE_DOWN;
					break;
				case MouseEvent.MOUSE_UP:
					mState = STATE_OVER;
					break;
			}
		}
		
		public function set contentData(v:BitmapData):void
		{
			mContent.bitmapData = v;
			mContent.width = mContent.height = assets.size;
		}
		
		public function get content():Bitmap
		{
			return mContent;
		}
		
		public function startCd():void
		{
			mCdTime = cdTime;
			sHelpTime = getTimer();
			mTime = 0;
			mIsCding = true;
			sHelpPoint = new Point(0,0);
		}
		
		public function startShareCd():void
		{
			mCdTime = shareCdTime;
			sHelpTime = getTimer();
			mTime = 0;
			mIsCding = true;
			sHelpPoint = new Point(0,0);
		}
		
		public function isCding():Boolean
		{
			return mIsCding;
		}
		
		public function update():void
		{
			if(mBg.bitmapData != assets.bg)
			{
				mBg.bitmapData = assets.bg;
			}
			switch(mState)
			{
				case STATE_UP:
					if(mStateView.bitmapData != assets.upstate)
					{
						mStateView.bitmapData = assets.upstate;
					}
					break;
				case STATE_OVER:
					if(mStateView.bitmapData != assets.overstate)
					{
						mStateView.bitmapData = assets.overstate;
					}
					break;
				case STATE_DOWN:
					if(mStateView.bitmapData != assets.downstate)
					{
						mStateView.bitmapData = assets.downstate;
					}
					break;
			}
			
			if(!mIsCding) return;
			const R:uint = 15;
			
			
			mTime += (getTimer() - sHelpTime);
			sHelpTime = getTimer();
			var r:Number = (mTime / mCdTime) * Math.PI * 2;
			var p:Point = AlgebraUtils.radToCoord(r);
			mCdShape.graphics.clear();
			mCdShape.graphics.moveTo(0,0);
			mCdShape.graphics.beginGradientFill(GradientType.RADIAL,[0,0],[0.5,0.5],[0,255]);
			if(r<Math.PI * .25)
			{
				mCdShape.graphics.lineTo(0,-R);
				mCdShape.graphics.lineTo(-R,-R);
				mCdShape.graphics.lineTo(-R,R);
				mCdShape.graphics.lineTo(R,R);
				mCdShape.graphics.lineTo(R,-R);
				mCdShape.graphics.lineTo(p.x*R,p.y*R);
			}
			else if(r>=Math.PI * .25 && r < Math.PI * .75)
			{
				mCdShape.graphics.lineTo(0,-R);
				mCdShape.graphics.lineTo(-R,-R);
				mCdShape.graphics.lineTo(-R,R);
				mCdShape.graphics.lineTo(R,R);
				mCdShape.graphics.lineTo(p.x*R,p.y*R);
			}
			else if(r >= Math.PI * .75 && r < Math.PI * 1.25)
			{
				mCdShape.graphics.lineTo(0,-R);
				mCdShape.graphics.lineTo(-R,-R);
				mCdShape.graphics.lineTo(-R,R);
				mCdShape.graphics.lineTo(p.x*R,p.y*R);
			}
			else if(r >= Math.PI * 1.25 && r < Math.PI * 1.75)
			{
				mCdShape.graphics.lineTo(0,-R);
				mCdShape.graphics.lineTo(-R,-R);
				mCdShape.graphics.lineTo(p.x*R,p.y*R);
			}
			else if(r >= Math.PI * 1.75 && r < Math.PI * 2)
			{
				mCdShape.graphics.lineTo(0,-R);
				mCdShape.graphics.lineTo(p.x*R,p.y*R);
			}
			else
			{
				mCdShape.graphics.clear();
			}
			
			if(mTime >= mCdTime)
			{
				mCdShape.graphics.clear();
				mIsCding = false;
			}
		}
		
		public function destroy():void
		{
			
		}
	}
}