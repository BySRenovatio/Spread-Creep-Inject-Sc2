#include <Misc.au3>
#include <AutoItConstants.au3>

HotKeySet("{TAB}", "inject")
HotKeySet("w", "spread")
HotKeySet("{Home}", "stop")
HotKeySet("{End}", "stop")
HotKeySet("{F7}", "quit")

HotKeySet("{NUMPADADD}", "baseadd")
HotKeySet("{NUMPADSUB}", "basesub")

HotKeySet("{NUMPAD1}", "setdirection1")
HotKeySet("{NUMPAD2}", "setdirection2")
HotKeySet("{NUMPAD3}", "setdirection3")
HotKeySet("{NUMPAD4}", "setdirection4")
HotKeySet("{NUMPAD5}", "setmapcamera")
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
Global $xyCreepDistance = 50
Global $SpreadOrRemap = 1
Global $forceStop = 0
Global $timer = 0
Global $startToCreep = 0
Global $numInjects = 4

Global $colorSelectH = 65280
Global $colorNoSelectH = 35840
Global $mapPositions[96][2]	= _
								[ _
									[247, 837], [244, 840], [214, 829], [251, 894], [195, 876], [251, 949], _
									[68, 1033], [73, 1037], [106, 1047], [70, 983], [126, 1000], [71, 928], _
									[55, 855], [61, 857], [102, 844], [166, 847], [101, 904], [152, 905], _
									[259, 1014], [259, 1021], [219, 1033], [154, 1029], [216, 975], [169, 972], _
									[63, 836], [69, 837], [119, 833], [176, 837], [86, 896], [173, 881], _
									[251, 1034], [248, 1040], [202, 1042], [143, 1038], [232, 982], [148, 993], _
									[48, 827], [52, 828], [52, 867], [49, 912], [108, 841], [52, 828], _
									[266, 827], [266, 829], [230, 828], [181, 826], [254, 885], [266, 829], _
									[266, 1043], [264, 1049], [264, 1010], [268, 966], [209, 1037], [264, 1049], _
									[48, 1042], [50, 1049], [87, 1050], [136, 1052], [63, 993], [50, 1049], _
									[51, 864], [55, 867], [96, 831], [159, 835], [96, 900], [59, 951], _
									[233, 1038], [234, 1046], [260, 1001], [257, 944], [193, 1005], [141, 1042], _
									[258, 847], [256, 848], [256, 891], [264, 939], [216, 877], [177, 842], _
									[56, 1024], [60, 1029], [56, 989], [53, 940], [106, 1001], [145, 1034], _
									[82, 839], [86, 840], [134, 830], [191, 830], [123, 884], [81, 901], _
									[82, 1031], [86, 1037], [133, 1045], [189, 1048], [126, 992], [84, 976] _
								]
								
Func SetDelay()
    ;;;; Set Delay For Most Options
    AutoItSetOption("MouseClickDelay", 0)
    AutoItSetOption("MouseClickDownDelay", 0)
	AutoItSetOption("MouseClickDragDelay", 0)
    AutoItSetOption("SendKeyDelay", 0)
    AutoItSetOption("SendKeyDownDelay", 0)
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Main code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetDelay()

While 1
	If $timer >= 220 AND Mod($timer, 110) = 0  AND $startToCreep = 1 Then
		$objsp.Speak("C")
	EndIf
	
	Sleep(100)
	$timer = $timer + 1
WEnd

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Func position()
	Local $aPos = MouseGetPos()
	Local $color = PixelGetColor($aPos[0], $aPos[1])
	ToolTip('X: ' & $aPos[0] & ', Y: ' & $aPos[1] & ', colo: ' & $color, 5, 700)
EndFunc

Func stop()
	$forceStop = 0
	$startToCreep = 0
	$objsp.Speak("Stop")
EndFunc

Func quit()
	$objsp.Speak("Exit")
	Exit 0
EndFunc

Func setdirection1()
	$SpreadOrRemap = 1
	$xSpreadOffset = (-1) * $xyCreepDistance
	$ySpreadOffset = (+1) * $xyCreepDistance
EndFunc

Func setdirection2()
	$SpreadOrRemap = 1
	$xSpreadOffset =  (0) * $xyCreepDistance
	$ySpreadOffset = (+1) * $xyCreepDistance
EndFunc

Func setdirection3()
	$SpreadOrRemap = 1
	$xSpreadOffset = (+1) * $xyCreepDistance
	$ySpreadOffset = (+1) * $xyCreepDistance
EndFunc

Func setdirection4()
	$SpreadOrRemap = 1
	$xSpreadOffset = (-1) * $xyCreepDistance
	$ySpreadOffset =  (0) * $xyCreepDistance
EndFunc

Func setdirection6()
	$SpreadOrRemap = 1
	$xSpreadOffset = (+1) * $xyCreepDistance
	$ySpreadOffset =  (0) * $xyCreepDistance
EndFunc

Func setdirection7()
	$SpreadOrRemap = 1
	$xSpreadOffset = (-1) * $xyCreepDistance
	$ySpreadOffset = (-1) * $xyCreepDistance
EndFunc

Func setdirection8()
	$SpreadOrRemap = 1
	$xSpreadOffset =  (0) * $xyCreepDistance
	$ySpreadOffset = (-1) * $xyCreepDistance
EndFunc

Func setdirection9()
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
	Local $lastCreep = 0
	Local $lastRun = 0

	$startToCreep = 1
	$forceStop = 0
	
	If $SpreadOrRemap = 1 Then
		$SpreadOrRemap = $SpreadOrRemap * (-1)
		
		$myMouse = MouseGetPos()
		Send("^6")
		Send("^{F8}")
		
		Send("0")
		Send("^7")
		Send("^9")
		
		Do
			Send("7")
			Sleep(30)
			MouseClick($MOUSE_CLICK_LEFT, $xCreepBarHotkey, $yCreepBarHotkey, 1, 0)
			Send("^8")
			Send("88")
			Sleep(50)
			MouseClick($MOUSE_CLICK_LEFT, 966, 448, 2, 0)
			Send("+9")
						
			Send("7")
			Sleep(30)
			Send("{SHIFTDOWN}")
			MouseClick($MOUSE_CLICK_LEFT, $xCreepBarHotkey, $yCreepBarHotkey, 1, 0)
			Send("{SHIFTUP}")
			Send("^7")
			
			If $lastCreep = 1 Then
				$lastRun = 1
			EndIf
			
			Sleep(50)
			$pCreepColorPos = PixelGetColor($xCreepBarHotkey + $xyCreepBarOffset, $yCreepBarHotkey)
			
			If $pCreepColorPos = 0 Then
				$lastCreep = 1
			EndIf
			
			If $forceStop = 1 Then
				MouseMove($myMouse[0], $myMouse[1], 0)
				Send("6")
				Send("{F8}")
				Return
			EndIf
			
		Until $pCreepColorPos = 0 AND $lastRun = 1
		
		Send("0")
		Send("^7")
		$lastCreep = 0
		$lastRun = 0
		
		Do
			Send("7")
			Sleep(30)
			MouseClick($MOUSE_CLICK_LEFT, $xCreepBarHotkey, $yCreepBarHotkey, 1, 0)
			
			Sleep(100)
			$pCreepSpreadColor = PixelGetColor(1575, 1015)
			If $pCreepSpreadColor = 15659684 Then
				Send("^8")
				For $k=8 to 2 step -1
					Send("88")
					Send("C")
					MouseClick($MOUSE_CLICK_LEFT, 966 + $k * $xSpreadOffset, 448 + $k * $ySpreadOffset, 1, 0)
					If $xSpreadOffset = 0 Or $ySpreadOffset = 0 Then
						If $xSpreadOffset = 0 Then
							MouseClick($MOUSE_CLICK_LEFT, 966 + 180, 448 + $k * $ySpreadOffset, 1, 0)
							MouseClick($MOUSE_CLICK_LEFT, 966 - 180, 448 + $k * $ySpreadOffset, 1, 0)
						EndIf
						If $ySpreadOffset = 0 Then
							MouseClick($MOUSE_CLICK_LEFT, 966 + $k * $xSpreadOffset, 448 + 180, 1, 0)
							MouseClick($MOUSE_CLICK_LEFT, 966 + $k * $xSpreadOffset, 448 - 180, 1, 0)
						EndIf
					Else
						MouseClick($MOUSE_CLICK_LEFT, 966 + $k * $xSpreadOffset / 2, 448 + $k * $ySpreadOffset, 1, 0)
						MouseClick($MOUSE_CLICK_LEFT, 966 + $k * $xSpreadOffset, 448 + $k * $ySpreadOffset / 2, 1, 0)
					EndIf
				Next
			EndIf		
						
			Send("7")
			Sleep(30)
			Send("{SHIFTDOWN}")
			MouseClick($MOUSE_CLICK_LEFT, $xCreepBarHotkey, $yCreepBarHotkey, 1, 0)
			Send("{SHIFTUP}")
			Send("^7")
			
			If $lastCreep = 1 Then
				$lastRun = 1
			EndIf
			
			Sleep(50)
			$pCreepColorPos = PixelGetColor($xCreepBarHotkey + $xyCreepBarOffset, $yCreepBarHotkey)
			
			If $pCreepColorPos = 0 Then
				$lastCreep = 1
			EndIf
			
			If $forceStop = 1 Then
				MouseMove($myMouse[0], $myMouse[1], 0)
				Send("6")
				Send("{F8}")
				Return
			EndIf
			
		Until $pCreepColorPos = 0 AND $lastRun = 1
		
		MouseMove($myMouse[0], $myMouse[1], 0)
		Send("6")
		Send("{F8}")
		$timer = 0
	Else
		$SpreadOrRemap = $SpreadOrRemap * (-1)
		
		$myMouse = MouseGetPos()
		Send("^6")
		Send("^{F8}")

		Do
			Send("0")
			Sleep(30)
			MouseClick($MOUSE_CLICK_LEFT, $xCreepBarHotkey, $yCreepBarHotkey, 1, 0)
			Send("^7")
			Send("77")
			Sleep(50)
			MouseClick($MOUSE_CLICK_LEFT, 966, 448, 2, 0)
			Send("+8")
						
			Send("0")
			Sleep(30)
			Send("{SHIFTDOWN}")
			MouseClick($MOUSE_CLICK_LEFT, $xCreepBarHotkey, $yCreepBarHotkey, 1, 0)
			Send("{SHIFTUP}")
			Send("^0")
			
			If $lastCreep = 1 Then
				$lastRun = 1
			EndIf
			
			Sleep(50)
			$pCreepColorPos = PixelGetColor($xCreepBarHotkey + $xyCreepBarOffset, $yCreepBarHotkey)
			
			If $pCreepColorPos = 0 Then
				$lastCreep = 1
			EndIf
			
			If $forceStop = 1 Then
				MouseMove($myMouse[0], $myMouse[1], 0)
				Send("6")
				Send("{F8}")
				Return
			EndIf
			
		Until $pCreepColorPos = 0 AND $lastRun = 1
		
		Send("9")
		Send("!0")
		Send("8")
		Send("^0")
		
		MouseMove($myMouse[0], $myMouse[1], 0)
		Send("6")
		Send("{F8}")

		spread()
	EndIf
EndFunc

Func inject()
	$myMouse = MouseGetPos()
	Send("^6")
	Send("^{F8}")

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
	Send("6")
	Send("{F8}")
EndFunc

Func setmapcamera()
	Local $baseColor = 0
	
	Send("^{F8}")
	For $i=0 to 15 step +1
		Sleep(50)
		$baseColor = PixelGetColor($mapPositions[$i * 6][0], $mapPositions[$i * 6][1])
		
		If $baseColor = $colorSelectH Or $baseColor = $colorNoSelectH Then
			MouseClick($MOUSE_CLICK_LEFT, $mapPositions[$i * 6 + 1][0], $mapPositions[$i * 6 + 1][1], 1, 0)
			Sleep(200)
			Send("^{F1}")
			MouseClick($MOUSE_CLICK_LEFT, $mapPositions[$i * 6 + 2][0], $mapPositions[$i * 6 + 2][1], 1, 0)
			Sleep(200)
			Send("^{F2}")
			MouseClick($MOUSE_CLICK_LEFT, $mapPositions[$i * 6 + 3][0], $mapPositions[$i * 6 + 3][1], 1, 0)
			Sleep(200)
			Send("^{F3}")
			MouseClick($MOUSE_CLICK_LEFT, $mapPositions[$i * 6 + 4][0], $mapPositions[$i * 6 + 4][1], 1, 0)
			Sleep(200)
			Send("^{F4}")
			MouseClick($MOUSE_CLICK_LEFT, $mapPositions[$i * 6 + 5][0], $mapPositions[$i * 6 + 5][1], 1, 0)
			Sleep(200)
			Send("^{F5}")
			
			ExitLoop
		EndIf
	Next
	Send("{F8}")
EndFunc