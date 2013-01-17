package struct
{
	import flash.utils.ByteArray;
	
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
			switch(mode)
			{
				case FieldStruct.MODE_SINGLE:
					return getSingleReadBody();
					break;
				case FieldStruct.MODE_ARRAY:
					return getArrayReadBody();
					break;
				case FieldStruct.MODE_VARLIST:
					return getVarlistReadBody();
					break;
			}
			return null;
		}
		
		private function getSingleReadBody():String
		{
			switch(type)
			{
				case FieldStruct.TYPE_UINT8:
					return name+" = input.readUnsignedByte();";
				case FieldStruct.TYPE_UINT16:
					return name+" = input.readUnsignedShort();";
				case FieldStruct.TYPE_UINT32:
					return name+" = input.readUnsignedInt();";
				case FieldStruct.TYPE_INT8:
					return name+" = input.readUnsignedInt();";
				case FieldStruct.TYPE_INT16:
					return name+" = input.readUnsignedInt();";
				case FieldStruct.TYPE_INT32:
					return name+" = input.readUnsignedInt();";
				case FieldStruct.TYPE_CAHR:
					throw "参数类型有误！";
				default:
					return 	name +"= new "+ type + "();\n" +
					"\t\t\t"+name+".readExternal(input)";
			}
		}
		
		private function getArrayReadBody():String
		{
			
			var loopBody:String;
			switch(type)
			{
				case FieldStruct.TYPE_CAHR:
					var readStr:String = name + " = input.readUTFBytes("+size+");";//定长数组 {args} = size,变长数组{args} = input.readUnsignedInt();
//					var readByteArr:String =  name+ "Data = new ByteArray();" +
//						"\n\t\t\tinput.readBytes("+name+"Data,0,"+size+");"
					return readStr;
				default:
					loopBody =  getReadLoopBody();
			}
			var forLoop:String = ""+name +"= new Vector.<"+ Utils.transformType(type) + ">();\n" +
				"\t\t\tfor(var i:int=0;i<"+size+";++i)\n" +
				"\t\t\t{\n" +
				"\t\t\t\t{loopBody}\n" +
				"\t\t\t\t"+name+".push("+name+"_item)\n" +
				"\t\t\t}\n";
			return forLoop.replace("{loopBody}",loopBody);
		}
		
		private function getReadLoopBody():String
		{
			var itemDecl:String;
			switch(type)
			{
				case FieldStruct.TYPE_UINT8:
					itemDecl =   "var "+name+"_item:unit = input.readUnsignedByte();";
					break;
				case FieldStruct.TYPE_UINT16:
					itemDecl =   "var "+name+"_item:unit = input.readUnsignedShort();";
					break;
				case FieldStruct.TYPE_UINT32:
					itemDecl =   "var "+name+"_item:unit = input.readUnsignedInt();";
					break;
				case FieldStruct.TYPE_INT8:
					itemDecl =   "var "+name+"_item:int = input.readUnsignedInt();";
					break;
				case FieldStruct.TYPE_INT16:
					itemDecl =   "var "+name+"_item:int = input.readUnsignedInt();";
					break;
				case FieldStruct.TYPE_INT32:
					itemDecl =   "var "+name+"_item:int = input.readUnsignedInt();";
				default:
					itemDecl =   "var "+name+"_item:"+type+" = new "+type+"()";
			}
			return itemDecl + "\n\t\t\t\t"+name+"_item.readExternal(input);";
		}
		
		private function getVarlistReadBody():String
		{
			var loopBody:String;
			var readLen:String = "var "+name+"Len:uint =input.readUnsignedInt();\n";
			switch(type)
			{
				case FieldStruct.TYPE_CAHR:
					return readLen +
					"\t\t\t"+name + "=input.readUTFBytes("+name+"Len);";
				default:
					loopBody =  getReadLoopBody();
			}
			var forLoop:String = "\t\t\t"+name +"= new Vector.<"+ Utils.transformType(type) + ">();\n" +
				"\t\t\tfor(var i:int=0;i<"+name+"Len;++i)\n" +
				"\t\t\t{\n" +
				"\t\t\t\t{loopBody};\n" +
				"\t\t\t\t"+name+".push("+name+"_item);\n" +
				"\t\t\t}";
			return 	readLen +
					forLoop.replace("{loopBody}",loopBody);
		}
		
		public function getWrite():String
		{
			switch(mode)
			{
				case FieldStruct.MODE_SINGLE:
					return getSingleWriteBody();
					break;
				case FieldStruct.MODE_ARRAY:
					return getArrayWriteBody();
					break;
				case FieldStruct.MODE_VARLIST:
					return getVarlistWriteBody();
					break;
			}
			return null;
		}
		
		private function getSingleWriteBody():String
		{
			switch(type)
			{
				case FieldStruct.TYPE_UINT8:
					return "output.writeByte("+name+");";
				case FieldStruct.TYPE_UINT16:
					return "output.writeShort("+name+");";
				case FieldStruct.TYPE_UINT32:
					return "output.writeInt("+name+");";
				case FieldStruct.TYPE_INT8:
					return "output.writeByte("+name+");";
				case FieldStruct.TYPE_INT16:
					return "output.writeShort("+name+");";
				case FieldStruct.TYPE_INT32:
					return "output.writeInt("+name+");";
				case FieldStruct.TYPE_CAHR:
					throw "参数类型有误！";
				default:
					return 	name + ".writeExternal(output)";
			}
		}
		
		private function getArrayWriteBody():String
		{
			var loopBody:String;
			switch(type)
			{
				case FieldStruct.TYPE_CAHR:
					var writeStr:String = "\n\t\t\t\tvar "+name+"Data:ByteArray = new ByteArray();" +
					"\n\t\t\t\t" + name+"Data.writeUTFBytes("+name+")" +
					"\n\t\t\t\t"+ name+"Data.length = "+ size +";"+
					"\n\t\t\t\toutput.writeBytes("+name+"Data)";
					var writeByte:String = "\n\t\t\t\toutput.writeBytes("+name+"_data)";
					return "if("+name+"_data)" +
						"\n\t\t\t{" +
							writeByte +
						"\n\t\t\t}" +
						"\n\t\t\telse" +
						"\n\t\t\t{" +
							writeStr +
						"\n\t\t\t}" ;
				default:
					loopBody =  getWriteLoopBody();
			}
			var forLoop:String = "" +
				"for(var i:int=0;i<"+size+";++i)\n" +
				"\t\t\t{\n" +
				"\t\t\t\t{loopBody}\n" +
				"\t\t\t}\n";
			return forLoop.replace("{loopBody}",loopBody);
		}
		
		private function getWriteLoopBody():String
		{
			var itemDecl:String;
			switch(type)
			{
				case FieldStruct.TYPE_UINT8:
					return  "output.writeUnsignedByte("+name+"[i])";
					break;
				case FieldStruct.TYPE_UINT16:
					return  "output.writeUnsignedShort("+name+"[i])";
					break;
				case FieldStruct.TYPE_UINT32:
					return  "output.writeUnsignedInt("+name+"[i])";
					break;
				case FieldStruct.TYPE_INT8:
					return  "output.writeByte("+name+"[i])";
					break;
				case FieldStruct.TYPE_INT16:
					return  "output.writeShort("+name+"[i])";
					break;
				case FieldStruct.TYPE_INT32:
					return  "output.writeInt("+name+"[i])";
				default:
					return  name+"[i].writeExternal(output)";
			}
		}
		
		private function getVarlistWriteBody():String
		{
			var loopBody:String;
			var writeLen:String = "output.writeUnsignedInt("+name+".length);\n";
			switch(type)
			{
				case FieldStruct.TYPE_CAHR:
					return writeLen +
					"\t\t\t" + "output.writeUTFBytes("+name+");";
				default:
					loopBody =  getWriteLoopBody();
			}
			var forLoop:String = "" +
				"\t\t\tfor(var i:int=0;i<"+name+".length;++i)\n" +
				"\t\t\t{\n" +
				"\t\t\t\t{loopBody};\n" +
				"\t\t\t}";
			return 	writeLen +
				forLoop.replace("{loopBody}",loopBody);
		}
	}
}