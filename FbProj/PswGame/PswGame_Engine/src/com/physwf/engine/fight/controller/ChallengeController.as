package com.physwf.engine.fight.controller
{
	import com.physwf.components.charactor.CharacterAnimation;
	import com.physwf.components.charactor.enum.CharacterAction;
	import com.physwf.components.ds.heap.MaxHeap;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.engine.Engine;
	import com.physwf.engine.command.CmdWalkTo;
	import com.physwf.engine.command.Command;
	import com.physwf.engine.fight.Fight;
	import com.physwf.engine.fight.manager.Challenge;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.engine.world.manager.Monster;
	import com.physwf.engine.world.manager.Player;
	import com.physwf.system.System;
	
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
			Engine.map.view.swapLayer.addEventListener(MouseEvent.CLICK,onSwapClick);
		}
		
		private function onSwapClick(e:MouseEvent):void
		{
			var target:Character = Character.managers[e.target] as Character;
			mView.setTarget(target,Monster(target).instanId);
			Mouse.cursor = MouseCursor.ARROW;
			return;
		}
	}
}