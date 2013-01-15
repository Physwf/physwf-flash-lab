package psw2d.pass
{
	import flash.display3D.Context3D;
	
	public class PassGaussianBlur extends Pass
	{
		public function PassGaussianBlur(context:Context3D, isRenderToTexture:Boolean, width:Number=1, height:Number=1)
		{
			super(context, isRenderToTexture, width, height);
			_shaderVertex = "m44 op,va0,vc0\n" +
				"mov v0,va1\n" +
				"sub v1,va1,vc1\n" +
				"sub v2,va1,vc1\n" +
				"add v3,va1,vc1\n" +
				"add v4,va1,vc1";
			_shaderFragment = "";
		}
	}
}