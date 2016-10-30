' action.bmx
' from bOGL 3DAction demo

Strict

Framework Openb3d.B3dglgraphics

Graphics3D 800,600,0,2


Local camera:TCamera=CreateCamera()
CameraClsColor camera,32,32,64
PositionEntity camera,0,0,6

AmbientLight 128,128,128

Local light:TLight=CreateLight(1)
PositionEntity light,2,6,-6
PointEntity light,camera

Local cube1:TMesh=CreateCube()
EntityColor cube1,220,0,0
PositionEntity cube1,-9,-5,20

Local cube2:TMesh=CreateCube()
EntityColor cube2,0,220,0
PositionEntity cube2,-3,-5,20

Local cube3:TMesh=CreateCube()
EntityColor cube3,0,0,220
PositionEntity cube3,3,-5,20

Local cube4:TMesh=CreateCube()
EntityColor cube4,220,220,220
PositionEntity cube4,9,-5,20

' Explode
Local cube1_act1:TAction=ActFadeTo( cube1,0.0,0.01 ) ' expand and fade away
Local cube1_act1b:TAction=ActFadeTo( cube1,1.0,0.01 ) ' contract and reappear
Local cube1_act2:TAction=ActScaleTo( cube1,3,3,1,0.04 )
Local cube1_act2b:TAction=ActScaleTo( cube1,0.5,0.5,1,0.05 )
AppendAction cube1_act1,cube1_act1b ' fade/reappear
AppendAction cube1_act2,cube1_act2b ' expand/contract

' Bounce and spin
Local cube2_act1:TAction=ActMoveBy( cube2,0,5,0,0.1 )
Local cube2_act1b:TAction=ActTurnBy( cube2,0,45,0,1.0 )
Local cube2_act2:TAction=ActMoveBy( cube2,0,-5,0,0.1 )
Local cube2_act2b:TAction=ActTurnBy( cube2,0,45,0,1.0 )
AppendAction cube2_act1,cube2_act2 ' move down
AppendAction cube2_act1b,cube2_act2b ' spin moving down

' Move and push
Local cube3_act1:TAction=ActMoveBy( cube3,-1,4,2,0.1 )
Local cube3_act1b:TAction=ActTintTo( cube3,255,255,0,4.0 ) ' tint yellow
Local cube3_act2:TAction=ActNewtonian( cube3,0.8 )
AppendAction cube3_act1,cube3_act2

' Absolute movement with trackers
Local cube4_act1:TAction=ActMoveTo( cube4,9,5,20,0.2 )
Local cube4_act2:TAction=ActMoveTo( cube4,-9,5,20,0.2 )
Local cube4_act3:TAction=ActMoveTo( cube4,9,5,20,0.2 )
Local cube4_act4:TAction=ActMoveTo( cube4,9,-5,20,0.2 )
Local cube4_act5:TAction=ActTurnTo( cube4,90,180,0,1.0 ) ' spin
AppendAction cube4_act1,cube4_act2
AppendAction cube4_act2,cube4_act3
AppendAction cube4_act3,cube4_act4

Local moon1:TMesh=CreateCube() ' these will follow it
ScaleEntity moon1,0.25,0.25,0.25
EntityColor moon1,128,128,128

Local moon2:TMesh=CreateCube()
ScaleEntity moon2,0.25,0.25,0.25
EntityColor moon2,64,64,64

' Note that tracker actions have no timer and never expire on their own
Local moon1_act1:TAction=ActTrackByDistance( moon1,cube4,3.0,0.2 ) ' just follow it arbitrarily
Local moon2_act1:TAction=ActTrackByPoint( moon2,cube4,2.0,2,0,0.2 )' stay above and to the right

While Not KeyDown(KEY_ESCAPE)

	' control camera
	MoveEntity camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity camera,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	If KeyHit(KEY_SPACE)
		For Local a:TAction=EachIn TAction.action_list
			FreeAction(a)
		Next
	EndIf
	
	UpdateWorld 1 ' update actions
	RenderWorld
	
	BeginMax2D()
	DrawText "Exploder",50,550
	DrawText "Bouncer",300,550
	DrawText "Pusher",450,550
	DrawText "Orbiter with followers",600,550
	DrawText "Actions:",0,0
	
	Local ty:Int=20
	For Local a:TAction=EachIn TAction.action_list
		If a.exists And a.act[0]>=0 And a.act[0]<=11 Then DrawText "inst="+Int(TAction.getinstance(a))+" act="+a.act[0],0,ty
		ty:+20
	Next
	EndMax2D()
	
	Flip
Wend
End
