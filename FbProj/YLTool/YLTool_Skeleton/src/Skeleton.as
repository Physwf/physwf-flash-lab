package
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	import spark.components.Application;
	import spark.components.Button;
	import spark.components.Window;
	
	import common.interfaces.ITool;
	
	import struct.SkeletonPackage;
	
	public class Skeleton implements ITool
	{
		public static var rootDir:String = "D:/m3/client/bin/cdn_n/assets/";
		public static var parentDirName:String;
		
		private var mWin:Window;
		private var mFile:File;
		
		public function Skeleton()
		{
		}
		
		public function execute(root:Application):void
		{
			mWin = new Window();
			mWin.width = 500;
			mWin.height = 200;
			mWin.open();
			
			var btnSelect:Button = new Button();
			btnSelect.label="Select";
			btnSelect.x = 400;
			btnSelect.y = 130;
			btnSelect.addEventListener(MouseEvent.CLICK,onSelect);
			mWin.addElement(btnSelect);
		}
		
		private function onSelect(e:MouseEvent):void
		{
			mFile = new File();
			mFile.addEventListener(Event.SELECT,function (e:Event):void
			{
				var files:Array = mFile.getDirectoryListing();
				var spack:SkeletonPackage = new SkeletonPackage(files,mFile.parent.name+"/"+mFile.name);
				spack.load();
				parentDirName = mFile.parent.name;
			});
			mFile.browseForDirectory("");
		}
		
		public function exit():void
		{
			
		}
	}
}