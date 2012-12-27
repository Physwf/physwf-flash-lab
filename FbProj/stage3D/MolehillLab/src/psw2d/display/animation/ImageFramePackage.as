package psw2d.display.animation
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	/**
	 *  
	 * @author joe
	 * ------------------------------------------------------------------------------------------------------------------
	 * |	|		|		|		|		|		|		|		|		|		|		|		|		|		|
	 * ------------------------------------------------------------------------------------------------------------------
	 *    |     |       |       |       |       |      |               |         |       |		|		|		|
	 * 总帧数  关键帧数      组数        纹理格式    关键帧0  关键帧1   关键帧2       。。。       小组0            小组1         小组2    普通帧0     普通帧1      普通帧2
	 * 
	 * 关键帧
	 * ----------------------------------
	 * |		|		|		|		|
	 * ----------------------------------
	 *    x0,y0   x1,y1   x2,y2   x3,y3
	 * 
	 * 小组
	 * --------------------------------------
	 * |			|		|		|		|	
	 * --------------------------------------
	 *    名称字节长度      组名         起始帧       结束帧     
	 */	
	public class ImageFramePackage
	{
		public var imageKeyFrames:Vector.<ImageKeyFrame>;
		public var imageFrameGroups:Vector.<ImageFrameGroup>;
		public var imageFrames:Vector.<ImageFrame>;
		
		private var _totalFrame:int;
		private var _numKeyFrames:int;
		
		private var _numGroups:int;
		private var _format:int;
		
		public function ImageFramePackage()
		{
		}
		
		public function readPagckage(input:IDataInput):void
		{
			_totalFrame = input.readShort();
			_numKeyFrames = input.readShort();
			
			_numGroups = input.readShort();
			_format = input.readByte();//0,1,2
			
			imageKeyFrames = new Vector.<ImageKeyFrame>();
			var keyFrame:ImageKeyFrame;
			for(var i:int=0;i<_numKeyFrames;++i)
			{
				keyFrame = new ImageKeyFrame();
				var frameBytes:ByteArray = new ByteArray();
				input.readBytes(frameBytes,0,2*16);//共16个数据，每个数据两个字节float
				keyFrame.readFrame(frameBytes);
				imageKeyFrames.push(keyFrame);
			}
			
			imageFrameGroups = new Vector.<ImageFrameGroup>();
			var group:ImageFrameGroup;
			for(i=0;i<_numGroups;++i)
			{
				var nameLen:int = input.readByte();
				group = new ImageFrameGroup(input.readUTFBytes(nameLen),
											input.readShort(),input.readShort());
				imageFrameGroups.push(group);
			}
			
			imageFrames = new Vector.<ImageFrame>();
			var frame:ImageFrame;
			for(i=0;i<_totalFrame;++i)
			{
				var index:int = input.readShort();
				frame = new ImageFrame(imageKeyFrames[index]);
				imageKeyFrames.push(frame);
			}
		}
		
		public function writePackage(output:IDataOutput):void
		{
			
		}
	}
}