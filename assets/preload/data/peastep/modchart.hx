import Conductor;
import PlayState;

var currentBeat:Float;
var camHudAngle:Float;

function onCreate() {
	for (i in 0...PlayState.strumLineNotes.length)
	{
		var member = PlayState.strumLineNotes.members[i];
		setGlobalVar("defaultStrum" + i + "X", Math.floor(member.x));
		setGlobalVar("defaultStrum" + i + "Y", Math.floor(member.y));
	}

	setCamZoom(1);
}

function onUpdate(elapsed:Float) {
	if (ClientPrefs.modchart) {
		if (curStep >= 0 && curStep < 8 || curStep >= 16 && curStep < 20 || curStep >= 64 && curStep < 72 || curStep >= 80 && curStep < 84 || curStep >= 128 && curStep < 136 || curStep >= 144 && curStep < 148 || curStep >= 192 && curStep < 200 || curStep >= 208 && curStep < 212 || curStep >= 512 && curStep < 520 || curStep >= 528 && curStep < 532 || curStep >= 896 && curStep < 904 || curStep >= 912 && curStep < 916 || curStep >= 960 && curStep < 968 || curStep >= 976 && curStep < 980 || curStep >= 1152 && curStep < 1160 || curStep >= 1168 && curStep < 1172 || curStep >= 1216 && curStep < 1222 || curStep >= 1232 && curStep < 1236 || curStep >= 1024 && curStep < 1032 || curStep >= 1040 && curStep < 1044 || curStep >= 1088 && curStep < 1096 || curStep >= 1104 && curStep < 1108 || curStep >= 512 && curStep < 520 || curStep >= 528 && curStep < 532 || curStep >= 576 && curStep < 584 || curStep >= 592 && curStep < 596) {
			currentBeat = (Conductor.songPosition / 1000) * (Conductor.bpm / 5);
			for (i in 0...4)
				setNoteX(getGlobalVar("defaultStrum" + i + "X") + 10 * Math.sin((currentBeat + i*50) * Math.pi), i);
			for (i in 5...8)
				setNoteX(getGlobalVar("defaultStrum" + i + "X") + -10 * Math.sin((currentBeat + i*50) * Math.pi), i);
		}

		if (curStep >= 32 && curStep < 36 || curStep >= 96 && curStep < 100 || curStep >= 160 && curStep < 164 || curStep >= 224 && curStep < 228 || curStep >= 544 && curStep < 548 || curStep >= 608 && curStep < 612 || curStep >= 928 && curStep < 932 || curStep >= 992 && curStep < 996 || curStep >= 1056 && curStep < 1060 || curStep >= 1120 && curStep < 1124 || curStep >= 1184 && curStep < 1188 || curStep >= 1248 && curStep < 1252) {
			currentBeat = (Conductor.songPosition / 1000) * (Conductor.bpm / 30);
			for (i in 0...4)
				setNoteX(getGlobalVar("defaultStrum" + i + "X") + 50 * Math.sin((currentBeat + i*25) * Math.pi), i);
			for (i in 5...8)
				setNoteX(getGlobalVar("defaultStrum" + i + "X") + -50 * Math.sin((currentBeat + i*25) * Math.pi), i);
		}

		if (curStep >= 28 && curStep < 32 || curStep >= 36 && curStep < 40 || curStep >= 92 && curStep < 96 || curStep >= 100 && curStep < 104 || curStep >= 156 && curStep < 160 || curStep >= 164 && curStep < 168 || curStep >= 220 && curStep < 224 || curStep >= 228 && curStep < 232 || curStep >= 540 && curStep < 544 || curStep >= 548 && curStep < 552 || curStep >= 604 && curStep < 608 || curStep >= 612 && curStep < 616 || curStep >= 924 && curStep < 928 || curStep >= 932 && curStep < 936 || curStep >= 988 && curStep < 992 || curStep >= 996 && curStep < 1000 || curStep >= 1052 && curStep < 1056 || curStep >= 1060 && curStep < 1064 || curStep >= 1116 && curStep < 1120 || curStep >= 1124 && curStep < 1128 || curStep >= 1180 && curStep < 1184 || curStep >= 1188 && curStep < 1192 || curStep >= 1244 && curStep < 1248 || curStep >= 1252 && curStep < 1256) {
			currentBeat = (Conductor.songPosition / 1000) * (Conductor.bpm / 60);
			for (i in 0...4)
				setNoteX(getGlobalVar("defaultStrum" + i + "X") + -50 * Math.sin((currentBeat + i*25) * Math.pi), i);
			for (i in 5...8)
				setNoteX(getGlobalVar("defaultStrum" + i + "X") + 50 * Math.sin((currentBeat + i*25) * Math.pi), i);
		}

		if (curStep >= 48 && curStep < 64 || curStep >= 112 && curStep < 128 || curStep >= 176 && curStep < 192 || curStep >= 240 && curStep < 256 || curStep >= 560 && curStep < 576 || curStep >= 944 && curStep < 960 || curStep >= 1008 && curStep < 1024 || curStep >= 1072 && curStep < 1088 || curStep >= 1136 && curStep < 1152 || curStep >= 1200 && curStep < 1216 || curStep >= 1264) {
			currentBeat = (Conductor.songPosition / 1000) * (Conductor.bpm / 60);
			for (i in 0...4) {
				setNoteX(getGlobalVar("defaultStrum" + i + "X") + -50 * Math.sin((currentBeat + i*50) * Math.pi), i);
				setNoteY(getGlobalVar("defaultStrum" + i + "Y") + -50 * Math.sin((currentBeat + i*50) * Math.pi), i);
			for (i in 5...8) {
				setNoteX(getGlobalVar("defaultStrum" + i + "X") + 50 * Math.sin((currentBeat + i*50) * Math.pi), i);
				setNoteY(getGlobalVar("defaultStrum" + i + "Y") + 50 * Math.sin((currentBeat + i*50) * Math.pi), i);
			}}
		}

		if (curStep >= 176 && curStep < 180 || curStep >= 184 && curStep < 188 || curStep >= 240 && curStep < 244 || curStep >= 248 && curStep < 252 || curStep >= 560 && curStep < 564 || curStep >= 568 && curStep < 572 || curStep >= 1072 && curStep < 1076 || curStep >= 1080 && curStep < 1084 || curStep >= 1136 && curStep < 1140 || curStep >= 1144 && curStep < 1148) {
			currentBeat = (Conductor.songPosition / 1000) * (Conductor.bpm / 30);
			for (i in 0...8)
				setNoteX(getGlobalVar("defaultStrum" + i + "X") + -50 * Math.sin((currentBeat + i*50) * Math.pi), i);
		}

		if (curStep >= 48 && curStep < 64 || curStep >= 112 && curStep < 128 || curStep >= 176 && curStep < 192 || curStep >= 240 && curStep < 256 || curStep >= 560 && curStep < 576 || curStep >= 944 && curStep < 960 || curStep >= 1008 && curStep < 1024 || curStep >= 1072 && curStep < 1088 || curStep >= 1136 && curStep < 1152 || curStep >= 1200 && curStep < 1216 || curStep >= 1264) {
			currentBeat = (Conductor.songPosition / 1000) * (Conductor.bpm / 120);
			for (i in 0...8)
				setNoteX(getGlobalVar("defaultStrum" + i + "X") + -50 * Math.sin((currentBeat + i*50) * Math.pi), i);
		}


		// NON-NOTES PART
		if (curStep >= 128 && curStep < 136 || curStep >= 192 && curStep < 200 || curStep >= 512 && curStep < 520 || curStep >= 576 && curStep < 584)
			camHudAngle = camHudAngle + 0.2;

		if (curStep >= 144 && curStep < 148 || curStep >= 208 && curStep < 212 || curStep >= 528 && curStep < 532 || curStep >= 592 && curStep < 596)
			camHudAngle = camHudAngle - 0.5;

		if (curStep >= 156 && curStep < 158 || curStep >= 220 && curStep < 222 || curStep >= 540 && curStep < 542 || curStep >= 604 && curStep < 606)
			camHudAngle = camHudAngle + 0.2;

		if (curStep == 161 || curStep == 224 || curStep == 545 || curStep == 608)
			camHudAngle = 0;

		if (curStep == 136 || curStep == 138 || curStep == 140 || curStep == 142 || curStep == 148 || curStep == 150 || curStep == 152 || curStep == 154 || curStep == 168 || curStep == 170 || curStep == 172 || curStep == 174 || curStep == 200 || curStep == 202 || curStep == 204 || curStep == 206 || curStep == 212 || curStep == 214 || curStep == 216 || curStep == 218 || curStep == 232 || curStep == 234 || curStep == 236 || curStep == 238 || curStep == 520 || curStep == 522 || curStep == 524 || curStep == 526 || curStep == 532 || curStep == 534 || curStep == 536 || curStep == 538 || curStep == 552 || curStep == 554 || curStep == 556 || curStep == 558 || curStep == 584 || curStep == 586 || curStep == 588 || curStep == 590 || curStep == 596 || curStep == 598 || curStep == 600 || curStep == 602 || curStep == 616 || curStep == 618 || curStep == 620 || curStep == 622 || curStep == 1032 || curStep == 1034 || curStep == 1036 || curStep == 1038 || curStep == 1044 || curStep == 1046 || curStep == 1047 || curStep == 1048 || curStep == 1050 || curStep == 1064 || curStep == 1066 || curStep == 1068 || curStep == 1069 || curStep == 1070)
			setCamZoom(1);

		if (curStep == 1024 || curStep == 1088)
			setCamZoom(1.05);

		if (curStep >= 1072 && curStep < 1074 || curStep >= 1136 && curStep < 1138)
			setCamZoom(1);

		if (curStep >= 1074 && curStep < 1076 || curStep >= 1138 && curStep < 1140)
			setCamZoom(1.02);

		if (curStep >= 1076 && curStep < 1080 || curStep >= 1140 && curStep < 1144)
			setCamZoom(1.04);

		if (curStep >= 1080 && curStep < 1082 || curStep >= 1144 && curStep < 1146)
			setCamZoom(1.06);

		if (curStep >= 1082 && curStep < 1084 || curStep >= 1146 && curStep < 1148)
			setCamZoom(1.08);

		if (curStep >= 1084 && curStep < 1088 || curStep >= 1148 && curStep < 1152)
			setCamZoom(1.1);

		if (curStep == 128 || curStep == 134 || curStep == 136 || curStep == 138 || curStep == 141 || curStep == 143 || curStep == 145 || curStep == 147 || curStep == 149 || curStep == 151 || curStep == 155 || curStep == 161 || curStep == 163 || curStep == 169 || curStep == 171 || curStep == 173 || curStep == 175 || curStep == 177 || curStep == 179 || curStep == 183 || curStep == 187 || curStep == 191 || curStep == 624) {
			FlxTween.tween(PlayState.strumLineNotes.members[i], {x: 0, y: 0, angle: toAngle}, 0.1, {
				ease: FlxEase.linear,
			});
		}

		camHUD.angle = camHudAngle;
	}
}

function onBeatHit(curBeat:Int) {
	if (curStep >= 382 && curStep < 510 || curStep >= 638 && curStep < 894) {
		setCamZoom(0.92);
		setHudZoom(1.02);
	}
}

function setCamZoom(zoomAmount:Float) {
	if (!PlayState.disableModCamera)
		FlxG.camera.zoom = zoomAmount;
}

function setHudZoom(zoomAmount:Float) {
	if (!PlayState.disableModCamera)
	{
		camHUD.zoom = zoomAmount;
	}
}