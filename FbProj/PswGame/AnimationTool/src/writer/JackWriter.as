package writer
{
	import com.physwf.components.bitmap.data.BigKey;
	import com.physwf.components.bitmap.data.SmallKey;
	import com.physwf.components.bitmap.net.SkeletonLoader;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import struct.SkeletonStruct;
	
	public class JackWriter implements IWriter
	{
		private var _fileStream:FileStream;
		
		public function JackWriter()
		{
		}
		
		public function writeSkeleton(skeletonStruct:SkeletonStruct):void
		{
			_fileStream = new FileStream();
			
			var skeletonName:String = skeletonStruct.name;
			var bigKey:BigKey = new BigKey();
			//mc
			for(var i:int = 0;i<skeletonStruct.mcList.length;++i)
			{
				var mcName:String = skeletonStruct.mcList[i].name;
				var smallKey:SmallKey = new SmallKey();
				//packge
				for(var j:int =0;j<skeletonStruct.mcList[i].packageList.length;++j)
				{
					var frameName:String = skeletonStruct.mcList[i].packageList[j].name;
					smallKey.symbolNames = skeletonStruct.symbolNames;
					smallKey.directionName = skeletonStruct.mcList[i].name;
					smallKey.totalFrames = skeletonStruct.mcList[i].totalFrames;
					
					var rectArr:Array = [];
					var frames:Array = [];
					//key frames
					for(var k:int =0;k<skeletonStruct.mcList[i].packageList[j].bitmapKeyFrames.length;++k)
					{
						rectArr.push(skeletonStruct.mcList[i].packageList[j].bitmapKeyFrames[k].rect.width,
							skeletonStruct.mcList[i].packageList[j].bitmapKeyFrames[k].rect.height);
					}
					//frams
					for(k=0;k<skeletonStruct.mcList[i].packageList[j].bitmapFrames.length;++k)
					{
						// to do 计算出index的值
						var index:int = skeletonStruct.mcList[i].packageList[j].bitmapFrames[k].index;
						// index --;
						frames.push(
							index,
							skeletonStruct.mcList[i].packageList[j].bitmapKeyFrames[index].x,
							skeletonStruct.mcList[i].packageList[j].bitmapKeyFrames[index].y);
					}
					
					smallKey.keyFrameLength = rectArr.length;
					smallKey.keyFrameRects = rectArr;
					smallKey.frames = frames;
					// write package
					var bytes:ByteArray = new ByteArray();
					skeletonStruct.mcList[i].packageList[j].writeExternal(bytes);
					var tempFile:File = File.desktopDirectory.resolvePath(skeletonName+"/"+mcName+"/"+frameName+SkeletonLoader.POSTFIX_SWF);
					_fileStream.open(tempFile,FileMode.WRITE);
					_fileStream.writeBytes(bytes);
					_fileStream.close();
					

				}
				// write small key
				bytes = new ByteArray();
				smallKey.writeKey(bytes);
				bigKey.smallKeys.push(bytes);
				tempFile = File.desktopDirectory.resolvePath(skeletonName+"/"+mcName+"/"+SkeletonLoader.KEYNAME+SkeletonLoader.POSTFIX_SWF);
				_fileStream.open(tempFile,FileMode.WRITE);
				_fileStream.writeBytes(bytes);
				_fileStream.close();
			}
			// write big key
			var bKeyBytes:ByteArray = new ByteArray();
			bigKey.writeKey(bKeyBytes);
			tempFile = File.desktopDirectory.resolvePath(skeletonName+"/"+SkeletonLoader.KEYNAME+SkeletonLoader.POSTFIX_SWF);
			_fileStream.open(tempFile,FileMode.WRITE);
			_fileStream.writeBytes(bKeyBytes);
			_fileStream.close();
		}
	}
}