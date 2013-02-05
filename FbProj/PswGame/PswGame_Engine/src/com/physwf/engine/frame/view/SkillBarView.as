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
	import com.physwf.components.utils.TGADecoder;
	import com.physwf.engine.frame.config.FrameAssets;
	import com.physwf.engine.frame.controller.SkillBarController;
	import com.physwf.system.System;
	import com.physwf.system.vo.SkillInfo;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import flash.utils.ByteArray;

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
			createCells();
			controller = new SkillBarController();
			controller.initialize(this);
		}
		
		private function createCells():void
		{
			var skills:Vector.<SkillInfo> = System.skill.getSkillsInBar();
			
			var cellFactory:CellFactory = FactoryManager.cellFactroy;
			cells = new Vector.<Cell>();
			
			const num:uint = skills.length;
			const offsetX:uint = 62;
			const offsetY:uint = 7;
			const interval:uint = 3;
			var config:CellConfig = FrameAssets.SKILL_CELL;
			for(var i:int=0;i<num;++i)
			{
				var cell:Cell = cellFactory.createCell(config);
				cell.data = skills[i];
				cell.x = offsetX + (config.size+interval) * i;
				cell.y = offsetY;
				addChild(cell);
				cells.push(cell);
				loadIcon(cell,skills[i].id);
			}
		}
		
		private function loadIcon(cell:Cell,iconID:uint):void
		{
			//to do 临时写的加载，后面考虑统一加载
			var stream:URLStream = new URLStream();
			function onComplete(e:Event):void
			{
				stream.removeEventListener(Event.COMPLETE,onComplete);
				var tgaData:ByteArray = new ByteArray();
				stream.readBytes(tgaData,0,stream.bytesAvailable);
				var tgaDecoder:TGADecoder = new TGADecoder(tgaData);
				cell.contentData = tgaDecoder.bitmap;
			};
			stream.addEventListener(Event.COMPLETE,onComplete);
			stream.load(new URLRequest("resource/icons/skills/"+iconID+".tga"));
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