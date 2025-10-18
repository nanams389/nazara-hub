-- [[ 1. Rayfieldライブラリのロード (Executorでロードされることを前提とする) ]]
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua'))()

-- [[ 2. メインウィンドウの作成 ]]
local Window = Rayfield:CreateWindow({
    Name = "Nazara Hub | TP Ready",
    LoadingTitle = "Nazara Hub Initializing...",
    LoadingSubtitle = "Loading Tabs and Features...",
    ConfigurationSaving = { Enabled = true, FolderName = "NazaraHub_TP", FileName = "Config_v6" },
    KeySystem = false,
})

-- ====================================================================
-- プレイヤーリストの動的取得関数 (Dropdown用)
-- ====================================================================
local function getPlayerNames()
    local names = {}
    -- 現在のプレイヤーオブジェクトをすべて取得
    for _, player in ipairs(game.Players:GetPlayers()) do
        -- 自分自身はリストから除外
        if player ~= game.Players.LocalPlayer then
            table.insert(names, player.Name)
        end
    end
    -- 他のプレイヤーがいない場合は代替テキストを表示
    if #names == 0 then
        table.insert(names, "No Other Players Found")
    end
    return names
end

-- ====================================================================
-- 3. タブと機能の定義
-- ====================================================================

-- --------------------
-- A. HOME タブ (基本情報)
-- --------------------
local HomeTab = Window:CreateTab("HOME", 4483362458)
HomeTab:CreateSection("Welcome")
HomeTab:CreateParagraph({
    Title = "Status Check",
    Content = "HOME, LOOP, TPタブが正常にロードされました。TPタブからプレイヤーを選択してテレポートしてください。"
})

-- --------------------
-- B. LOOP タブ (自動化/継続実行機能)
-- --------------------
local LoopTab = Window:CreateTab("LOOP", 4483362458) 
LoopTab:CreateSection("Auto & Anti Functions")

LoopTab:CreateToggle({
    Name = "Anti Kick (Template)",
    CurrentValue = false, 
    Flag = "AntiKick",
    Callback = function(Value)
        print("Anti Kick Placeholder executed: " .. tostring(Value))
        -- --- ここにAnti KickのLuaコードを記述 ---
    end,
})

-- --------------------
-- C. TP タブ (テレポート機能)
-- --------------------
local TPTab = Window:CreateTab("TP", 4483362458)
TPTab:CreateSection("Player Teleport")

-- プレイヤー選択式テレポートのロジック
local PlayerDropdownTP = TPTab:CreateDropdown({
    Name = "Teleport to Player",
    -- スクリプト実行時のプレイヤーリストを取得
    Options = getPlayerNames(),
    CurrentOption = "Select Player",
    Flag = "TeleportPlayer",
    Callback = function(PlayerName)
        local LocalPlayer = game.Players.LocalPlayer
        local Target = game.Players:FindFirstChild(PlayerName)
        
        -- ターゲットの存在とキャラクターの確認
        if Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then
            -- ターゲットのHumanoidRootPartのCFrameを取得し、自分のキャラクターを移動
            -- CFrame.new(0, 5, 0)は、地面に埋まらないよう少し上へずらすオフセット
            LocalPlayer.Character:SetPrimaryPartCFrame(Target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
            
            Rayfield:Notify({Title = "TELEPORT SUCCESS", Content = PlayerName .. "の場所へテレポートしました。", Duration = 3})
        else
            Rayfield:Notify({Title = "ERROR", Content = PlayerName .. "が見つからないか、テレポートに失敗しました。", Duration = 3})
        end
    end,
})

-- 補足：プレイヤーが途中参加した場合、ドロップダウンリストを更新するボタン
TPTab:CreateButton({
    Name = "Refresh Player List",
    Callback = function()
        -- ドロップダウンのオプションを更新
        PlayerDropdownTP:SetOptions(getPlayerNames())
        Rayfield:Notify({Title = "REFRESHED", Content = "プレイヤーリストを更新しました。", Duration = 2})
    end,
})


-- 4. UI設定のロード (ウィンドウを開く)
Rayfield:LoadConfiguration()


-- 4. UI設定のロード (ウィンドウを開く)
Rayfield:LoadConfiguration()
