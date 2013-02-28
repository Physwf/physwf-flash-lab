package com.physwf.components.map.camera
{
	import com.physwf.components.map.MapView;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public class Camera
	{
		private var mViewprot:Rectangle;
		private var mMap:MapView;
		private var mTarget:DisplayObject;
		private var sHelpW:uint;
		private var sHelpH:uint;
		private var mTrackEnabled:Boolean;
		private var mEasying:Number = 0.2;//缓动系数
		private var mX:uint=0;
		private var mY:uint=0;
		
		public function Camera(viewport:Rectangle)
		{
			mViewprot = viewport;
			sHelpW = mViewprot.width * .5;
			sHelpH = mViewprot.height * .5;
			mTrackEnabled = true;
		}
		
		public function initialize(map:MapView):void
		{
			mMap = map;
		}
		
		public function set target(v:DisplayObject):void
		{
			mTarget = v;
		}
		
		public function set trackEnabled(v:Boolean):void
		{
			mTrackEnabled = v;
		}
		
		public function moveTo(x:uint, y:uint):void
		{
			if(mViewprot.x != x || mViewprot.y != y)
			{
				mViewprot.x = x;
				mViewprot.y = y;
				mMap.scrollRect = mViewprot;
			}
		}
		
		public function moveToTarget():void
		{
			if(!mTrackEnabled) return;
			//计算x方向的滚动			
			if(mTarget.x <= sHelpW)// 目标靠近左边界
			{
				mX = 0;
			}
			else if((mMap.mapWidth - mTarget.x) <= sHelpW) //目标靠近右边界
			{
				mX = mMap.mapWidth - mViewprot.width;
			}
			else// 其他情况
			{
				mX = mTarget.x - sHelpW;
			}
			//计算y方向的滚动
			if(mTarget.y <= sHelpH)//目标靠近上边界
			{
				mY = 0;
			}
			else if((mMap.mapHeight - mTarget.y) <= sHelpH)//目标靠近下边界
			{
				mY = mMap.mapHeight - mViewprot.height;
			}
			else//其他情况
			{
				mY = mTarget.y - sHelpH;
			}
			moveTo(mX,mY);
		}
		
		public function shake():void
		{
			
		}
		
		public function update():void
		{
			var tx:uint,ty:uint;
			if(!mTrackEnabled) return;
			//计算x方向的滚动			
			if(mTarget.x <= sHelpW)// 目标靠近左边界
			{
				tx = 0;
			}
			else if((mMap.mapWidth - mTarget.x) <= sHelpW) //目标靠近右边界
			{
				tx = mMap.mapWidth - mViewprot.width;
			}
			else// 其他情况
			{
				tx = mTarget.x - sHelpW;
			}
			//计算y方向的滚动
			if(mTarget.y <= sHelpH)//目标靠近上边界
			{
				ty = 0;
			}
			else if((mMap.mapHeight - mTarget.y) <= sHelpH)//目标靠近下边界
			{
				ty = mMap.mapHeight - mViewprot.height;
			}
			else//其他情况
			{
				ty = mTarget.y - sHelpH;
			}
			//后面考虑将摄像机跟随设计具有自己的固定速度
			var dx:int = tx-mX;
			var dy:int = ty-mY;
			mX += dx * mEasying;
			mY += dy * mEasying;
			moveTo(mX,mY);
		}
		
		public function get viewprot():Rectangle
		{
			return mViewprot;
		}

	}
}