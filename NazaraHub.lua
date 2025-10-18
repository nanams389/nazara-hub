-- [[ 1. Rayfieldライブラリのロード (動作確認済みの最新URLに置き換えてください) ]]
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua'))()

-- [[ 2. メインウィンドウの作成 ]]
local Window = Rayfield:CreateWindow({
    Name = "Nazara Hub | Base Template",
    LoadingTitle = "Nazara Hub Initializing...",
    LoadingSubtitle = "Loading UI Structure...",
    ConfigurationSaving = { Enabled = true, FolderName = "NazaraHub_Base", FileName = "Config_v5" },
    KeySystem = false, -- キーシステムを使わない場合はfalse
})

-- ====================================================================
-- 3. タブとセクションの定義
-- ====================================================================

-- --------------------
-- A. HOME タブ (情報と設定)
-- --------------------
local HomeTab = Window:CreateTab("HOME", 4483362458) -- イメージIDは適当です
HomeTab:CreateSection("Information")

HomeTab:CreateLabel("Welcome to Nazara Hub!")

HomeTab:CreateParagraph({
    Title = "Status",
    Content = "各タブで必要な機能コードを挿入してください。UIが表示されない場合は、1行目のURLが無効です。"
})

-- --------------------
-- B. LOOP タブ (自動化/継続実行機能)
-- --------------------
local LoopTab = Window:CreateTab("LOOP", 4483362458) 
LoopTab:CreateSection("Auto & Anti Functions")

-- Auto Farm トグルの構造
LoopTab:CreateToggle({
    Name = "Auto Farm Toggle",
    CurrentValue = false, 
    Flag = "AutoFarm",
    Callback = function(Value)
        print("Auto Farm ON/OFF")
        -- --- ここに自動ファームのLuaコードを記述 ---
    end,
})

-- Anti Kick トグルの構造
LoopTab:CreateToggle({
    Name = "Anti Kick (General)",
    CurrentValue = false, 
    Flag = "AntiKick",
    Callback = function(Value)
        print("Anti Kick ON/OFF")
        -- --- ここにKick回避のLuaコードを記述 ---
    end,
})

-- --------------------
-- C. TP タブ (テレポート機能)
-- --------------------
local TPTab = Window:CreateTab("TP", 4483362458)
TPTab:CreateSection("Teleportation")

-- テレポート機能の構造 (特定の座標へ)
TPTab:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        print("TP Spawn: スポーン地点へのテレポートコードを挿入")
        -- --- ここにテレポートのLuaコードを記述 ---
    end,
})

-- プレイヤー選択式テレポートの構造
local PlayerDropdownTP = TPTab:CreateDropdown({
    Name = "Teleport to Player",
    Options = {"Player1", "Player2", "Player3"}, -- プレイヤーリストは動的に取得する必要があります
    CurrentOption = "Select Player",
    Flag = "TeleportPlayer",
    Callback = function(PlayerName)
        print("TP to: " .. PlayerName)
        -- --- ここに選択したプレイヤーへのテレポートコードを記述 ---
    end,
})

-- 4. UI設定のロード (ウィンドウを開く)
Rayfield:LoadConfiguration()
