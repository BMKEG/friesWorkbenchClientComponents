package edu.isi.bmkeg.indexCd.model
{
	import edu.isi.bmkeg.indexCd.model.Entity;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ProteinFamily extends Entity
	{
		public function ProteinFamily(){}

		public var features:ArrayCollection = new ArrayCollection();
		
		public var not_features:ArrayCollection = new ArrayCollection();
	}
}