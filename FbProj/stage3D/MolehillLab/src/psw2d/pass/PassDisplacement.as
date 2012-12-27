package psw2d.pass
{
	import flash.display3D.Context3D;
	
	public class PassDisplacement extends Pass
	{
		public function PassDisplacement(context:Context3D, isRenderToTexture:Boolean, width:Number=1, height:Number=1)
		{
			super(context, isRenderToTexture, width, height);
			
			_shaderVertex = "" +
				"mov op, va0\n" +
				"mov v0, va1\n";
			
			
			_shaderFragment = "" +
				"tex ft0, v0, fs1, <2d,clamp,linear,miplinear>\n" +            //     map perlin(fs1) to ft0
				"add ft1, ft0, fc0\n" +                                //     displacement ( x-.5, y-.5)
				"mul ft1, ft1, fc0.z\n" +                            //     multiply by the size
				"add ft2, v0, ft1\n" +                                //     add to coordinate
				"tex oc, ft2, fs0, <2d,clamp,linear,miplinear>\n";            //    map to outpur color
		}
	}
}