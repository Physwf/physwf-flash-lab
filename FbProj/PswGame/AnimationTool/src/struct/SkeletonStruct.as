package struct
{
	/**
	 * 每个skeleton包含若干个mc，通常每个mc代表某一方向的动画 
	 * @author joe
	 * 
	 */	
	public class SkeletonStruct
	{
		public var name:String
		
		public var mcList:Vector.<McStruct>;
		
		public function get symbolNames():String
		{
			var nameSum:String;
			for(var i:int = 0;i<mcList.length;++i)
			{
				nameSum += ",";
				nameSum +=	mcList[i].name;
			}
			return nameSum;
		}
	}
}