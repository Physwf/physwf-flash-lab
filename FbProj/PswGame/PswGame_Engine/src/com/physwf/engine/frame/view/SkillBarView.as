package com.physwf.engine.frame.view
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.IconLoader;
	import com.physwf.components.ui.config.CellConfig;
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.components.ui.factory.BarFactory;
	import com.physwf.components.ui.factory.CellFactory;
	import com.physwf.components.ui.factory.FactoryManager;
	import com.physwf.components.ui.layout.HBar;
	import com.physwf.engine.frame.config.FrameAssets;
	import com.physwf.engine.frame.controller.SkillBarController;
	import com.physwf.system.System;
	import com.physwf.system.vo.SkillInfo;
	
	import flash.display.Sprite;

	public class SkillBarView extends Sprite implements IUpdatable
	{
		private var bar:HBar;
		private var cells:Vector.<Cell>;
		private var controller:SkillBarController;
		private const NUM_SLOTS:uint = 8;
		
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
			var skills:Vector.<SkillInfo> = System.skill.skills;
			var shortcuts:Vector.<uint> = System.skill.shortcutSkill;
			
			var cellFactory:CellFactory = FactoryManager.cellFactroy;
			cells = new Vector.<Cell>();
			
			const num:uint = shortcuts.length;
			const offsetX:uint = 62;
			const offsetY:uint = 7;
			const interval:uint = 3;
			var config:CellConfig = FrameAssets.SKILL_CELL;
			//temp 后面需要读取快捷列表
			var iLoader:IconLoader = IconLoader.getSameIconLoader("skills");
			for(var i:int=0;i<NUM_SLOTS;++i)
			{
				var cell:Cell = cellFactory.createCell(config);
				cell.location = Cell.LOCATION_SKILLBAR;
				cell.cdTime = 5000;//ms
				cell.x = offsetX + (config.size+interval) * i;
				cell.y = offsetY;
				addChild(cell);
				cells.push(cell);
				var skill:SkillInfo = (i<skills.length) ? skills[i] : null;
				cell.data = skill;
				if(skill) 
				{
					iLoader.setCell(cell,skill.id,".tga");
				}
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