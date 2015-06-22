package edu.isi.bmkeg.indexCd.model
{
	import edu.isi.bmkeg.indexCd.model.Interaction;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Binds extends Interaction
	{
		public function Binds(){}

		public var binding_site_a:String;

		public var binding_site_b:String;
	}
}