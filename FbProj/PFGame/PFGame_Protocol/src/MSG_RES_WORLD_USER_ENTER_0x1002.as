package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_ENTER_0x1002 extends MsgBase
	{
		public var user_info:user_info_t;
		public var server_time:uint;
		public var base_items:Vector.<db_base_item_t>;
		public var items:Vector.<db_item_t>;
		public var attires:Vector.<db_attire_t>;
		public var eggs:Vector.<db_egg_t>;
		public var attire_on:uint;
		public var pets:Vector.<db_pet_t>;
		public var user_skills:Vector.<db_user_skill_t>;
		public var pet_skills:Vector.<db_pet_skill_t>;
		public var pet_equipments:Vector.<db_pet_equipment_t>;
		public var hatch_eggs:Vector.<db_hatch_egg_t>;
		public var tasks:Vector.<db_task_t>;
		public var friends:Vector.<db_friend_t>;
		public var msgs:Vector.<db_msg_t>;
		public var events:Vector.<db_event_t>;
		public var mails:Vector.<mail_t>;
		
		public function MSG_RES_WORLD_USER_ENTER_0x1002(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_info= new user_info_t();
			user_info.readExternal(input)
			server_time = input.readUnsignedInt();
			var base_itemsLen:uint =input.readUnsignedInt();
			base_items= new Vector.<db_base_item_t>();
			for(var i:uint=0;i<base_itemsLen;i++)
			{
				var base_items_item:db_base_item_t = new db_base_item_t()
				base_items_item.readExternal(input);;
				base_items.push(base_items_item);
			}
			var itemsLen:uint =input.readUnsignedInt();
			items= new Vector.<db_item_t>();
			for(i=0;i<itemsLen;i++)
			{
				var items_item:db_item_t = new db_item_t()
				items_item.readExternal(input);;
				items.push(items_item);
			}
			var attiresLen:uint =input.readUnsignedInt();
			attires= new Vector.<db_attire_t>();
			for(i=0;i<attiresLen;i++)
			{
				var attires_item:db_attire_t = new db_attire_t()
				attires_item.readExternal(input);;
				attires.push(attires_item);
			}
			var eggsLen:uint =input.readUnsignedInt();
			eggs= new Vector.<db_egg_t>();
			for(i=0;i<eggsLen;i++)
			{
				var eggs_item:db_egg_t = new db_egg_t()
				eggs_item.readExternal(input);;
				eggs.push(eggs_item);
			}
			attire_on = input.readUnsignedInt();
			var petsLen:uint =input.readUnsignedInt();
			pets= new Vector.<db_pet_t>();
			for(i=0;i<petsLen;i++)
			{
				var pets_item:db_pet_t = new db_pet_t()
				pets_item.readExternal(input);;
				pets.push(pets_item);
			}
			var user_skillsLen:uint =input.readUnsignedInt();
			user_skills= new Vector.<db_user_skill_t>();
			for(i=0;i<user_skillsLen;i++)
			{
				var user_skills_item:db_user_skill_t = new db_user_skill_t()
				user_skills_item.readExternal(input);;
				user_skills.push(user_skills_item);
			}
			var pet_skillsLen:uint =input.readUnsignedInt();
			pet_skills= new Vector.<db_pet_skill_t>();
			for(i=0;i<pet_skillsLen;i++)
			{
				var pet_skills_item:db_pet_skill_t = new db_pet_skill_t()
				pet_skills_item.readExternal(input);;
				pet_skills.push(pet_skills_item);
			}
			var pet_equipmentsLen:uint =input.readUnsignedInt();
			pet_equipments= new Vector.<db_pet_equipment_t>();
			for(i=0;i<pet_equipmentsLen;i++)
			{
				var pet_equipments_item:db_pet_equipment_t = new db_pet_equipment_t()
				pet_equipments_item.readExternal(input);;
				pet_equipments.push(pet_equipments_item);
			}
			var hatch_eggsLen:uint =input.readUnsignedInt();
			hatch_eggs= new Vector.<db_hatch_egg_t>();
			for(i=0;i<hatch_eggsLen;i++)
			{
				var hatch_eggs_item:db_hatch_egg_t = new db_hatch_egg_t()
				hatch_eggs_item.readExternal(input);;
				hatch_eggs.push(hatch_eggs_item);
			}
			var tasksLen:uint =input.readUnsignedInt();
			tasks= new Vector.<db_task_t>();
			for(i=0;i<tasksLen;i++)
			{
				var tasks_item:db_task_t = new db_task_t()
				tasks_item.readExternal(input);;
				tasks.push(tasks_item);
			}
			var friendsLen:uint =input.readUnsignedInt();
			friends= new Vector.<db_friend_t>();
			for(i=0;i<friendsLen;i++)
			{
				var friends_item:db_friend_t = new db_friend_t()
				friends_item.readExternal(input);;
				friends.push(friends_item);
			}
			var msgsLen:uint =input.readUnsignedInt();
			msgs= new Vector.<db_msg_t>();
			for(i=0;i<msgsLen;i++)
			{
				var msgs_item:db_msg_t = new db_msg_t()
				msgs_item.readExternal(input);;
				msgs.push(msgs_item);
			}
			var eventsLen:uint =input.readUnsignedInt();
			events= new Vector.<db_event_t>();
			for(i=0;i<eventsLen;i++)
			{
				var events_item:db_event_t = new db_event_t()
				events_item.readExternal(input);;
				events.push(events_item);
			}
			var mailsLen:uint =input.readUnsignedInt();
			mails= new Vector.<mail_t>();
			for(i=0;i<mailsLen;i++)
			{
				var mails_item:mail_t = new mail_t()
				mails_item.readExternal(input);;
				mails.push(mails_item);
			}			
		}
	}
}