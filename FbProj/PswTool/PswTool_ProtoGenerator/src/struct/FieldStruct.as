package struct
{
	import utils.Utils;
	
	import flash.utils.getTimer;

	public class FieldStruct
	{
		public static const MODE_SINGLE:String = "single";
		public static const MODE_ARRAY:String = "array";
		public static const MODE_VARLIST:String = "list";
		
		public static const TYPE_UINT8:String = "uint8";
		public static const TYPE_UINT16:String = "uint16";;
		public static const TYPE_UINT32:String = "uint32";
		
		public static const TYPE_INT8:String = "int32";
		public static const TYPE_INT16:String = "int32";
		public static const TYPE_INT32:String = "int32";
		
		public static const TYPE_STR:String = "string16";
		
		public var name:String;
		public var mode:String;
		public var type:String;
		public var size:int;
		public var maxSize:int;
		public var desc:String;
		
		public var method:MethodStruct;
		
		public function FieldStruct(rawData:XML)
		{
			name = rawData.@name;
			mode = rawData.@mode;
			type = rawData.@type;
			size = int(rawData.@size);
			maxSize = rawData.@maxSize;
			desc = rawData.@desc;
			
			method = new MethodStruct(rawData);
		}
		
		public function getDeclaration():String
		{
			var $type:String = Utils.transformType(type);
			var declar:String = "public var "+name+":"+$type+";";
			switch(mode)
			{
				case MODE_SINGLE:
					if(type == FieldStruct.TYPE_STR) 
						$type = "String";
					break;
				case MODE_ARRAY:
					//如果是字符串，不做处理，否则用矢量数组替换原有类型
					if(type == FieldStruct.TYPE_STR) 
						$type = "String";
					else
						$type = "Vector.<"+$type+">";
					break;
				case MODE_VARLIST:
					//同上
					if(type == FieldStruct.TYPE_STR) 
						$type = "String";
					else
						$type = "Vector.<"+$type+">";
					break;
					break;
			}
			declar = "public var "+name+":"+$type+";";
			if(type == FieldStruct.TYPE_STR)
			{
				declar += "\n\t\tpublic var "+ name + "_data:ByteArray";
			}
			return declar;
		}
		
	}
}