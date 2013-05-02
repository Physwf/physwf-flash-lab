package 
{
	import com.physwf.common.interfaces.ITool;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	
	import spark.components.Application;
	import spark.components.Button;
	import spark.components.RadioButton;
	import spark.components.Window;
	
	import struct.MsgStruct;
	import struct.StructStruct;
	
	import templates.StructTemplate;
	
	public class ProtoGenerator implements ITool
	{
		private var assetsDir:File;
		private var mRoot:Application;
		private var win:Window;
		private var config:XML;
		//			private var platform_url:String="http://10.1.1.5/su/proto/download.php?project=ultraman_login";
		private var struct_url:String;
		private var switch_url:String;
		private var role_url:String;
		
		private var proto_url_list:XMLList;
		private var struct_output_dir:String;
		private var proto_output_dir:String = "F:/physwf-flash-lab/FbProj/PswGame/ProtocolGenerator/output/"
		private var structTemplate:String;
		
		private var msgTemplate:String = null;
		private var configFile:File;
		private var structTemplateFile:File;
		private var msgTemplateFile:File;
		private var msgManagerFile:File;
		private var msgManagerFs:FileStream;
		private var msgMngPath:String;
		private var serverType:String;
		
		private var so:SharedObject;
		
		private var merge_xml:XML;
		
		public function ProtoGenerator()
		{
			super();
		}
		
		public function execute(root:Application):void
		{
			mRoot = root;
			win = new Window();
			win.width = 400;
			win.height = 150;
			win.open();
//			mRoot.addElement(win);
			var btnDo:Button = new Button();
			btnDo.x = 300;
			btnDo.y = 90;
			btnDo.label = "Do";
			btnDo.addEventListener(MouseEvent.CLICK,onDoClick);
			win.addElement(btnDo);
			init();
		}
		
		public function exit():void
		{
			win.close();
		}
		
		private function init():void
		{
			var file:File = new File(File.applicationDirectory.nativePath);
			assetsDir = file.resolvePath("../assets/ProtoGenerator/");
			so = SharedObject.getLocal("protocolGenerator/project");
			loadStructTemplate();
			loadMsgTemplate();
			readConfig();
		}
		
		private function onDoClick(e:MouseEvent):void
		{
			merge_xml = <ice_protocol></ice_protocol>;
			getStruct();
		}
		
		private function readConfig():void
		{
			configFile = assetsDir.resolvePath("config/inout.xml");
			function onConfigLoaded(e:Event):void
			{
				config = XML(configFile.data.readUTFBytes(configFile.data.length));
				struct_url = config.@struct_url;
				switch_url = config.@switch_url;
				role_url = config.@role_url;
				struct_output_dir = config.@struct_output_dir;
				for(var i:int=0;i<config.server.length();++i)
				{
					var rBtn:RadioButton = new RadioButton();
					rBtn.label = config.server[i].@name;
					if(so.data["name"] == rBtn.label) 
					{
						rBtn.selected = true;
						proto_url_list = config.server.(@name == rBtn.label)[0].url;
						StructStruct.packageName = config.server.(@name == rBtn.label)[0].@packageName;
						MsgStruct.packageName = config.server.(@name == rBtn.label)[0].@packageName;
						MsgStruct.extendsName = config.server.(@name == rBtn.label)[0].@extendsName;
						proto_output_dir = config.server.(@name == rBtn.label)[0].@output;
						msgMngPath = config.server.(@name == rBtn.label)[0].@msgManagerPath;
					}
					else if(so.data["name"] == null) 
					{
						so.data["name"] = rBtn.label;
						proto_url_list = config.server.(@name == rBtn.label)[0].url;
						StructStruct.packageName = config.server.(@name == rBtn.label)[0].@packageName;
						MsgStruct.packageName = config.server.(@name == rBtn.label)[0].@packageName;
						MsgStruct.extendsName = config.server.(@name == rBtn.label)[0].@extendsName;
						proto_output_dir = config.server.(@name == rBtn.label)[0].@output;
						msgMngPath = config.server.(@name == rBtn.label)[0].@msgManagerPath;
						rBtn.selected = true;
					}
					rBtn.x = 40 + (i%5) * 70;
					rBtn.y = 30 + Math.floor(i/5) * 20;
					rBtn.addEventListener(MouseEvent.CLICK,function onClick(e:Event):void
					{
						proto_url_list = config.server.(@name == e.target.label)[0].url;
						StructStruct.packageName = config.server.(@name == e.target.label)[0].@packageName;
						MsgStruct.packageName = config.server.(@name == e.target.label)[0].@packageName;
						MsgStruct.extendsName = config.server.(@name == e.target.label)[0].@extendsName;
						proto_output_dir = config.server.(@name == e.target.label)[0].@output;
						msgMngPath = config.server.(@name == e.target.label)[0].@msgManagerPath;
						so.data["name"] = rBtn.label;
						so.flush();
					});
					win.addElement(rBtn);
				}
			};
			configFile.addEventListener(Event.COMPLETE,onConfigLoaded);
			configFile.load();
		}
		
		private function loadStructTemplate():void
		{
			structTemplateFile = assetsDir.resolvePath("templates/StructTemplate.txt");
			function onComplete(e:Event):void
			{
				structTemplate = structTemplateFile.data.readUTFBytes(structTemplateFile.data.length);
				//					serverType = "LOGIN";
			};
			structTemplateFile.addEventListener(Event.COMPLETE,onComplete);
			structTemplateFile.load();
		}
		
		private function loadMsgTemplate():void
		{
			msgTemplateFile = assetsDir.resolvePath("templates/MsgTemplate.txt");
			function onComplete(e:Event):void
			{
				msgTemplate = msgTemplateFile.data.readUTFBytes(msgTemplateFile.data.length);
			};
			msgTemplateFile.addEventListener(Event.COMPLETE,onComplete);
			msgTemplateFile.load();
		}
		
		private function getStruct():void
		{
			var structLoader:URLLoader = new URLLoader();
			structLoader.addEventListener(Event.COMPLETE,onStructLoaded);
			structLoader.load(new URLRequest(struct_url));
		}
		
		private function onStructLoaded(e:Event):void
		{
			merge_xml.appendChild(XML(e.target.data).protocols.structs);
			
			loadNext();
		}
		
		private function loadNext():Boolean
		{
			if(proto_url_list.length()==0)
			{
				return false;
			}
			else 
			{
				var proto_url:String = proto_url_list[0].@value;
				var protoLoader:URLLoader = new URLLoader();
				protoLoader.addEventListener(Event.COMPLETE,onProtoLoaded);
				protoLoader.load(new URLRequest(proto_url));
				delete proto_url_list[0];
				return true;
			}
		}
		
		private function rewriteProto(proto:XML):void
		{
			var struct_list:XML = proto.structs[0];
			for each(var protos:XML in proto.protocols)
			{
				var protoList:XMLList = protos.protocol;
				for each(var protoItem:XML in protoList)
				{
					for(var i:uint=0;i<2;++i)
					{
						struct_list.appendChild(protoItem.struct[i]);
					}
				}
			}
		}
		
		private function onProtoLoaded(e:Event):void
		{
			var proto:XML = XML(e.target.data);
			merge_xml.appendChild(proto.protocols);
			
			if(loadNext()) return;
			
			rewriteProto(merge_xml);
			
//			trace(merge_xml);
			
			var structList:XMLList = merge_xml.structs[0].struct;
			var structRaw:XML;
			if(msgMngPath) 
			{
				msgManagerFile = new File(msgMngPath);
				msgManagerFs = new FileStream();
				msgManagerFs.open(msgManagerFile,FileMode.READ);
				var msgManagerContent:String = msgManagerFs.readUTFBytes(msgManagerFs.bytesAvailable);
				msgManagerFs.close();
				var reg:RegExp = /registerMessage\(\):void+\s+\{(\s|\w|[\(\);,])+\}/;
				trace(reg.test(msgManagerContent))
				msgManagerContent = msgManagerContent.replace(reg,"registerMessage():void\n\t\t{\n\t\t\t{register}\n\t\t}");
			}
			for(var i:int =0;i<structList.length();++i)
			{
				structRaw = structList[i];
				var sName:String = structRaw.@name;
				if(verifyName(sName)) continue;
				StructTemplate.serverType = serverType;
				var classStruct:StructStruct = new StructStruct(structRaw);
				classStruct.template = structTemplate;
				var file:File = new File(struct_output_dir+classStruct.name+".as");
				var fs:FileStream = new FileStream();
				fs.open(file,FileMode.WRITE);
				fs.writeUTFBytes(classStruct.getDefinitioin());
				fs.close();
			}
			for each(var protos:XML in merge_xml.protocols)
			{
				var protoList:XMLList = protos.protocol;
				var msg:XML;
				for(i=0;i<protoList.length();++i)
				{
					msg = protoList[i];
					var rawInput:XML = structList.(@name == msg.@struct_in)[0];
					var rawOutput:XML = structList.(@name == msg.@struct_out)[0];
					
					var msgStruct:MsgStruct = new MsgStruct(msg,rawInput,rawOutput);
					
					msgStruct.template = msgTemplate;
					file = new File(proto_output_dir+msgStruct.reqName+".as");
					fs = new FileStream();
					fs.open(file,FileMode.WRITE);
					fs.writeUTFBytes(msgStruct.getMsgRequest());
					fs.close();
					
					msgStruct.template = msgTemplate;
					file = new File(proto_output_dir+msgStruct.resName+".as");
					fs = new FileStream();
					fs.open(file,FileMode.WRITE);
					fs.writeUTFBytes(msgStruct.getMsgRespond());
					fs.close();
					
					if(msgMngPath&&i<protoList.length())
					{
						trace(msgStruct.msgID+","+msgStruct.resName);
						msgManagerContent =	msgManagerContent.replace("{register}","regMsg("+msgStruct.msgID+","+msgStruct.resName+");\n\t\t\t{register}");
					}
				}
			}
			if(msgMngPath)
			{
				msgManagerContent = msgManagerContent.replace("{register}","");
				msgManagerFs.open(msgManagerFile,FileMode.WRITE);
				msgManagerFs.writeUTFBytes(msgManagerContent);
				msgManagerFs.close();
			}
			Alert.show("Done!","Ok",4,win,function ():void {exit()});
		}
		
		private function verifyName(name:String):Boolean
		{
			if(name.substr(name.length - 3,3) == "_in" || name.substr(name.length - 4,4) == "_out") return true;//过滤_in _out协议内部的结构体
			return false;
		}
	}
}