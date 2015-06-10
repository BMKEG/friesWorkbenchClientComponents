package edu.isi.bmkeg.digitalLibraryModule.model
{
	import flash.display.Bitmap;
	
	import mx.collections.ArrayCollection;
	
	import spark.primitives.*;

	public class FragmentHolderForPage extends Object
	{

		[Bindable]
		public var image:Bitmap;

		[Bindable]
		public var pdfScale:Number;

		[Bindable]
		public var runningCount:int;
		
		[Bindable]
		public var page:int;

		[Bindable]
		public var extraRectangles:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var fragmentInProgress:Path;
		
		[Bindable]
		public var fragmentsAdded:ArrayCollection = new ArrayCollection();
		
		public function FragmentHolderForPage(pdfScale:Number)
		{
			super();
			this.pdfScale = pdfScale;
		}
		
	}
	
}