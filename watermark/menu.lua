-- made by rose
local scrw = ScrW()
local scrh = ScrH()
local ply = LocalPlayer()
local date = os.date( "%m/%d/%Y" )


surface.CreateFont( "epic", {
	font = "TabLarge", 
	extended = false,
	size = 13,
	weight = 900,
	blursize = 0
} )

-- watermark shit
local DefTextColor = Color(255, 255, 255)
local WatermarkText = "very epic"
local Verison = "1.5"

-- box color
local Background1 = Color(33, 33, 38)
local TopBar1 = Color(247, 164, 23)

-- pos for watermark
local XPos = 5
local YPos = 5
local XSize = 200
local YSize = 30

-- debug menu
local DXPos = 10
local DYPos = 60
local DXSize = 200
local DYSize = 200

-- Edit menu 
concommand.Add( "openmenu", function()
    local Edit = vgui.Create( "DFrame" )
    Edit:SetSize( 560, 650 ) 
    Edit:SetTitle( "Watermark Editor" ) 
    Edit:SetVisible( true ) 
    Edit:Center()
    Edit:SetDraggable( true ) 
    Edit:ShowCloseButton( true ) 
    Edit:MakePopup()

    local sheet = vgui.Create( "DPropertySheet", Edit )
    sheet:Dock( FILL )
    local main = vgui.Create( "DPanel", sheet )
    sheet:AddSheet( "Main", main, "icon16/application_xp.png" )
    local settings = vgui.Create( "DPanel", sheet )
    sheet:AddSheet( "Settings", settings, "icon16/color_wheel.png" )
    local debug = vgui.Create( "DPanel", sheet )
    sheet:AddSheet( "Debug", debug, "icon16/bug.png" )

    surface.PlaySound("buttons/button10.wav")

    local TextEntry = vgui.Create( "DTextEntry", main )
        TextEntry:Dock( BOTTOM )
        TextEntry.OnEnter = function( self )
            WatermarkText = TextEntry:GetValue()
        end

        local WatermarkTextColor = vgui.Create("DColorMixer", settings)
            WatermarkTextColor:SetPos(5,5)
            WatermarkTextColor:SetPalette(True)
            WatermarkTextColor:SetWangs(true)
            WatermarkTextColor:SetColor(Color(255, 255, 255))
            WatermarkTextColor.Think = function()
                DefTextColor = WatermarkTextColor:GetColor()
            end

        local BackGroundMixer = vgui.Create("DColorMixer", settings)
        BackGroundMixer:SetPos(270,5)
        BackGroundMixer:SetPalette(True)
        BackGroundMixer:SetAlphaBar(true)
        BackGroundMixer:SetWangs(true)
        BackGroundMixer:SetColor(Color(33, 33, 38))
        BackGroundMixer.Think = function()
            Background1 = BackGroundMixer:GetColor()
        end

        local TopBarMixer = vgui.Create("DColorMixer", settings)
        TopBarMixer:SetPos(5,270)
        TopBarMixer:SetPalette(True)
        TopBarMixer:SetAlphaBar(true)
        TopBarMixer:SetWangs(true)
        TopBarMixer:SetColor(Color(247, 164, 23))
        TopBarMixer.Think = function()
            TopBar1 = TopBarMixer:GetColor()
        end

    local Checkbox = vgui.Create( "DCheckBoxLabel", main )
    Checkbox:SetPos( 5, 5 )
    Checkbox:SetText("Show Watermark")
    Checkbox:SetValue( false )
    Checkbox:SizeToContents()
    function Checkbox:OnChange(checked)
      if checked then
            hook.Add("HUDPaint", "watermark", function()
                surface.SetDrawColor(Background1)
                surface.DrawRect(XPos, YPos, XSize, YSize)
                surface.SetDrawColor(TopBar1)
                surface.DrawRect(XPos, YPos, XSize, 3)
                draw.DrawText(  WatermarkText, "epic", XPos + 10, YPos + 8, DefTextColor )
            end)
        else
            hook.Remove("HUDPaint", "watermark")
        end
    end

    local CheckboxDEBUG = vgui.Create( "DCheckBoxLabel", debug )
    CheckboxDEBUG:SetPos( 5, 5 )
    CheckboxDEBUG:SetText("Show debug")
    CheckboxDEBUG:SetValue( false )
    CheckboxDEBUG:SizeToContents()
        function CheckboxDEBUG:OnChange(checkedDB)
            if checkedDB then
                hook.Add("HUDPaint", "Debug", function()
                    surface.SetDrawColor(Background1)
                    surface.DrawRect(DXPos, DYPos, DXSize, DYSize)
                    surface.SetDrawColor(TopBar1)
                    surface.DrawRect(DXPos, DYPos, DXSize, 3)
                    draw.DrawText( "Client fps: "..  math.Round( 1 / FrameTime()), "epic", 25, 70, Color( 255, 255, 255, 255 ) )
                    draw.DrawText( "Server Tick: "..  math.Round( 1/engine.TickInterval()) .. "" , "epic", 25, 83, Color( 255, 255, 255, 255 ) )
                    draw.DrawText( "Player Health: ".. ply:Health(), "epic", 25, 96, Color( 255, 255, 255, 255 ) )
                    draw.DrawText( "Date: "..  date .. "" , "epic", 25, 108, Color( 255, 255, 255, 255 ) )
                    draw.DrawText( "Verison: "..  Verison .. "" , "epic", 25, 120, Color( 255, 255, 255, 255 ) )
                end)
            else
                hook.Remove("HUDPaint", "Debug")
            end
        end
end )

chat.AddText( Color( 230,76,0 ), "Loaded Watermark" )
        chat.AddText( Color( 230,76,0 ), "To open the Editor type openmenu in console" )

concommand.Add( "Unload", function()
    hook.Remove("HUDPaint", "watermark")
    hook.Remove("HUDPaint", "Debug")
    chat.AddText( Color( 255, 0, 0 ), "Unloaded Watermark" )
end)




