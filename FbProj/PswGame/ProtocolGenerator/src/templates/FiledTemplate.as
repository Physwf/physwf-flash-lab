package templates
{
	import flash.utils.ByteArray;

	public class FiledTemplate
	{
		public static const MODE_SINGLE:String = "single";
		public static const MODE_ARRAY:String = "array";
		public static const MODE_VARLIST:String = "varlist";
		
		public static const TYPE_UINT8:String = "uint8";
		public static const TYPE_UINT16:String = "uint16";;
		public static const TYPE_UINT32:String = "uint32";
		
		public static const TYPE_INT8:String = "int32";
		public static const TYPE_INT16:String = "int32";
		public static const TYPE_INT32:String = "int32";
		
		public static const TYPE_CAHR:String = "char";
		
		public static const FILED_TEMPLATE:String = "public var {filedName}:{filedType};";
		public static const READ_TEMPLATE:String = "{filedName} = input.{readMethod}({readArgs})";
		public static const WRITE_TEMPLATE:String = "{methodBefore}" +
													"output.{writeMethod}({writeArgs});" +
													"{methodAfter}";
		
		
		public var filed_declaration:String;
		public var read_method:String;
		public var write_method:String;
		
		public var serverType:String;
		
		public var mode:String;
		public var name:String;
		public var type:String;
		public var size:int;
		public var maxSize:int;
		public var desc:String;
		
		public function FiledTemplate(rawData:XML)
		{
			mode = rawData.@mode;
			name = rawData.@name;
			type = rawData.@type;
			size = int(rawData.@size);
			maxSize = int(rawData.@maxSize);
			desc = rawData.@desc;
		}
		
		public function getFiled():void
		{
			var filedType:String;
			switch(mode)
			{
				case MODE_SINGLE:
					filedType = getSingleFiledType(type);
					break;
				case MODE_ARRAY:
				case MODE_VARLIST:
					filedType = getArrayFiledType(type,serverType);
					break;
			}
			filed_declaration = FILED_TEMPLATE;
			filed_declaration = filed_declaration.replace("{filedName}",name);
			filed_declaration = filed_declaration.replace("{filedType}",filedType);
		}
		
		private static function getSingleFiledType(type:String):String
		{
			switch(type)
			{
				case TYPE_UINT8:
				case TYPE_UINT16:
				case TYPE_UINT32:
					return "uint";
					break;
				case TYPE_INT8:
				case TYPE_INT16:
				case TYPE_INT32:
					return "int"
					break;
			}
//			throw "没有匹配的类型！";
			return null;
		}
		
		private static function getArrayFiledType(type:String,serverType:String):String
		{
			switch(type)
			{
				case TYPE_CAHR:
					return "String";
				default:
					return "Vector.<S"+serverType+"_"+type+">"
			}
			throw "没有匹配的类型！";
			return null;
		}
		
		public function getMethod(methodType:String):void
		{
			var method:String;
			var args:String;
			var methodBefore:String="";
			var methodAfter:String="";
			switch(mode)
			{
				case MODE_SINGLE:
					method = getSingleFiledMethod(type,methodType);
					args = getMethodArgs(methodType);
					break;
				case MODE_ARRAY:
					method = getArrayFiledMethod(type,methodType);
					args = getMethodArgs(methodType);
					if(type == TYPE_CAHR && methodType == "w")
					{
						methodBefore = "var "+name + "Data:ByteArray = new ByteArray();\n\t\t\t";
						methodAfter	= "\n\t\t\t"+name +"Data.lenght = " +  size+";\n";
					}
					break;
				case MODE_VARLIST:
					var readLen:String = "var "+name+"Len:uint=input.readUnsignedInt();\n";
					var readMethod:String = getVarListMethod(methodType);
					method = readLen + readMethod;
					args = getMethodArgs(methodType);
					break;
			}
			if(methodType == "r")
			{
				if(mode != MODE_VARLIST)read_method = READ_TEMPLATE;
				else read_method = method;
				read_method = read_method.replace("{filedName}",name);
				if(mode != MODE_VARLIST) read_method = read_method.replace("{readMethod}",method);
				read_method = read_method.replace("{readArgs}",args);
			}
			else
			{
				write_method = WRITE_TEMPLATE;
				write_method = write_method.replace("{filedName}",name);
				write_method = write_method.replace("{writeMethod}",method);
				write_method = write_method.replace("{writeArgs}",args);
				write_method = write_method.replace("{methodBefore}",methodBefore);
				write_method = write_method.replace("{methodAfter}",methodAfter);
			}
			
		}
		
		private static function getSingleFiledMethod(type:String,mothodType:String = "r"):String
		{
			switch(type)
			{
				case TYPE_UINT8:
					if(mothodType=="r")
						return "readUnsignedByte";
					else 
						return "writeByte";
				case TYPE_UINT16:
					if(mothodType=="r")
						return "readUnsignedShort";
					else
						return "writeShort";
				case TYPE_UINT32:
					if(mothodType=="r")
						return "readUnsignedInt";
					else
						return "writeUnsignedInt";
					break;
				
				case TYPE_INT8:
					if(mothodType=="r")
						return "readByte";
					else 
						return "writeByte";
				case TYPE_INT16:
					if(mothodType=="r")
						return "readShort";
					else 
						return "writeShort";
				case TYPE_INT32:
					if(mothodType=="r")
						return "readInt";
					else
						return "writeInt";
			}
//			throw "没有匹配的类型！";
			return null;
		}
		
		private static function getArrayFiledMethod(type:String,methodType:String = "r"):String
		{
			var b:ByteArray;
			switch(type)
			{
				case TYPE_CAHR:
					if(methodType == "r")
						return "readUTFBytes";
					else 
						return "writeBytes";
				default:
					trace("暂未实现！");
					return "";
			}
			throw "没有匹配的类型！";
			return null;
		}
		
		private function getMethodArgs(methodType:String = "r"):String
		{
			var args:String="";
			switch(type)
			{
				case TYPE_INT8:
				case TYPE_INT16:
				case TYPE_INT32:
				case TYPE_UINT8:
				case TYPE_UINT16:
				case TYPE_UINT32:
					if(methodType == "r")
						return "";
					else
						return name;
				case TYPE_CAHR:
					if(methodType == "r")
						return  size+"";
					else 
						return  name+"Data";
				default:
					return "";
			}
			throw "没有匹配的类型！";
			return null;
		}
		
		private function getVarListMethod(methodType:String="r"):String
		{
			var readMethod:String;
			switch(type)
			{
				case TYPE_CAHR:
					if(methodType == "r")
						return "\t\t\t"+name+" = input.readUTFBytes("+name+"Len);";
					else 
						return "\t\t\toutput.writeUTFBytes";
				case TYPE_INT8:
					readMethod = "readByte";
				case TYPE_INT16:
					readMethod = "readShort";
				case TYPE_INT32:
					readMethod = "readInt";
				case TYPE_UINT8:
					readMethod = "readUnsignedByte";
				case TYPE_UINT16:
					readMethod = "readUnsignedShort";
				case TYPE_UINT32:
					readMethod = "readUnsignedInt";
			}
			var loop:String = 	"\t\t\tfor(var i:uint=0;i<"+name+"Len;i++)\n"+
								"\t\t\t{\n" +
								"\t\t\tinput."+readMethod + "({readArgs})\n;"
								"\t\t\t}";
			return loop;
		}
	}
}