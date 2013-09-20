package 
{
	import alternativa.engine3d.alternativa3d;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Stesel
	 */
	
	 
	 
	public class Preloader extends MovieClip 
	{
		
		private var myContextMenu:ContextMenu;
		private var vsItem:ContextMenuItem;
		private var myItem:ContextMenuItem;
		
		
		private var preloaderClip: SimpPreLoader = new SimpPreLoader();
		private var contSprite:Sprite;
		
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.stageFocusRect = false;
				stage.quality = StageQuality.HIGH;
			}
			
			contSprite = new Sprite();
			contSprite.graphics.beginFill(0Xffd7b6, 0.5);
			contSprite.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			addChild(contSprite);
			
			
			preloaderClip.x = stage.stageWidth/2 - 50;
			preloaderClip.y = (stage.stageHeight - preloaderClip.height) / 2;
			addChild(preloaderClip);
			
			
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			stage.addEventListener(Event.RESIZE, onStageResize);
			// TODO show loader
			
			
			
			
				myContextMenu = new ContextMenu();
				myContextMenu.hideBuiltInItems();
				contSprite.contextMenu = myContextMenu;
				vsItem = new ContextMenuItem("Powered by Stesel",true);
				//myItem = new ContextMenuItem("Stesel",true);
				vsItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, vslink);
				//myItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, mylink);
		
		
		//var myMenu:ContextMenu = new ContextMenu(); 
		//
		//
		myContextMenu.customItems.push(vsItem); 
		//myContextMenu.hideBuiltInItems(); 
		this.contextMenu = myContextMenu; 
		
			
			
		}
		
		private function onStageResize(e:Event):void 
		{
			contSprite.width = stage.stageWidth;
			contSprite.height = stage.stageHeight;
		}
		
		//private function mylink(e:Event):void 
		//{
			//navigateToURL(new URLRequest("http://vk.com/stesel23"));
		//}
		
		private function vslink(e:Event):void 
		{
			navigateToURL(new URLRequest("http://vk.com/stesel23"));
			//navigateToURL(new URLRequest("http://vsadu.elitno.net/"));
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// TODO update loader
			preloaderClip.bar.scaleX = (e.target.bytesLoaded / e.target.bytesTotal );
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				
				stop();
				loadingFinished();
				
				setTimeout(remPreloader, 1000);
			}
		}
		
		private function remPreloader():void 
		{
			removeChild(preloaderClip);
			preloaderClip = null;
			//removeChild(contSprite);
			contSprite.alpha = 0;
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}