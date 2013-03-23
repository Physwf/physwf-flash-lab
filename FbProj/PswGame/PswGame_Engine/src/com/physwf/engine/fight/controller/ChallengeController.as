package com.physwf.engine.fight.controller
{
	import com.physwf.components.charactor.CharacterAnimation;
	import com.physwf.components.charactor.enum.CharacterAction;
	import com.physwf.components.command.Command;
	import com.physwf.components.ds.heap.MaxHeap;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.command.CmdGoTo;
	import com.physwf.engine.common.events.MonsterEvent;
	import com.physwf.engine.fight.Fight;
	import com.physwf.engine.fight.manager.Challenge;
	import com.physwf.engine.world.objects.Character;
	import com.physwf.engine.world.objects.Monster;
	import com.physwf.engine.world.objects.Player;
	import com.physwf.system.System;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import flashx.textLayout.utils.CharacterUtil;
	
	import mx.core.mx_internal;

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
			view.addEventListener(MonsterEvent.MONSTER_SELECTED,onMonsterSelect);
		}
		
		private function onMonsterSelect(e:MonsterEvent):void
		{
			var target:Monster = Engine.map.getMonsterByMID(e.info.instanceID);
			mView.setTarget(target,target.id);
			Challenge.targetEffect.changeTarget(target.view);
			return;
		}
	}
}