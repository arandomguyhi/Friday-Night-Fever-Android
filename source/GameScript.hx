package;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import sys.io.File;
import sys.FileSystem;
import hscript.Parser;
import hscript.Interp;
import flixel.util.FlxColor;

class GameScript extends Interp
{
    public var updatableVars:Array<String> = [];
    public var valid:Bool = false;

    public function new()
    {
        super();

        var path:String = "assets/data/" + PlayState.SONG.song.toLowerCase() + "/modchart.hx";
        if (!FileSystem.exists(path))
        {
            return;
        }

        for (i in Reflect.fields(PlayState.instance))
        {
            if (!variables.exists(i))
            {
                var reflected = Reflect.field(PlayState.instance, i);
                variables.set(i, reflected);

                if (reflected is Int || reflected is Bool || reflected is Float || reflected is String)
                {
                    //trace("Pushing " + i);
                    updatableVars.push(i);
                }
            }
        }

        for (i in Reflect.fields(PlayState))
        {
            if (!variables.exists(i))
            {
                var reflected = Reflect.field(PlayState, i);
                variables.set(i, reflected);
            }
        }

        variables.set("import", (classStr:String) -> {
            var split:Array<String> = classStr.split('.');
            trace("Importing class: " + split[split.length - 1]);
            variables.set(split[split.length - 1], Type.resolveClass(classStr));
        });

        variables.set("FlxG", flixel.FlxG);
        variables.set("FlxSprite", flixel.FlxSprite);
        variables.set("FlxPoint", FlxPoint);
        variables.set("Math", Math);
        variables.set("FlxTween", FlxTween);

        var tweenTypes:Dynamic = {PINGPONG: 4, BACKWARD: 16, LOOPING: 2, ONESHOT: 8, PERSIST: 1};
        variables.set("FlxTweenType", tweenTypes);
        variables.set("FlxEase", FlxEase);

        variables.set("Conductor", Conductor);
        variables.set("Paths", Paths);

        variables.set("strumLineNotes", PlayState.strumLineNotes.members); // WHY ARE THESE STATIC!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        variables.set("playerStrums", PlayState.playerStrums.members); // WHO HURT YOU KADE ENGINE
        variables.set("cpuStrums", PlayState.cpuStrums.members);

        variables.set("getIndexOfMember", (item:flixel.FlxBasic) -> {
            return PlayState.instance.members.indexOf(item);
        });

        variables.set("add", (item:flixel.FlxBasic, pos:Int = -1,  ?camera:flixel.FlxCamera) -> {
            if (pos != -1)
                PlayState.instance.insert(pos, item);
            else
                PlayState.instance.add(item);

            if (camera != null)
                item.cameras = [camera];
        });

        variables.set("snapCamera", (?pos:FlxPoint) -> {
            if (pos != null)
            {
                PlayState.instance.camFollow.setPosition(pos.x, pos.y);
            }

            var camFollow = PlayState.instance.camFollow;
            PlayState.instance.camGame.focusOn(pos == null ? new FlxPoint(camFollow.x, camFollow.y) : pos);
        });

        variables.set("game", FlxG.state);

        for (i in 0...PlayState.strumLineNotes.length)
        {
            var babyArrow = PlayState.strumLineNotes.members[i];
            if (variables.exists("defaultStrumPos"))
                variables.get("defaultStrumPos")[i] = new FlxPoint(babyArrow.x, babyArrow.y);
            else
                variables.set("defaultStrumPos", [new FlxPoint(babyArrow.x, babyArrow.y)]);
        }

        variables.set("remove", (item:flixel.FlxBasic) -> {
            PlayState.instance.remove(item);
        });

        variables.set("FlxColor", HScriptColorAccess);

        variables.set("assignShader", (item:flixel.FlxSprite, shader:String) -> {
            switch (shader)
            {
                case "BWShader": // keeping this here because dce is cringe
                    item.shader = new shaders.BWShader();
                case "SolidColorShader":
                    item.shader = new shaders.BadNun.SolidColorShader();
                default:
                    item.shader = null;
            }
        });
        
        updateVars();

        var parser = new Parser();
        parser.allowTypes = true;
        parser.allowJSON = true;
        valid = true;
        execute(parser.parseString(File.getContent(path)));

        callFunction("onScriptCreate");
    }

    public function callFunction(func:String, ?args:Array<Dynamic>)
    {
        if (variables[func] != null)
        {
            try 
            {
                if (args != null)
                    Reflect.callMethod(null, cast variables[func], args);
                else
                    variables[func]();
            }
            catch (e)
            {
                trace("SCRIPT ERROR: Failed calling function " + func + ". Error: " + e);
            }
        }
    }

    public function updateVars()
    {
        for (i in updatableVars)
        {
            var reflected = Reflect.field(PlayState.instance, i);
            if (variables[i] != reflected)
            variables.set(i, reflected);
        }
    }
}

class HScriptColorAccess
{
    public static var TRANSPARENT:FlxColor = 0x00000000;
    public static var WHITE:FlxColor = 0xFFFFFFFF;
    public static var GRAY:FlxColor = 0xFF808080;
    public static var BLACK:FlxColor = 0xFF000000;
    public static var GREEN:FlxColor = 0xFF008000;
    public static var LIME:FlxColor = 0xFF00FF00;
    public static var YELLOW:FlxColor = 0xFFFFFF00;
    public static var ORANGE:FlxColor = 0xFFFFA500;
    public static var RED:FlxColor = 0xFFFF0000;
    public static var PURPLE:FlxColor = 0xFF800080;
    public static var BLUE:FlxColor = 0xFF0000FF;
    public static var BROWN:FlxColor = 0xFF8B4513;
    public static var PINK:FlxColor = 0xFFFFC0CB;
    public static var MAGENTA:FlxColor = 0xFFFF00FF;
    public static var CYAN:FlxColor = 0xFF00FFFF;

    public static var colorLookup(default, null):Map<String, Int> = FlxColor.colorLookup;
    static var COLOR_REGEX = ~/^(0x|#)(([A-F0-9]{2}){3,4})$/i;

	public static inline function fromInt(Value:Int):FlxColor
    {
        return new FlxColor(Value);
    }

    public static inline function fromRGB(Red:Int, Green:Int, Blue:Int, Alpha:Int = 255):FlxColor
    {
        return FlxColor.fromRGB(Red, Green, Blue, Alpha);
    }

    public static inline function fromRGBFloat(Red:Float, Green:Float, Blue:Float, Alpha:Float = 1):FlxColor
    {
        return FlxColor.fromRGBFloat(Red, Green, Blue, Alpha);
    }

    public static inline function fromCMYK(Cyan:Float, Magenta:Float, Yellow:Float, Black:Float, Alpha:Float = 1):FlxColor
    {
        return FlxColor.fromCMYK(Cyan, Magenta, Yellow, Black, Alpha);
    }

	public static function fromHSB(Hue:Float, Saturation:Float, Brightness:Float, Alpha:Float = 1):FlxColor
    {
       return FlxColor.fromHSB(Hue, Saturation, Brightness, Alpha);
    }

	public static inline function fromHSL(Hue:Float, Saturation:Float, Lightness:Float, Alpha:Float = 1):FlxColor
    {
        return FlxColor.fromHSL(Hue, Saturation, Lightness, Alpha);
    }

	public static function fromString(str:String):Null<FlxColor>
    {
        return FlxColor.fromString(str);
    }

    public static inline function interpolate(Color1:FlxColor, Color2:FlxColor, Factor:Float = 0.5):FlxColor
    {
        return FlxColor.interpolate(Color1, Color2, Factor);
    }
}