package ua.com.syo.view {
	import flash.display.Sprite;

	public class ControlPanel extends Sprite {
		
		[Embed(source = "/../assets/library.swf" , symbol = "AllControls")]
		private var AllControls:Class;
		
		public function ControlPanel() {
			var bg:Sprite = new AllControls();
			addChild(bg);
		}
		
	}
}