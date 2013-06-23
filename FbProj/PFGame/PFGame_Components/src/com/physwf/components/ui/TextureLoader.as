package com.physwf.components.ui
{
	import com.physwf.components.pswloader.BinaryFile;
	import com.physwf.components.pswloader.ImageFile;
	import com.physwf.components.pswloader.PswLoader;
	import com.physwf.components.resource.ResourceCache;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class TextureLoader extends ResourceCache
	{
		public static const LOAD_FLAG_NO:uint = 0;
		public static const LOAD_FLAG_LOADING:uint = 1;
		public static const LOAD_FLAG_YES:uint = 3;
		
		private static var tLoaders:Dictionary = new Dictionary();
		
		/**
		 * 每个材质数据包包含两个部分：纹理坐标和材质图片
		 * 纹理坐标并不是单独的提供一个个图片的矩形信息，而是认为若干个矩形信息构成一个组，这个组通常对应一个文件夹下的多个材质，但是有时候它对应的只有一张材质
		 * 具体地，数据包包含三个部分：
		 * 头|纹理坐标|材质
		 * 其中头表示纹理坐标组的个数
		 * 纹理坐标列举出每一个组的相信坐标信息，每个组的坐标信息详细为：组包含的材质个数（n）|第一个材质的矩形信息|第二个材质的矩形信息|...|第n个材质的矩形信息
		 * 材质包括：材质图片的数据格式, 0 表示无编码压缩(如果是0则后面还要跟图片的宽高值),1表示png
		 */		
		private var mTexture:BitmapData;
		private var mTexcoords:Vector.<Vector.<Rectangle>>;
		
		private var mUrl:String;
		
		private var mLoadFlag:uint=0;
		
		public function TextureLoader(url:String,postfix:String=".swf")
		{
			mUrl = url+postfix;
		}
		
		public static function getSameTexLoader(url:String,postfix:String=".swf"):TextureLoader
		{
			var tLoader:TextureLoader = tLoaders[url];
			if(tLoader == null)
			{
				tLoader = new TextureLoader(url,postfix);
				tLoaders[url] = tLoader;
			}
			tLoader.incRefCount();
			return tLoader;
		}
		
		public function load():void
		{
			if(mLoadFlag == LOAD_FLAG_YES)
			{
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			else if(mLoadFlag == LOAD_FLAG_LOADING)
			{
				return;
			}
			else
			{
				mLoadFlag = LOAD_FLAG_LOADING;
			}
			
			var pLoader:PswLoader = PswLoader.getPswLoader("texture");
			var bFile:BinaryFile = pLoader.add(mUrl,1,"binary");
			bFile.addEventListener(Event.COMPLETE,onComplete);
			pLoader.start();
		}
		
		private function onComplete(e:Event):void
		{
			var bFile:BinaryFile = e.target as BinaryFile;
			var data:ByteArray = bFile.getContent();
			var numGroup:uint = data.readUnsignedShort();
			mTexcoords = new Vector.<Vector.<Rectangle>>(numGroup,true);
			for(var i:uint = 0;i<numGroup;++i)
			{
				var count:uint = data.readUnsignedByte();
				var group:Vector.<Rectangle> = new Vector.<Rectangle>(count,true);
				for(var j:uint=0;j<count;++j)
				{
					var x:uint = data.readUnsignedInt();
					var y:uint = data.readUnsignedInt();
					var w:uint = data.readUnsignedShort();
					var h:uint = data.readUnsignedShort();
					group[j] = new Rectangle(x,y,w,h);
				}
				mTexcoords[i] = group[j];
			}
			var format:uint = data.readUnsignedByte();
			if(format == 0)//无压缩
			{
				var tw:uint = data.readUnsignedInt();
				var th:uint = data.readUnsignedInt();
				var bytes:ByteArray = new ByteArray();
				data.readBytes(bytes,data.position,data.bytesAvailable);
				mTexture = new BitmapData(tw,th,true,0);
				mTexture.setPixels(mTexture.rect,bytes);
			}
		}
	}
}