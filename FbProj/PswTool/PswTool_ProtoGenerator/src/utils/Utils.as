package utils
{
	import struct.FieldStruct;

	public class Utils
	{
		public function Utils()
		{
		}
		
		public static function transformType(type:String):String
		{
			switch(type)
			{
				case FieldStruct.TYPE_UINT8:
				case FieldStruct.TYPE_UINT16:
				case FieldStruct.TYPE_UINT32:
					return "uint";
					break;
				case FieldStruct.TYPE_INT8:
				case FieldStruct.TYPE_INT16:
				case FieldStruct.TYPE_INT32:
					return "int";
					break;
				case FieldStruct.TYPE_STR:
					return "String";
				default:
					return type;
					break;
			}
		}
	}
}