package engine.common.command
{
	import flash.events.Event;
	
	import components.command.Command;
	
	import engine.world.objects.Character;
	
	public class CmdStand extends Command
	{
		private var mChara:Character;
		
		public function CmdStand(chara:Character)
		{
			mChara = chara;
		}
		
		override public function execute():void
		{
			mChara.stand();
			dispatchEvent(new Event(Command.FINISH));
		}
		
		override public function update(delta:uint):void
		{
			super.update(delta);
		}
	}
}