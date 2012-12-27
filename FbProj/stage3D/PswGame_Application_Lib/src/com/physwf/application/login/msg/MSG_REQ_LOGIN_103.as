package com.physwf.application.login.msg
{
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;

	public class MSG_REQ_LOGIN_103 extends MsgBase
	{
		public var password:String;
		public var channel:int;
		public var which_game:int;
		public var user_ip:int;
		public var img_id:int;
		public var verify_code:int;
		public var tag:*;
		
		public function MSG_REQ_LOGIN_103()
		{
			super(103);
		}
		/**
		 * //  米米号登陆
			//			uint8_t     passwd[32];
			//			uint32_t    channel;
			//			uint32_t    which_game;
			//			uint32_t    user_ip;
			//			char        img_id[16];
			//			char        verif_code[6];
			//			char        login_promot_tag[64];  
			// 邮件登陆
			//			uint8_t     passwd[32];
			//			uint32_t    channel;
			//			uint32_t    cli_channel_id;
			//			uint32_t    which_game;
			//			uint32_t    user_ip;
			//			uint8_t     email[64];
			//			char        img_id[16];
			//			char        verif_code[6];
			//			uint8_t     verif_pass;
			//			char        login_promot_tag[64];
		 * @param output
		 */		
		override protected function writeBody(output:IDataOutput):void
		{
			var passwordData:ByteArray = new ByteArray();
			passwordData.writeUTFBytes(password);
			output.writeBytes(passwordData);
			
			output.writeUnsignedInt(channel);
			output.writeUnsignedInt(which_game);
			output.writeUnsignedInt(user_ip);
			
			var img_idData:ByteArray = new ByteArray();
			img_idData.length = 16;
			output.writeBytes(img_idData);
			
			var verify_codeData:ByteArray = new ByteArray();
			verify_codeData.length = 6;
			output.writeBytes(verify_codeData);
			
			var tagData:ByteArray = new ByteArray();
			tagData.length = 64;
			output.writeBytes(tagData);
		}
	}
}