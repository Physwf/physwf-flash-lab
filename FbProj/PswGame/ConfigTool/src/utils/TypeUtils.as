package utils
{
	public class TypeUtils
	{
		public function TypeUtils()
		{
		}
		
		public static function transformType(type:String):String
		{
			switch(type)
			{
				case "uint8":
				case "uint16":
				case "uint32":
					return "uint";
					break;
				case "float":
				case "double":
					return "Number";
					break;
				default:
					return type;
					break;
			}
		}
	}
}