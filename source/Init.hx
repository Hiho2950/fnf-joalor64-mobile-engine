package;

#if desktop
import meta.data.dependency.Discord.DiscordClient;
#end
import meta.*;
import meta.state.*;
import meta.data.*;
import flixel.FlxG;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;

#if FUTURE_POLYMOD
import core.ModCore;
#end

import haxe.Http;
import lime.app.Application;
import backend.Mods;

// this loads everything in
class Init extends FlxState
{
	public static var updateVersion:String = '';

    	var mustUpdate:Bool = false;

	override function create()
    	{
        	#if html5
		Paths.initPaths();
		#end

        	#if LUA_ALLOWED
		Mods.pushGlobalMods();
		#end
		// Just to load a mod on start up if ya got one. For mods that change the menu music and bg
		Mods.loadTheFirstEnabledMod();
		#if FUTURE_POLYMOD
		ModCore.reload();
		#end

		FlxG.game.focusLostFramerate = 60;

		FlxG.sound.muteKeys = [FlxKey.ZERO];
		FlxG.sound.volumeDownKeys = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
		FlxG.sound.volumeUpKeys = [FlxKey.NUMPADPLUS, FlxKey.PLUS];
		FlxG.keys.preventDefaultKeys = [TAB];

		ClientPrefs.loadPrefs();
        	PlayerSettings.init();
        	Highscore.load();

        	if (FlxG.save.data.weekCompleted != null)
		{
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}
		
        	FlxG.mouse.visible = false;

        	FlxG.save.bind('j64enginerewrite', 'joalor64gh');
        	if(FlxG.save.data != null && FlxG.save.data.fullscreen)
		{
			FlxG.fullscreen = FlxG.save.data.fullscreen;
		}
			
        	persistentUpdate = true;
		persistentDraw = true;
            	FlxG.switchState(new TitleState());
        	super.create();
    	}
}
