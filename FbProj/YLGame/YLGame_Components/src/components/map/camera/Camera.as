package components.map.camera
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import components.map.MapView;
	
	public class Camera
	{
		private var mViewprot:Rectangle;
		private var mFocus:Rectangle;
		private var mMap:MapView;
		private var mTarget:DisplayObject;
		private var sHalfW:uint;
		private var sHalfH:uint;
		private var sHelpW:uint=0;
		private var sHelpH:uint=0;
		private var mTrackEnabled:Boolean;
		private var mEasying:Number = .2;//缓动系数
		private var mX:uint=0;
		private var mY:uint=0;
		
		private var percentX:Number = .5;
		
		public function Camera(viewport:Rectangle)
		{
			mViewprot = viewport;
			mFocus = new Rectangle(viewport.width * percentX,viewport.height * percentX,viewport.width * (1-2*percentX),viewport.height * (1-2*percentX));
			sHalfW = mViewprot.width * .5;
			sHalfH = mViewprot.height * .5;
			sHelpW = mFocus.width * .5;
			sHelpH = mFocus.height * .5;
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
				mFocus.x = mViewprot.width  * percentX + x;
				mFocus.y = mViewprot.height * percentX + y;
//				mMap.scrollRect = mViewprot;  //scrollRect方法太低效了
				mMap.x = -x;
				mMap.y = -y;
			}
		}
		/**
		 * 将目标尽量移动到摄像机中央。 
		 * 
		 */		
		public function moveToTarget():void
		{
			if(!mTrackEnabled) return;
			//计算x方向的滚动			
			if(mTarget.x <= sHalfW)// 目标靠近左边界
			{
				mX = 0;
			}
			else if((mMap.mapWidth - mTarget.x) <= sHalfW) //目标靠近右边界
			{
				mX = mMap.mapWidth - mViewprot.width;
			}
			else if(mTarget.x > mFocus.right)
			{
				mX = mTarget.x - mFocus.width * .5;
			}
			else// 其他情况
			{
				mX = mTarget.x - sHalfW;
			}
			//计算y方向的滚动
			if(mTarget.y <= sHalfH)//目标靠近上边界
			{
				mY = 0;
			}
			else if((mMap.mapHeight - mTarget.y) <= sHalfH)//目标靠近下边界
			{
				mY = mMap.mapHeight - mViewprot.height;
			}
			else if(mTarget.y > mFocus.bottom)
			{
				mY = mTarget.y - mFocus.height * .5;
			}
			else//其他情况
			{
				mY = mTarget.y - sHalfH;
			}
			moveTo(mX,mY);
		}
		
		public function shake():void
		{
			
		}
		/**
		 * 更新视口。
		 * 如果在焦点区域内(mFocus内),则摄像机保持静止。否则跟随。 
		 * 
		 */		
		public function update():void
		{
			var tx:uint,ty:uint;
			if(!mTrackEnabled) return;
			//计算x方向的滚动			
			if(mTarget.x <= sHalfW - sHelpW)// 目标靠近左边界
			{
				tx = 0;
			}
			else if((mMap.mapWidth - mTarget.x) <= sHalfW - sHelpW) //目标靠近右边界
			{
				tx = mMap.mapWidth - mViewprot.width;
			}
			else if(mTarget.x > mFocus.right)
			{
				tx = mTarget.x - (sHalfW + mFocus.width * .5);
			}
			else if(mTarget.x < mFocus.left)
			{
				tx = mTarget.x - (sHalfW - mFocus.width * .5 ) ;
			}
			else
			{
				tx = mViewprot.x;
			}
			//计算y方向的滚动
			if(mTarget.y <= sHalfH - sHelpH)//目标靠近上边界
			{
				ty = 0;
			}
			else if((mMap.mapHeight - mTarget.y) <= sHalfH - sHelpH)//目标靠近下边界
			{
				ty = mMap.mapHeight - mViewprot.height;
			}
			else if(mTarget.y > mFocus.bottom)
			{
				ty = mTarget.y - (sHalfH + mFocus.height * .5);
			}
			else if(mTarget.y < mFocus.top)
			{
				ty = mTarget.y - (sHalfH - mFocus.height * .5);
			}
			else
			{
				ty = mViewprot.y;
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