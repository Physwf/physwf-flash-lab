package com.physwf.engine.bag.view
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.IconLoader;
	import com.physwf.components.ui.config.PanelConfig;
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.components.ui.factory.CellFactory;
	import com.physwf.components.ui.factory.FactoryManager;
	import com.physwf.components.ui.factory.PanelFactory;
	import com.physwf.components.ui.layout.IPopup;
	import com.physwf.components.ui.layout.Panel;
	import com.physwf.engine.Engine;
	import com.physwf.engine.bag.config.BagAssets;
	import com.physwf.engine.bag.controller.BagController;
	import com.physwf.system.System;
	import com.physwf.system.vo.BagItemInfo;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class BagView extends Sprite implements IUpdatable,IPopup
	{
		private const NUM_CELL_X:uint = 7;
		private const NUM_CELL_Y:uint = 10;
		private const CELL_SIZE:uint = 34;
		
		private const GRID_OFFSET:uint = 1000;
		
		private var bgPanel:Panel;
		private var cellLayer:Sprite;
		
		private var isShow:Boolean = false;
		
		private var controller:BagController;
		
		public function BagView()
		{
			var pFactory:PanelFactory = FactoryManager.panelFactory;
			
			var config:PanelConfig = BagAssets.PANEL_BAG;
			bgPanel = pFactory.createPanel(config);
			bgPanel.width = 305;
			bgPanel.height = 400;
			
			cellLayer = new Sprite();
			cellLayer.x = 35;
			cellLayer.y = 40;
			createCells();
			
			controller = new BagController();
			controller.initialize(this);
		}
		
		private function createCells():void
		{
			var cFactory:CellFactory = FactoryManager.cellFactroy;
			var numCells:uint = NUM_CELL_X * NUM_CELL_Y;
			for(var i:uint=0;i<numCells;++i)
			{
				var cell:Cell = cFactory.createCell(BagAssets.CELL_BAG);
				cell.location = Cell.LOCATION_BAG;
				
				Engine.cm.addBagCell(cell);
				
				cell.x = i%NUM_CELL_X * CELL_SIZE;
				cell.y = Math.floor(i/NUM_CELL_X) * CELL_SIZE;
				cellLayer.addChild(cell);
			}
		}
		
		public function update():void
		{
			bgPanel.update();
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
			var iLoader:IconLoader = IconLoader.getSameIconLoader("items");
			for(var i:int=0;i<count;++i)
			{
				//临时写，后面需要考虑版本控制和加载优化
				var grid:uint = items[i].girdTag //- GRID_OFFSET;
				var cell:Cell = Engine.cm.getBagCell(grid);
				cell.data = items[i];
				iLoader.setCell(cell,items[i].item.itemID,".jpg");
			}
		}
		
	}
}