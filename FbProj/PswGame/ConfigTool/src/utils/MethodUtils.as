package utils
{
	public class MethodUtils
	{
		public function MethodUtils()
		{
		}
		
		public static function getRead(fieldName:String,type:String):String
		{
			switch(type)
			{
				case "uint8":
					return fieldName + " = input.readUnsignedByte();";
					break;
				case "uint16":
					return fieldName + " = input.readUnsignedShort();";
					break;
				case "uint32":
					return fieldName + " = input.readUnsignedInt();";
					break;
				case "float":
					return fieldName + " = input.readFloat();";
					break;
				case "double":
					return fieldName + " = input.readDouble();";
					break;
				case "String":
					return "var "+fieldName+"Len:uint = input.readUnsignedShort();"+
							"\n\t\t\t" + fieldName + " = input.readUTFBytes("+fieldName+"Len);"
					break;
			}
			return null;
		}
		
		public static function getWrite(fieldName:String,type:String):String
		{
			switch(type)
			{
				case "uint8":
					return  "output.writeByte("+fieldName+");";
					break;
				case "uint16":
					return "output.writeShort("+fieldName+");";
					break;
				case "uint32":
					return "output.writeUnsignedInt("+fieldName+");";
					break;
				case "float":
					return "output.writeFloat("+fieldName+");";
					break;
				case "double":
					return "output.writeDouble("+fieldName+");";
					break;
				case "String":
					return "var "+fieldName+"Data:ByteArray = new ByteArray();"+
					"\n\t\t\t"+fieldName+"Data.writeUTFBytes("+fieldName+");"+
					"\n\t\t\t"+"output.writeShort("+fieldName+"Data.length);"+
					"\n\t\t\t"+"output.writeBytes("+fieldName+"Data);"
					break;
			}
			return null;
		}
	}
}