package states.internal;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import openfl.Lib;
import openfl.system.System;
#if android
import flixel.input.actions.FlxActionInput;
import android.AndroidControls.AndroidControls;
import android.FlxVirtualPad;
#end

class MusicBeatState extends FlxUIState
{
	private var lastBeat:Float = 0;
	private var lastStep:Float = 0;

	public var curStep:Int = 0;
	public var curBeat:Int = 0;

	private var controls(get, never):Controls;
	private var disableBeathit:Bool = false;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	#if android
	var _virtualpad:FlxVirtualPad;
	var androidc:AndroidControls;
	var trackedinputs:Array<FlxActionInput> = [];

	public function addVirtualPad(?DPad:FlxDPadMode, ?Action:FlxActionMode) {
		_virtualpad = new FlxVirtualPad(DPad, Action);
		_virtualpad.alpha = 0.75;
		add(_virtualpad);
		controls.setVirtualPad(_virtualpad, DPad, Action);
		trackedinputs = controls.trackedinputs;
		controls.trackedinputs = [];
	}

	public function addAndroidControls() {
  androidc = new AndroidControls();
		switch (androidc.mode)
		{
			case VIRTUALPAD_RIGHT | VIRTUALPAD_LEFT | VIRTUALPAD_CUSTOM:
				controls.setVirtualPad(androidc.vpad, FULL, NONE);
			case DUO:
				controls.setVirtualPad(androidc.vpad, DUO, NONE);
			case HITBOX:
				controls.setHitBox(androidc.hbox);
			default:
		}
		trackedinputs = controls.trackedinputs;
		controls.trackedinputs = [];
		var camcontrol = new flixel.FlxCamera();
		FlxG.cameras.add(camcontrol);
		camcontrol.bgColor.alpha = 0;
		androidc.cameras = [camcontrol];
		androidc.visible = false;
		add(androidc);
	}

        public function addPadCamera() {
		var camcontrol = new flixel.FlxCamera();
		FlxG.cameras.add(camcontrol);
		camcontrol.bgColor.alpha = 0;
		_virtualpad.cameras = [camcontrol];
	}
	#end

	override function destroy() {
		#if android
		controls.removeFlxInput(trackedinputs);
		#end	
		super.destroy();
	}

	private var _clearMemory:Bool = false;

	public function new(clearMemory:Bool = false)
	{
		super();
		_clearMemory = clearMemory;
	}

	override function create()
	{
		if (_clearMemory)
			Main.clearMemory(false);

		(cast(Lib.current.getChildAt(0), Main)).setFPSCap(ClientPrefs.fpsCap);

		super.create();
	}

	override function update(elapsed:Float)
	{
		// everyStep();
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep && curStep > 0)
			stepHit();

		super.update(elapsed);
	}

	private function updateBeat():Void
	{
		lastBeat = curStep;
		curBeat = Math.floor(curStep / 4);
	}

	private function updateCurStep():Void
	{
		var lastChange:BPMChangeEvent = {
			stepTime: 0,
			songTime: 0,
			bpm: 0
		}
		for (i in 0...Conductor.bpmChangeMap.length)
		{
			if (Conductor.songPosition >= Conductor.bpmChangeMap[i].songTime)
				lastChange = Conductor.bpmChangeMap[i];
		}

		curStep = lastChange.stepTime + Math.floor((Conductor.songPosition - lastChange.songTime) / Conductor.stepCrochet);
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0 && !disableBeathit)
			beatHit();
	}

	public function beatHit():Void
	{
		// do literally nothing dumbass
	}

	inline public function fancyOpenURL(schmancy:String)
	{
		#if linux
		return Sys.command('/usr/bin/xdg-open', [schmancy, "&"]);
		#else
		return FlxG.openURL(schmancy);
		#end
	}

	override function onFocus()
	{
		System.gc();
		super.onFocus();
	}

	override function onFocusLost()
	{
		System.gc();
		super.onFocusLost();
	}
}
