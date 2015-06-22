package edu.isi.bmkeg.indexCd.model
{
	import edu.isi.bmkeg.indexCd.model.Interaction;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class InhibitsModification extends Interaction
	{
		public function InhibitsModification(){}

		public var modifications:ArrayCollection = new ArrayCollection();
	}
}