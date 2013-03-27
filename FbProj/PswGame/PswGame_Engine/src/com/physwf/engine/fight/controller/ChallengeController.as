package com.physwf.engine.fight.controller
{
	import com.physwf.components.command.Command;
	import com.physwf.components.ds.heap.MaxHeap;
	import com.physwf.engine.common.events.CharacterEvent;
	import com.physwf.engine.fight.manager.Challenge;
	import com.physwf.engine.world.objects.Monster;

	public class ChallengeController
	{
		private var mView:Challenge;
		private var mCmdQueue:MaxHeap;
		private var mCurCmd:Command;
		
		public function ChallengeController()
		{
			mCmdQueue = new MaxHeap(10);
		}
		
		public function initialize(view:Challenge):void
		{
			mView = view;
			view.addEventListener(CharacterEvent.MONSTER_SELECTED,onMonsterSelect);
		}
		
		private function onMonsterSelect(e:CharacterEvent):void
		{
			var target:Monster = e.charactor as Monster;
			mView.setTarget(target,target.id);
			Challenge.targetEffect.changeTarget(target.view);
			return;
		}
	}
}