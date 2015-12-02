-- Constants
local BTN = "UIPanelButtonTemplate"
local CLEAR_START = 2

-- Globals
local TabardShown = true
local Clear = CLEAR_START


-- Entry point
function GDU_Init()
    GDU_Inject()
end


-- Inject Button and Scripts into DressUp system
function GDU_Inject()
    -- Create the button to toggle visibility
    local btn = CreateFrame("Button", "GDU_BTN_Test", DressUpFrame, BTN);
    btn:SetPoint("Center", DressUpFrame, "TopLeft", 60,-421);
    btn:SetText(INVTYPE_TABARD)
    btn:SetSize(90,22);
    btn:SetScript("OnClick", GDU_ToggleTabard)
    
    -- Start to clear the tabard when opening the window
    DressUpModel:SetScript("OnShow", function()
        Clear = CLEAR_START
    end)
    
    -- The first two model updates load the entire inventory
    -- So clear it for the first two updates
    DressUpModel:SetScript("OnUpdateModel", function()
        if Clear > 0 then
            GDU_HideTabard()
            Clear = Clear - 1
        end
    end)
end


-- Hide the tabard in the DressUpModel
function GDU_HideTabard()
    DressUpModel:UndressSlot(INVSLOT_TABARD)
    TabardShown = false
end


-- Show the tabard in the DressUpModel
function GDU_ShowTabard()
    local tabard = GetInventoryItemID("player", INVSLOT_TABARD)
    DressUpModel:TryOn(tabard)
    TabardShown = true
end


-- Toggle the visibility of the tabard in the DressUpModel
function GDU_ToggleTabard(forceHide)
    if TabardShown then
        GDU_HideTabard()
    else
        GDU_ShowTabard()
    end
end