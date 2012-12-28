package struct
{
	import utils.Utils;

	public class MethodStruct
	{
		public var name:String;
		public var mode:String;
		public var type:String;
		public var size:int;
		
		public function MethodStruct(rawData:XML)
		{
			name = rawData.@name;
			mode = rawData.@mode;
			type = rawData.@type;
			size = int(rawData.@size);	
		}
		
		public function getRead():String
		{
			var $type:String = Utils.transformType(type);
			var methodBody:String= "";
			switch(mode)
			{
				case FieldStruct.MODE_SINGLE:
					methodBody += "";
					break;
				case FieldStruct.MODE_ARRAY:
					//如果是字符串，不做处理，否则用矢量数组替换原有类型
					$type = "Vector.<"+$type+">";
					break;
				case FieldStruct.MODE_VARLIST:
					//同上
					$type = "Vector.<"+$type+">";
					break;
			}
		}
		
		public function getWrite():String
		{
			
		}
	}
}