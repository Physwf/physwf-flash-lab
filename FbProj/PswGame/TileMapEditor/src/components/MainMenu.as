package components
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import shinater.swing.Menu;
	import shinater.swing.MenuBar;
	import shinater.swing.MenuItem;

	public class MainMenu
	{
		private var mMenuBar:MenuBar;
		private var mStage:Stage;
		
		private var mNewMapWin:WinNewMap;
		private var mGeneWin:WinGeneOption;
		
		private var mNPCBox:WinItemBox;
		public function get npcBox():WinItemBox { return mNPCBox; }
		private var mBuildingBox:WinItemBox;
		private var mItemBox:WinItemBox;
		private var mTeleportBox:WinItemBox;
		public function get teleportBox():WinItemBox { return mTeleportBox; }
		
		public function MainMenu(stage:Stage)
		{
			mStage = stage;
			
			mMenuBar = new MenuBar();
			MapEditor.editor.uiLayer.addChild(mMenuBar);
			var fileMenu:Menu = new Menu("&文件");
			var newItem:MenuItem = new MenuItem("&新建");
			var opnItem:MenuItem = new MenuItem("&打开");
			var savItem:MenuItem = new MenuItem("&保存");
			var extItem:MenuItem = new MenuItem("&退出");
			fileMenu.addMenuItem(newItem);
			fileMenu.addMenuItem(opnItem);
			fileMenu.addMenuItem(savItem);
			fileMenu.addMenuItem(extItem);
			mMenuBar.addMenu(fileMenu);
			
			var viewMenu:Menu = new Menu("&视图");
			mMenuBar.addMenu(viewMenu);
			var itemBox:MenuItem = new MenuItem("&物品");
			var teleBox:MenuItem = new MenuItem("&传送点");
			var npcBox:MenuItem = new MenuItem("&NPC");
			var buildingBox:MenuItem = new MenuItem("&建筑");
			viewMenu.addMenuItem(npcBox);
			//viewMenu.addMenuItem(buildingBox);
			viewMenu.addMenuItem(itemBox);
			viewMenu.addMenuItem(teleBox);
			
			var projMenu:Menu = new Menu("项目");
			mMenuBar.addMenu(projMenu);
			var generate:MenuItem = new MenuItem("&生成");
			projMenu.addMenuItem(generate);
			
			newItem.addEventListener(MouseEvent.MOUSE_UP,onNew);
			
			npcBox.addEventListener(MouseEvent.CLICK,oViewnNpc);
			itemBox.addEventListener(MouseEvent.CLICK,onViewItem);
			teleBox.addEventListener(MouseEvent.CLICK,onViewTeleport);
			buildingBox.addEventListener(MouseEvent.CLICK,onViewBuiding);
			
			projMenu.addEventListener(MouseEvent.CLICK,onGenerate);
			
			mNPCBox = new WinItemBox(MapEditor.editor.uiLayer,"NPC");
			mItemBox = new WinItemBox(MapEditor.editor.uiLayer,"Item");
			mTeleportBox = new WinItemBox(MapEditor.editor.uiLayer,"Teleport");
		}
		
		public function onStageResize():void
		{
			mMenuBar.width = mStage.stageWidth;
		}
		
		private function onNew(e:MouseEvent):void
		{
			if(!mNewMapWin)
			{
				mNewMapWin = new WinNewMap(MapEditor.editor.uiLayer);
				mNewMapWin.addEventListener("ok",onWinNewMapOk);
			}
			mNewMapWin.show();
		}
		
		private function onWinNewMapOk(e:Event):void
		{
			mNewMapWin.removeEventListener("ok",onWinNewMapOk);
			mNewMapWin.hide();
			var name:String = mNewMapWin.inputContent;
			MapEditor.editor.map.load(name);
		}
		
		private function oViewnNpc(e:MouseEvent):void
		{
			mNPCBox.setPosition(mStage.stageWidth - 280,30);
			mNPCBox.toogle();
		}
		private function onViewItem(e:MouseEvent):void
		{
			mItemBox.setPosition(mStage.stageWidth - 280,235);
			mItemBox.toogle();
		}
		private function onViewBuiding(e:MouseEvent):void
		{
			mBuildingBox.setPosition(mStage.stageWidth - 280,235);
			mBuildingBox.toogle();
		}
		private function onViewTeleport(e:MouseEvent):void
		{
			mTeleportBox.setPosition(mStage.stageWidth - 280,440);
			mTeleportBox.toogle();
		}
		private function onGenerate(e:MouseEvent):void
		{
			if(!mGeneWin)
			{
				mGeneWin = new WinGeneOption(MapEditor.editor.uiLayer);
				mGeneWin.addEventListener("ok",onOK);
			}
			mGeneWin.show();
		}
		
		private function onOK(e:Event):void
		{
			var option:String = mGeneWin.option;
			mGeneWin.hide();
			MapEditor.editor.generate(option);
		}
	}
}