package com.physwf.components.view
{
	import com.physwf.components.bitmap.display.BitmapPlayer;
	import com.physwf.components.bitmap.events.PackageEvent;
	import com.physwf.components.bitmap.net.SkeletonLoader;
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Animation extends Sprite implements IUpdatable,IDisposible
	{
		private var mPlayer:BitmapPlayer;
		private var mSkeleton:SkeletonLoader;//
		private var mIsPlaying:Boolean = true;
		
		public function Animation(skeleton:SkeletonLoader)
		{
			mPlayer = new BitmapPlayer();
			addChild(mPlayer);
			mSkeleton = skeleton;
		}
		
		public function gotoAndStop(frame:Object):void
		{
			var action:String = frame.toString();
			function onComplete(e:Event):void
			{
				var directs:Vector.<String> = mSkeleton.getDirections();
				var diret:String = directs[0];//动画的文件应该只包含一个方向，如果包含多个方向应该用CharacterAnimation
				mPlayer.bitmapFrames = mSkeleton.getAction(diret,action);
				mPlayer.currentFrame = 0;
			};
			mSkeleton.addEventListener(PackageEvent.PACKAGE_ALL_INITED,onComplete);
			mSkeleton.load();
			stop();
		}
		
		public function gotoAndPlay(frame:Object):void
		{
			var action:String = frame.toString();
			function onComplete(e:Event):void
			{
				var directs:Vector.<String> = mSkeleton.getDirections();
				var diret:String = directs[0];//动画的文件应该只包含一个方向，如果包含多个方向应该用CharacterAnimation
				mPlayer.bitmapFrames = mSkeleton.getAction(diret,action);
				mPlayer.currentFrame = 0;
			};
			mSkeleton.addEventListener(PackageEvent.PACKAGE_ALL_INITED,onComplete);
			mSkeleton.load();
			play();
		}
		
		public function stop():void
		{
			mIsPlaying = false;
		}
		
		public function play():void
		{
			mIsPlaying = true;
		}
		
		public function update():void
		{
			if(mIsPlaying)
			{
				mPlayer.nextFrame();
			}
		}
		
		public function destroy():void
		{
			mPlayer.destroy();
			mPlayer = null;
		}
		
	}
}