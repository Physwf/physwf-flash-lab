package com.physwf.components.screen.layer
{
	import com.physwf.components.interfaces.IView;

	public interface ILayer
	{
		function addView(view:IView):IView;
		function removeView(view:IView):IView;
	}
}