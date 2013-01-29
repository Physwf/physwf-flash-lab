package com.physwf.engine.bag.view
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.config.PanelConfig;
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.components.ui.factory.CellFactory;
	import com.physwf.components.ui.factory.PanelFactory;
	import com.physwf.components.ui.layout.IPopup;
	import com.physwf.components.ui.layout.Panel;
	import com.physwf.engine.bag.config.BagAssets;
	import com.physwf.system.System;
	import com.physwf.system.vo.BagItemInfo;
	import com.physwf.system.vo.ItemInfo;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class BagView extends Sprite implements IUpdatable,IPopup
	{
		private const NUM_CELL_X:uint = 7;
		private const NUM_CELL_Y:uint = 10;
		private const CELL_SIZE:uint = 34;
		
		private var pFactory:PanelFactory;
		private var cFactory:CellFactory;
		
		private var bgPanel:Panel;
		private var cellLayer:Sprite;
		private var cells:Vector.<Cell>;
		
		private var isShow:Boolean = false;
		
		public function BagView()
		{
			pFactory = new PanelFactory();
			cFactory = new CellFactory();
			
			var config:PanelConfig = BagAssets.PANEL_BAG;
			bgPanel = pFactory.createPanel(config);
			bgPanel.width = 305;
			bgPanel.height = 400;
			
			cellLayer = new Sprite();
			cellLayer.x = 35;
			cellLayer.y = 40;
			createCells();
		}
		
		private function createCells():void
		{
			cells = new Vector.<Cell>();
			var numCells:uint = NUM_CELL_X * NUM_CELL_Y;
			for(var i:uint=0;i<numCells;++i)
			{
				var cell:Cell = cFactory.createCell(BagAssets.CELL_BAG);
				cells.push(cell);
				cell.x = i%NUM_CELL_X * CELL_SIZE;
				cell.y = Math.floor(i/NUM_CELL_X) * CELL_SIZE;
				cellLayer.addChild(cell);
			}
		}
		
		public function update():void
		{
			bgPanel.update();
			for(var i:int=0;i<cells.length;++i)
			{
				cells[i].update();
			}
		}
		
		public function hide():void
		{
			isShow = false;
			removeChild(bgPanel);
			removeChild(cellLayer);
		}
		
		public function show($parent:DisplayObjectContainer):void
		{
			updateContent();
			isShow = true;
			addChild(bgPanel);
			addChild(cellLayer);
		}
		
		public function toggle($parent:DisplayObjectContainer):void
		{
			isShow = !isShow;
			if(isShow)
			{
				show(null);
				$parent.addChild(this);
			}
			else
			{
				hide();
			}
		}
		
		private function updateContent():void
		{
			var items:Vector.<BagItemInfo> = System.bag.bagItems;
			var count:uint = items.length;
			for(var i:int=0;i<count;++i)
			{
				//临时写，后面需要考虑版本控制和加载优化
				trace(items[i].item.itemID);
				var grid:uint = items[i].girdTag;
				var cell:Cell = cells[grid];
				loadIcon(cell,items[i].item.itemID);
			}
		}
		
		private function loadIcon(cell:Cell,iconID:uint):void
		{
			var loader:Loader = new Loader();
			function onComplete(e:Event):void
			{
				var target:LoaderInfo = e.target as LoaderInfo;
				cell.contentData = Bitmap(target.content).bitmapData;
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
			};
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.load(new URLRequest("resource/icons/"+iconID+".jpg"));
		}
	}
}