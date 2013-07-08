package components.map
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import components.interfaces.IUpdatable;
	
	public class MapView extends Sprite implements IUpdatable
	{
		private var mBottom:Sprite;
		private var mUnderEffect:Sprite;//底部特效层
		private var mSwap:Sprite;//交换层
		private var mUpperEffct:Sprite;//顶部特效层
		private var mLandform:DisplayObject;
		private var mMapW:Number;
		private var mMapH:Number;
		private var mElements:Vector.<DisplayObject>;//所有的交换元素
		private var mSwapElements:Vector.<DisplayObject>;//当前帧需要交换的元素
		
		public function MapView()
		{
			mBottom = new Sprite();
			mUnderEffect = new Sprite();
			mSwap = new Sprite();
			mUpperEffct = new Sprite();
			addChild(mBottom);
			addChild(mUnderEffect);
			addChild(mSwap);
			addChild(mUpperEffct);
			
			mouseChildren = false;
			mouseEnabled = false;
			
			mElements = new Vector.<DisplayObject>();
		}
		/**
		 * 
		 * 后面要考虑大对象集中销毁的性能影响，将其在时间上分散开来销毁
		 */
		public function clearBottom():void
		{
			removeChild(mBottom);
		}
		
		public function addElement(element:DisplayObject):DisplayObject
		{
			mElements.push(element);
			return mSwap.addChild(element);
		}
		
		public function removeElement(element:DisplayObject):DisplayObject
		{
			var i:int= mElements.indexOf(element);
			mElements.splice(i,1);
			return mSwap.removeChild(element);
		}
		
		public function rebuild():void
		{
			mSwapElements = new Vector.<DisplayObject>();
		}
		
		public function addSwapElement(element:DisplayObject):DisplayObject
		{
			mSwapElements.push(element);
			return element;
		}
		
		public function update(delta:uint):void
		{
			mSwapElements.sort(sortElements);
			var count:uint = mSwapElements.length;
			//to do 将深度排序放在多个帧中执行
			for(var i:uint=0;i<count;++i)
			{
				mSwap.setChildIndex(mSwapElements[i],i);
			}
		}
		
		private function sortElements(A:DisplayObject,B:DisplayObject):int
		{
			if(A.y>B.y)
			{
				return 1;
			}
			else if(A.y<B.y)
			{
				return -1;
			}
			else
			{
				return 0;
			}
		}
		
		public function get bottom():Sprite
		{
			return mBottom;
		}
		
		public function get swapLayer():Sprite
		{
			return mSwap;
		}
		
		public function set landform(v:DisplayObject):void
		{
			mLandform = v;
		}
		
		public function get landform():DisplayObject
		{
			return mLandform;
		}
		
		public function get underEffect():Sprite
		{
			return mUnderEffect;
		}
		
		public function get upperEffect():Sprite
		{
			return mUpperEffct;
		}
		
		public function get mapWidth():Number
		{
			return mMapW;
		}
		
		public function get mapHeight():Number
		{
			return mMapH;
		}
	}
}