package com.physwf.uicomponets.containers
{
	import com.physwf.uicomponets.Component;
	
	import flash.display.Bitmap;

	public class Panel extends Component
	{
		//九宫格 顺序为从左到右 从上到下
		private var nineGrid:Vector.<Bitmap>;
		private var mWidth:Number = 0;
		private var mHeight:Number = 0;
		
		public function Panel(w:Number,h:Number)
		{
			mWidth = w; mHeight = h;
			mouseEnabled = false;
			mouseChildren = false;
			nineGrid = new Vector.<Bitmap>(9,true);
		}
		
		override protected function init():void
		{
			var grid:Bitmap;
			for(var i:uint=0;i<9;++i)
			{
				grid = new Bitmap();
				grid.bitmapData = mTexture;
				grid.scrollRect = mTexCoords[i];
				nineGrid[i] = grid;
				addChild(grid);
			}
			update9Grid();
		}
		
		override public function set width(value:Number):void
		{
			if(mWidth != value)
			{
				mWidth = value;
				update9Grid();
			}
		}
		
		override public function get width():Number
		{
			return mWidth;
		}
		
		override public function set height(value:Number):void
		{
			if(mHeight != value)
			{
				mHeight = value;
				update9Grid();
			}
		}
		
		override public function get height():Number
		{
			return mHeight;
		}
		
		private function update9Grid():void
		{
			var _wL:Number = mTexCoords[0].width;
			var _wR:Number = mTexCoords[2].width;
			var _hT:Number = mTexCoords[2].height;
			var _hB:Number = mTexCoords[6].height;
			var _wM:Number = mWidth - _wL - _wR;
			var _hM:Number = mHeight - _hT - _hB;
			
			nineGrid[1].x = _wL;
			nineGrid[1].width = _wM;
			
			nineGrid[2].x = _wL + _wM;
			
			nineGrid[3].y = _hT;
			nineGrid[3].height = _hM;
			
			nineGrid[4].x = _wL;
			nineGrid[4].y = _hT;
			nineGrid[4].width = _wM;
			nineGrid[4].height = _hM;
			
			nineGrid[5].x = _wL + _wM;
			nineGrid[5].y = _hT;
			nineGrid[5].height = _hM;
			
			nineGrid[6].y = _hT + _hM;
			
			nineGrid[7].x = _wL;
			nineGrid[7].y = _hT + _hM;
			nineGrid[7].width = _wM;
			
			nineGrid[8].x = _wL+_wM;
			nineGrid[8].y = _hT + _hM;
		}
	}
}