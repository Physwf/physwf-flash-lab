package struct
{
	import com.physwf.components.bitmap.data.BitmapDataPackage;
	/**
	 * 每个McStruct内部包含一个位图数据包，这一数据包由不同的动作组成 
	 * @author joe
	 * 
	 */
	public class McStruct
	{
		public var name:String;
		public var totalFrames:int;
		public var offsetX:int;
		public var offsetY:int;
		public var packageList:Vector.<BitmapDataPackage>;
	}
}