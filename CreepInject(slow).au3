#include <Misc.au3>
#include <AutoItConstants.au3>

HotKeySet("{TAB}", "inject")
HotKeySet("w", "spread")
HotKeySet("{F5}", "stop")
HotKeySet("{F6}", "stop")
;;;HotKeySet("{F7}", "position")
HotKeySet("{F8}", "quit")

HotKeySet("{NUMPADADD}", "baseadd")
HotKeySet("{NUMPADSUB}", "basesub")

HotKeySet("{NUMPAD1}", "setdirection1")
HotKeySet("{NUMPAD2}", "setdirection2")
HotKeySet("{NUMPAD3}", "setdirection3")
HotKeySet("{NUMPAD4}", "setdirection4")
HotKeySet("{NUMPAD6}", "setdirection6")
HotKeySet("{NUMPAD7}", "setdirection7")
HotKeySet("{NUMPAD8}", "setdirection8")
HotKeySet("{NUMPAD9}", "setdirection9")

Global $objsp = ObjCreate("SAPI.SpVoice")
Global $myMouse = 0

Global $xCreepBarHotkey = 688
Global $yCreepBarHotkey = 913
Global $xyCreepBarOffset = 58
Global $xSpreadOffset = 0
Global $ySpreadOffset = 0
Global $xCenter = 966
Global $yCenter = 448
Global $xyCreepDistance = 60
Global $SpreadOrRemap = 1
Global $forceStop = 0
Global $timer = 0
Global $startToCreep = 0
Global $numInjects = 2

Func SetDelay()
    ;;;; Set Delay For Most Options
    AutoItSetOption("MouseClickDelay", 0)
    AutoItSetOption("MouseClickDownDelay", 0)
	AutoItSetOption("MouseClickDragDelay", 0)
    AutoItSetOption("SendKeyDelay", 0)
    AutoItSetOption("SendKeyDownDelay", 0)
EndFunc

;;;;;;;;;;;;;;;;;;;
;;; Main code ;;;;;

SetDelay()

While 1
	If $timer >= 220 AND Mod($timer, 110) = 0  AND $startToCreep = 1 Then
		$objsp.Speak("C")
	EndIf
	
	Sleep(200)
	$timer = $timer + 2
WEnd

;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;

Func position()
	Local $aPos = MouseGetPos()
	Local $color = PixelGetColor($aPos[0], $aPos[1])
	ToolTip('X: ' & $aPos[0] & ', Y: ' & $aPos[1] & ', colo: ' & $color, 5, 700)
EndFunc

Func quit()
	$objsp.Speak("Exit")
	Exit 0
EndFunc

Func stop()
	$forceStop = 1
	$startToCreep = 0
EndFunc

Func setdirection1()
	$objsp.Speak("1")
	$SpreadOrRemap = 1
	$xSpreadOffset = (-1) * $xyCreepDistance
	$ySpreadOffset = (+1) * $xyCreepDistance
EndFunc

Func setdirection2()
	$objsp.Speak("2")
	$SpreadOrRemap = 1
	$xSpreadOffset = (0) * $xyCreepDistance
	$ySpreadOffset = (+1) * $xyCreepDistance
EndFunc

Func setdirection3()
	$objsp.Speak("3")
	$SpreadOrRemap = 1
	$xSpreadOffset = (+1) * $xyCreepDistance
	$ySpreadOffset = (+1) * $xyCreepDistance
EndFunc

Func setdirection4()
	$objsp.Speak("4")
	$SpreadOrRemap = 1
	$xSpreadOffset = (-1) * $xyCreepDistance
	$ySpreadOffset = (0) * $xyCreepDistance
EndFunc

Func setdirection6()
	$objsp.Speak("6")
	$SpreadOrRemap = 1
	$xSpreadOffset = (+1) * $xyCreepDistance
	$ySpreadOffset = (0) * $xyCreepDistance
EndFunc

Func setdirection7()
	$objsp.Speak("7")
	$SpreadOrRemap = 1
	$xSpreadOffset = (-1) * $xyCreepDistance
	$ySpreadOffset = (-1) * $xyCreepDistance
EndFunc

Func setdirection8()
	$objsp.Speak("8")
	$SpreadOrRemap = 1
	$xSpreadOffset = (0) * $xyCreepDistance
	$ySpreadOffset = (-1) * $xyCreepDistance
EndFunc

Func setdirection9()
	$objsp.Speak("9")
	$SpreadOrRemap = 1
	$xSpreadOffset = (+1) * $xyCreepDistance
	$ySpreadOffset = (-1) * $xyCreepDistance
EndFunc

Func basesub()
	Local $str = ""
	
	$numInjects -= 1
	$str = String($numInjects)
	$objsp.Speak($str)
EndFunc

Func baseadd()
	Local $str = ""
	
	$numInjects += 1
	$str = String($numInjects)
	$objsp.Speak($str)
EndFunc

Func spread()
	Local $pCreepColorPos = 0
	Local $pCreepSpreadColor = 0
	Local $cQueue = 0
	Local $rx = 0
	Local $ry = 0
	Local $lastCreep = 0
	Local $lastRun = 0
	
	$startToCreep = 1
	
	If $forceStop = 1 Then
		$forceStop = 0
	EndIf
	
	If $SpreadOrRemap = 1 Then
		$SpreadOrRemap = $SpreadOrRemap * (-1)
		
		$myMouse = MouseGetPos()
		Send("^7")
		Send("^{F7}")
		
		Do
			Send("00")
			Sleep(30)
			MouseClick($MOUSE_CLICK_LEFT, $xCreepBarHotkey, $yCreepBarHotkey, 1, 0)
			
			Sleep(40)
			$pCreepSpreadColor = PixelGetColor(1575, 1015)
			If $pCreepSpreadColor = 15659684 Then
				If $cQueue = 0 Then
					$cQueue = 1
					Send("^9")
				Else
					Send("+9")
				EndIf
				
				Send("^8")
				For $k=8 to 3 step -1
					Send("88")
					Send("C")
					$rx = Random(0, 360, 1) - 180
					$ry = Random(0, 360, 1) - 180
					MouseClick($MOUSE_CLICK_LEFT, 966 + $k * $xSpreadOffset + $rx, 448 + $k * $ySpreadOffset + $ry, 1, 0)
				Next
			EndIf		
					
			Send("00")
			Sleep(30)
			Send("{SHIFTDOWN}")
			MouseClick($MOUSE_CLICK_LEFT, $xCreepBarHotkey, $yCreepBarHotkey, 1, 0)
			Send("{SHIFTUP}")
			Send("^0")
			
			If $lastCreep = 1 Then
				$lastRun = 1
			EndIf
			
			Sleep(40)
			$pCreepColorPos = PixelGetColor($xCreepBarHotkey + $xyCreepBarOffset, $yCreepBarHotkey)
			
			If $pCreepColorPos = 0 Then
				$lastCreep = 1
			EndIf
			
			If $forceStop = 1 Then
				ExitLoop
			EndIf
			
		Until $pCreepColorPos = 0 AND $lastRun = 1
		
		MouseMove($myMouse[0], $myMouse[1], 0)
		Send("7")
		Send("{F7}")
		$timer = 0
	Else
		$SpreadOrRemap = $SpreadOrRemap * (-1)
		
		$myMouse = MouseGetPos()
		Send("^7")
		Send("^{F7}")
		
		Send("9")
		Send("^0")
		
		Do
			Send("99")
			Sleep(30)
			MouseClick($MOUSE_CLICK_LEFT, $xCreepBarHotkey, $yCreepBarHotkey, 1, 0)
			Send("^8")
			Send("88")
			Sleep(30)
			MouseClick($MOUSE_CLICK_LEFT, 966, 448, 2, 0)
			Send("+0")
						
			Send("99")
			Sleep(30)
			Send("{SHIFTDOWN}")
			MouseClick($MOUSE_CLICK_LEFT, $xCreepBarHotkey, $yCreepBarHotkey, 1, 0)
			Send("{SHIFTUP}")
			Send("^9")
			
			If $lastCreep = 1 Then
				$lastRun = 1
			EndIf
			
			Sleep(40)
			$pCreepColorPos = PixelGetColor($xCreepBarHotkey + $xyCreepBarOffset, $yCreepBarHotkey)
			
			If $pCreepColorPos = 0 Then
				$lastCreep = 1
			EndIf
			
			If $forceStop = 1 Then
				ExitLoop
			EndIf
			
		Until $pCreepColorPos = 0 AND $lastRun = 1
		
		MouseMove($myMouse[0], $myMouse[1], 0)
		Send("7")
		Send("{F7}")
		
		;;; spread the creep 
		If $forceStop = 0 Then
			spread()
		EndIf
	EndIf
EndFunc

Func inject()
	$myMouse = MouseGetPos()
	Send("^7")
	Send("^{F7}")

	For $i = 1 to $numInjects Step +1
		Send("{BACKSPACE}")
		MouseClickDrag($MOUSE_CLICK_LEFT, $xCenter - 300, $yCenter - 300, $xCenter + 300, $yCenter + 300, 0)
		Send("V")
		Send("{SHIFTDOWN}")
			For $j = 1 to 3 Step +1
				MouseClick($MOUSE_CLICK_LEFT, $xCenter, $yCenter, 1, 0)
			Next
		Send("{SHIFTUP}")
	Next
	
	MouseMove($myMouse[0], $myMouse[1], 0)
	Send("7")
	Send("{F7}")
EndFunc