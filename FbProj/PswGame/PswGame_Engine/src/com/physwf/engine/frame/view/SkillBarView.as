package com.physwf.engine.frame.view
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.SpriteLoader;
	import com.physwf.components.ui.config.CellConfig;
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.components.ui.factory.BarFactory;
	import com.physwf.components.ui.factory.CellFactory;
	import com.physwf.components.ui.factory.FactoryManager;
	import com.physwf.components.ui.layout.HBar;
	import com.physwf.engine.frame.config.FrameAssets;
	import com.physwf.engine.frame.controller.SkillBarController;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;

	public class SkillBarView extends Sprite implements IUpdatable
	{
		private var bar:HBar;
		private var cells:Vector.<Cell>;
		private var controller:SkillBarController;
		
		public function SkillBarView()
		{
			var barFactroy:BarFactory = new BarFactory();
			bar = barFactroy.createHBar(FrameAssets.SKILL_BAR);
			addChild(bar);
			crateCells();
			controller = new SkillBarController();
			controller.initialize(this);
		}
		
		private function crateCells():void
		{
			var cellFactory:CellFactory = FactoryManager.cellFactroy;
			cells = new Vector.<Cell>();
			const num:uint = 8;
			const offsetX:uint = 62;
			const offsetY:uint = 7;
			const interval:uint = 3;
			var config:CellConfig = FrameAssets.SKILL_CELL
			for(var i:int=0;i<num;++i)
			{
				var cell:Cell = cellFactory.createCell(config);
				cell.x = offsetX + (config.size+interval) * i;
				cell.y = offsetY;
				addChild(cell);
				cells.push(cell);
			}
		}
		
		public function update():void
		{
			bar.update();
			for(var i:uint=0;i<cells.length;++i)
			{
				cells[i].update();
			}
		}
	}
}