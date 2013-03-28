package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_genius_genius_t implements IExternalizable
	{
		public var genius_id:uint;
		public var role_type:uint;
		public var user_lv:uint;
		public var genius_lv:uint;
		public var genius_exp:uint;
		public var genius_money:uint;
		public var skill1:Vector.<uint>;
		public var skill2:Vector.<uint>;
		public var skill3:Vector.<uint>;
		public var skill4:Vector.<uint>;
		public var skill5:Vector.<uint>;
		public var skill6:Vector.<uint>;
		public var phy_atk:uint;
		public var solar_atk:uint;
		public var phy_def:uint;
		public var solar_def:uint;
		public var hit:uint;
		public var dodge:uint;
		public var hp_max:uint;
		public var mp_max:uint;
		public var crit:uint;
		
		public function xml_genius_genius_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			genius_id = input.readUnsignedShort();
			role_type = input.readUnsignedByte();
			user_lv = input.readUnsignedByte();
			genius_lv = input.readUnsignedByte();
			genius_exp = input.readUnsignedInt();
			genius_money = input.readUnsignedInt();
			var skill1Len:uint =input.readUnsignedInt();
			skill1= new Vector.<uint>();
			for(var i:int=0;i<skill1Len;++i)
			{
				var skill1_item:uint = input.readUnsignedShort();;
				skill1.push(skill1_item);
			}
			var skill2Len:uint =input.readUnsignedInt();
			skill2= new Vector.<uint>();
			for(var k:int=0;k<skill2Len;++k)
			{
				var skill2_item:uint = input.readUnsignedShort();;
				skill2.push(skill2_item);
			}
			var skill3Len:uint =input.readUnsignedInt();
			skill3= new Vector.<uint>();
			for(var q:int=0;q<skill3Len;++q)
			{
				var skill3_item:uint = input.readUnsignedShort();;
				skill3.push(skill3_item);
			}
			var skill4Len:uint =input.readUnsignedInt();
			skill4= new Vector.<uint>();
			for(var x:int=0;x<skill4Len;++x)
			{
				var skill4_item:uint = input.readUnsignedShort();;
				skill4.push(skill4_item);
			}
			var skill5Len:uint =input.readUnsignedInt();
			skill5= new Vector.<uint>();
			for(var z:int=0;z<skill5Len;++z)
			{
				var skill5_item:uint = input.readUnsignedShort();;
				skill5.push(skill5_item);
			}
			var skill6Len:uint =input.readUnsignedInt();
			skill6= new Vector.<uint>();
			for(var v:int=0;v<skill6Len;++v)
			{
				var skill6_item:uint = input.readUnsignedShort();;
				skill6.push(skill6_item);
			}
			phy_atk = input.readUnsignedByte();
			solar_atk = input.readUnsignedByte();
			phy_def = input.readUnsignedByte();
			solar_def = input.readUnsignedByte();
			hit = input.readUnsignedByte();
			dodge = input.readUnsignedByte();
			hp_max = input.readUnsignedInt();
			mp_max = input.readUnsignedInt();
			crit = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(genius_id);
			output.writeByte(role_type);
			output.writeByte(user_lv);
			output.writeByte(genius_lv);
			output.writeUnsignedInt(genius_exp);
			output.writeUnsignedInt(genius_money);
			output.writeUnsignedInt(skill1.length);
			for(var j:int=0;j<skill1.length;++j)
			{
				output.writeShort(skill1[j]);
			}
			output.writeUnsignedInt(skill2.length);
			for(var p:int=0;p<skill2.length;++p)
			{
				output.writeShort(skill2[p]);
			}
			output.writeUnsignedInt(skill3.length);
			for(var r:int=0;r<skill3.length;++r)
			{
				output.writeShort(skill3[r]);
			}
			output.writeUnsignedInt(skill4.length);
			for(var y:int=0;y<skill4.length;++y)
			{
				output.writeShort(skill4[y]);
			}
			output.writeUnsignedInt(skill5.length);
			for(var u:int=0;u<skill5.length;++u)
			{
				output.writeShort(skill5[u]);
			}
			output.writeUnsignedInt(skill6.length);
			for(var w:int=0;w<skill6.length;++w)
			{
				output.writeShort(skill6[w]);
			}
			output.writeByte(phy_atk);
			output.writeByte(solar_atk);
			output.writeByte(phy_def);
			output.writeByte(solar_def);
			output.writeByte(hit);
			output.writeByte(dodge);
			output.writeUnsignedInt(hp_max);
			output.writeUnsignedInt(mp_max);
			output.writeByte(crit);			
		}
	}
}