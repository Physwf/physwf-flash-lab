package com.physwf.config
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.IExternalizable;
	import flash.utils.getDefinitionByName;

	public class Config
	{
		private static var configs:Dictionary;
		private static var mapConfig:Dictionary;
		private static var monsterConfig:Dictionary;
		private static var effectConfig:Dictionary;
		private static var npcConfig:Dictionary;
		private static var skillConfig:Dictionary;
		private static var playerConfig:Dictionary;
		
		public function Config()
		{
		}
		
		public static function initialize(msger:EventDispatcher):void
		{
			configs = new Dictionary();
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,function (e:Event):void 
			{
				onCfgList(e,msger);
			});
			urlLoader.load(new URLRequest("resource/config/cfgList.xml"));
		}
		
		private static function onCfgList(e:Event,msger:EventDispatcher):void
		{
			var list:XMLList = XML(e.target.data).config;
			var listLen:uint = list.length();
			
			for each(var item:XML in list)
			{
				var stream:URLStream = new URLStream();
				var $name:String = item.@name;
				var $item:XML = item;
				stream.addEventListener(Event.COMPLETE,function onComplete(e:Event):void
				{
					
					onItemComplete(e);
					
					listLen--;
					if(listLen == 0)
					{
						msger.dispatchEvent(new Event(Event.COMPLETE));
					}
				});
				stream.load(new URLRequest("resource/config/"+item.@name+".cfg"));
			}
		}
		
		private static function onItemComplete(e:Event):void
		{
			var target:URLStream = e.target as URLStream;
			var fileData:ByteArray = new ByteArray();
			target.readBytes(fileData);
			var config:Dictionary = new Dictionary();
			
			var nameLen:uint = fileData.readShort();
			var name:String = fileData.readUTFBytes(nameLen);
			
			var structLen:uint = fileData.readShort();
			var structName:String = fileData.readUTFBytes(structLen);
			
			configs[name] = config;
			parse(structName,fileData,config);
		}
		
		private static function parse(structName:String,fileData:ByteArray,configDic:Dictionary):void
		{
			var Def:Class = getDefinitionByName(structName) as Class;
			while(fileData.bytesAvailable)
			{
				var def:IExternalizable = new Def() as IExternalizable;
				var key:uint = fileData.readUnsignedInt();
				var len:uint = fileData.readUnsignedInt();
				def.readExternal(fileData);
				configDic[key] = def;
			}
		}
	}
}