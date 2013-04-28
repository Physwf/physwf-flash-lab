package struct
{
	public class MsgStruct
	{
		public var template:String;
		public var name:String;
		public static var packageName:String;
		public static var extendsName:String;
//		public var fields:Vector.<FieldStruct>;
		
		public var msgID:String;
		public var fieldsInput:Vector.<FieldStruct>;
		public var fieldsOutput:Vector.<FieldStruct>;
		
		public function MsgStruct(rawData:XML,rawInput:XML,rawOutput:XML)
		{
			name = rawData.@name;
			msgID = rawData.@cmd;
			formatName();
			
			fieldsInput = new Vector.<FieldStruct>();
			if(rawInput) 
				for(var i:int=0;i<rawInput.field.length();++i)
				{
					fieldsInput.push(new FieldStruct(rawInput.field[i]));
				}
			
			fieldsOutput = new Vector.<FieldStruct>();
			if(rawOutput)
				for(i=0;i<rawOutput.field.length();++i)
				{
					fieldsOutput.push(new FieldStruct(rawOutput.field[i]));
				}
		}
		
		private function formatName():void
		{
			name = name.replace("cli_proto","");
			name = name.replace("cli","");
		}
		
		public function get reqName():String
		{
			return "MSG_REQ" + name.toLocaleUpperCase()+"_"+msgID;
		}
		
		public function get resName():String
		{
			return "MSG_RES" + name.toLocaleUpperCase()+"_"+msgID;
		}
		
		public function getMsgRequest():String
		{
			var nameReg:RegExp = new RegExp("{className}","g");
			template = template.replace(nameReg,reqName);
			template = template.replace("{package}",packageName);
			if(extendsName) template = template.replace("{extends}","import "+extendsName);
			else template = template.replace("{extends}","");
			checkInputEmpty();
			MethodStruct.refreshIndexList();
			for(var i:int=0;i<fieldsInput.length;++i)
			{
				template = template.replace("{filed}",fieldsInput[i].getDeclaration() + (i+1<fieldsInput.length?"\n\t\t{filed}":"\n\t\t"));
				template = template.replace("{mid}","");
				template = template.replace("{super}","super("+msgID+")");
				template = template.replace("{prefix}","write");
				template = template.replace("{arg}","output");
				template = template.replace("{direction}","Output");
				template = template.replace("{r/w}",fieldsInput[i].method.getWrite()+(i+1<fieldsInput.length?"\n\t\t\t{r/w}":"\t\t\t"));
			}
			return template;
		}
		
		public function getMsgRespond():String
		{
			var nameReg:RegExp = new RegExp("{className}","g");
			template = template.replace(nameReg,resName);
			template = template.replace("{package}",packageName);
			if(extendsName) template = template.replace("{extends}","import "+extendsName);
			else template = template.replace("{extends}","");
			checkOutputEmpty();
			MethodStruct.refreshIndexList();
			for(var i:int=0;i<fieldsOutput.length;++i)
			{
				template = template.replace("{filed}",fieldsOutput[i].getDeclaration() + (i+1<fieldsOutput.length?"\n\t\t{filed}":"\n\t\t"));
				template = template.replace("{mid}","mid:uint");
				template = template.replace("{super}","super(mid);");
				template = template.replace("{prefix}","read");
				template = template.replace("{arg}","input");
				template = template.replace("{direction}","Input");
				template = template.replace("{r/w}",fieldsOutput[i].method.getRead()+(i+1<fieldsOutput.length?"\n\t\t\t{r/w}":"\t\t\t"));
			}
			return template;
		}
		
		private function checkInputEmpty():void
		{
			if(fieldsInput.length==0)
			{
				template = template.replace("{filed}","");
				template = template.replace("{mid}","");
				template = template.replace("{super}","super("+msgID+")");
				template = template.replace("{prefix}","write");
				template = template.replace("{arg}","output");
				template = template.replace("{direction}","Output");
				template = template.replace("{r/w}","");
			}
		}
		
		private function checkOutputEmpty():void
		{
			if(fieldsOutput.length==0)
			{
				template = template.replace("{filed}","");
				template = template.replace("{mid}","mid:uint");
				template = template.replace("{super}","super(mid);");
				template = template.replace("{prefix}","read");
				template = template.replace("{arg}","input");
				template = template.replace("{direction}","Input");
				template = template.replace("{r/w}","");
			}
		}
	}
}