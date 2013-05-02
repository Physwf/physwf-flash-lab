package
{
	import com.physwf.common.interfaces.ITool;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipFile;
	
	import spark.components.Application;
	import spark.components.Button;
	import spark.components.CheckBox;
	import spark.components.Window;
	
	public class Swc2Swf implements ITool
	{
		private var projects:XMLList;
		private var uncompressQueue:XMLList;
		private var checkBoxes:Vector.<CheckBox>;
		private var win:Window;
		private var assetsDir:File;
		private var configFile:File;
		
		public function Swc2Swf()
		{
		}
		
		public function execute(root:Application):void
		{
			init();
		}
		
		public function exit():void
		{
			win.close();
		}
		
		private function init():void
		{
			var file:File = new File(File.applicationDirectory.nativePath);
			assetsDir = file.resolvePath("../assets/Swc2Swf/");
			configFile = assetsDir.resolvePath("config/projects.xml");
			configFile.addEventListener(Event.COMPLETE,onConfigLoaded);
			configFile.load();
		}
		
		private var lastBtnLeft:Number = 40;
		private function onConfigLoaded(e:Event):void
		{
			var data:ByteArray = e.target.data as ByteArray;
			var config:String = data.readUTFBytes(data.bytesAvailable);
			projects = XML(config).project;
			checkBoxes = new Vector.<CheckBox>();
			win = new Window();
			win.width = 400;
			win.height = 150;
			for(var i:int=0;i<projects.length();++i)
			{
				var project:XML = projects[i];
				var box:CheckBox = new CheckBox();
				box.label = project.@name;
				var row:uint = Math.floor(i / 2);
				var collum:uint = i % 2;
				box.y = 20 + row * 30;
				box.x = 50 + collum * 200;
				//					lastBtnLeft += box.label.length*6;
				checkBoxes.push(box);
				win.addElement(box);
			}
			var btnAll:Button = new Button();
			btnAll.label = "All";
			btnAll.x = 300;
			btnAll.y = 90;
			btnAll.addEventListener(MouseEvent.CLICK,function onAllClick(e:Event):void { uncompressAll(); });
			var btnSelected:Button = new Button();
			btnSelected.label = "Selected";
			btnSelected.x = 200;
			btnSelected.y = 90;
			btnSelected.addEventListener(MouseEvent.CLICK,function onSelectedClick(e:Event):void { uncompressSelected(); });
			win.addElement(btnAll);
			win.addElement(btnSelected);
			win.open();
		}
		
		private function decompress(project:XML):void
		{
			var sourceFile:File = new File(project.@binPath);
			trace(project.@binPath);
			souceFiles.push(sourceFile);
			function onFileLoaded(e:Event):void
			{
				var zipFile:ZipFile = new ZipFile(e.target.data);
				var zipEntry:ZipEntry = zipFile.getEntry("library.swf");
				var targetFile:File = new File(project.@output);
				var fs:FileStream = new FileStream();
				fs.open(targetFile,FileMode.WRITE);
				var bytes:ByteArray = zipFile.getInput(zipEntry);
				fs.writeBytes(bytes,0,bytes.length);
				fs.close();
				var index:int = souceFiles.indexOf(sourceFile);
				souceFiles.splice(index,1);
				if(souceFiles.length<=0)
					Alert.show("Ok","Ok",4,win,function ():void {exit()});
			}
			sourceFile.addEventListener(Event.COMPLETE,onFileLoaded);
			sourceFile.load();
		}
		
		private function uncompressAll():void
		{
			uncompressQueue = projects;
			souceFiles = new <File>[];
			for each(var item:XML in uncompressQueue)
			{
				decompress(item);
			}
		}
		
		private var souceFiles:Vector.<File>;
		private function uncompressSelected():void
		{
			uncompressQueue = new XMLList();
			for(var i:int=0;i<checkBoxes.length;++i)
			{
				if(!checkBoxes[i].selected) continue;
				var project:XML=projects.(@name == checkBoxes[i].label)[0];
				uncompressQueue[uncompressQueue.length()]=project;
			}
			souceFiles = new <File>[];
			for each(var item:XML in uncompressQueue)
			{
				decompress(item);
			}
		}
	}
}