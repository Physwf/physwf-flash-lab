package struct
{
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