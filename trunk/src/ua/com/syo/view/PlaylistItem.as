package ua.com.syo.view {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	
	import ua.com.syo.data.CurrentData;
	import ua.com.syo.model.VideoItem;
	
	public class PlaylistItem extends Sprite {
		
		[Embed(source = "/../assets/library.swf" , symbol = "PlaylistItem")]
		private var ListItem:Class;
		
		private var listItem:Sprite;
		private var thumbContainer:MovieClip;
		private var loader:Loader;
		private var titleTF:TextField;
		private var videoItem:VideoItem;
		
		public function PlaylistItem(vi:VideoItem) {
			videoItem = vi;
			listItem = new ListItem();
			titleTF = listItem["titleTF"];
			thumbContainer = listItem["thumbC"];
			titleTF.text = vi.title;
			addChild(listItem);
			loadThumb(vi.thumbUrl);
			
			var tint:MovieClip = listItem["tint"];
			tint.visible = false;
			listItem.buttonMode = true;
			
			listItem.addEventListener(MouseEvent.MOUSE_OVER, function():void {tint.visible = true;});
			listItem.addEventListener(MouseEvent.MOUSE_OUT, function():void {tint.visible = false;});
			listItem.addEventListener(MouseEvent.MOUSE_DOWN, mouseClickHandler);
		}
		
		private function loadThumb(url:String):void {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbLoadedHandler);
			var request:URLRequest = new URLRequest(CurrentData.instance.rootURL + url);
			loader.load(request);
		}
		
		private function thumbLoadedHandler(event:Event):void {
			loader.content.scaleX =  loader.content.scaleY = 76 / loader.height;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, thumbLoadedHandler);
			thumbContainer.addChild(loader.content);
		}
		
		private function mouseClickHandler(event:MouseEvent):void {
			navigateToURL(new URLRequest(videoItem.url));
		}
	}
}