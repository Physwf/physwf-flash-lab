package com.physwf.application.login.controller
{
	import com.physwf.application.login.cache.LoginContext;
	import com.physwf.application.login.cache.OnlineInfo;
	import com.physwf.application.login.msg.MSG_RES_CREATE_ROLE_107;
	import com.physwf.application.login.msg.MSG_RES_GET_RECOMMEND_SVR_LIST_105;
	import com.physwf.application.login.msg.MSG_RES_GET_ROLE_INFO_106;
	import com.physwf.application.login.msg.MSG_RES_LOGIN_103;
	import com.physwf.application.login.msg.MsgBase;
	import com.physwf.application.login.msg.recommend_area_list_t;
	import com.physwf.application.login.msg.role_detail_info;
	import com.physwf.application.login.rpc.MessageEvent;
	import com.physwf.application.login.rpc.RPCClient;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.vo.RoleInfo;
	import com.physwf.system.vo.ServerInfo;

	public class LoginController
	{
		public static var instance:LoginController = new LoginController();
		
		public var onLoginSuccess:Function;
		public var onLoginError:Function;
		public var onGetServerList:Function;
		public var onGetRoles:Function;
		public var onRoleCreated:Function;
		
		public function LoginController()
		{
		}
		
		public function initialize():void
		{
			RPCClient.addEventListener(MessageEvent.MSG_SUCCESS_+103,onMessage);
			RPCClient.addEventListener(MessageEvent.MSG_ERROR_+103,onMessage);
			
			RPCClient.addEventListener(MessageEvent.MSG_SUCCESS_+105,onMessage);
			RPCClient.addEventListener(MessageEvent.MSG_SUCCESS_+106,onMessage);
			RPCClient.addEventListener(MessageEvent.MSG_SUCCESS_+107,onMessage);
		}
		
		private function onMessage(e:MessageEvent):void
		{
			var msg:MsgBase = e.message;
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+103:
				{
					MySelf.loginInfo.session = (msg as MSG_RES_LOGIN_103).session;
					MySelf.userInfo.uid = msg.uid;
					MsgBase.UID = msg.uid;
					onLoginSuccess();
					break;
				}
				case MessageEvent.MSG_ERROR_+103:
				{
					LoginContext.img_id = MSG_RES_LOGIN_103(msg).img_id;
					LoginContext.img_data = MSG_RES_LOGIN_103(msg).img_data;
					onLoginError();
					break;
				}
				case MessageEvent.MSG_SUCCESS_+105://获得服务器列表
				{
					OnlineInfo.onlines = new <ServerInfo>[];
					var serverList:Vector.<recommend_area_list_t> = MSG_RES_GET_RECOMMEND_SVR_LIST_105(msg).recommend_svr_list;
					for(var i:int=0;i<serverList.length; i++)
					{
						var sInfo:ServerInfo = new ServerInfo();
						sInfo.area_id = serverList[i].area_id;
						sInfo.id = serverList[i].online_id;
						sInfo.ip = serverList[i].online_ip;
						sInfo.port = serverList[i].online_port;
						sInfo.user_num = serverList[i].user_num;
						OnlineInfo.onlines.push(sInfo);
					}
					onGetServerList();
					RPCClient.close();
					break;
				}
				case MessageEvent.MSG_SUCCESS_+106://获得角色列表
				{
					OnlineInfo.roles = new <RoleInfo>[];
					var roleList:Vector.<role_detail_info> = MSG_RES_GET_ROLE_INFO_106(msg).roles;
					for(i=0;i<roleList.length;++i)
					{
						var roleInfo:RoleInfo = new RoleInfo();
						roleInfo.createTime = roleList[i].role_tm;
						roleInfo.nick = roleList[i].nick;
						roleInfo.prof = roleList[i].sex;
						OnlineInfo.roles.push(roleInfo);
					}
					onGetRoles();
					break;
				}
				case MessageEvent.MSG_SUCCESS_+107://创建角色成功
				{
//					MySelf.loginInfo.roleInfo = new RoleInfo();
					MySelf.loginInfo.roleInfo.createTime = MSG_RES_CREATE_ROLE_107(msg).role_tm;
					onRoleCreated();
					break;
				}
			}
		}
	}
}