package{
    import flash.display.*;
    import adobe.utils.*;
    import flash.events.*;
    import flash.external.*;
    import flash.ui.*;
    import flash.system.System; 
    public class ClipBoard extends Sprite
    {	
        public function ClipBoard():void {        	
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE; 
            stage.addEventListener(MouseEvent.CLICK,clickHandler);
            createBrowseOverlay();

        }    
        private var oBrowseOverlay:Sprite;
        private function createBrowseOverlay() : void{
            oBrowseOverlay = new Sprite();
            oBrowseOverlay.buttonMode = true;
            oBrowseOverlay.useHandCursor = true;
            addChild(oBrowseOverlay);
            resizeBrowseOverlay();
        }
            
        private function resizeBrowseOverlay() : void{
            oBrowseOverlay.graphics.clear();
            oBrowseOverlay.graphics.beginFill(16711680, 0);
            oBrowseOverlay.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            oBrowseOverlay.graphics.endFill();
            return;
        }
            
        private function clickHandler(evt:Event):void {
        	//trace("click me");
            var content:String = ExternalInterface.call("getData") || " ";
            System.setClipboard(content);
            ExternalInterface.call("copySuccess");            
        }     
        
    }
     
}