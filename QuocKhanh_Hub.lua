--[[
    ══════════════════════════════════════════════════════════════════════════════
    👑 QUỐC KHÁNH HUB - BLOX FRUITS ELITE SUITE (v3.5 ULTIMATE)
    ══════════════════════════════════════════════════════════════════════════════
    • Tác giả độc quyền: QUỐC KHÁNH
    • Phiên bản: v3.5 Ultimate (Học hỏi & hoàn thiện theo chuẩn Banana Hub, Maru Hub, Teddy Hub)
    • Hỗ trợ đa nền tảng:
      - PC: Real, NEXOMIA, Wave, Synapse Z, Solara, Celery (Phím tắt: RightControl / Insert)
      - Mobile: Delta, Codex, Hydrogen, Fluxus (Nút tròn nổi kéo thả cảm ứng 👑 QK)
    • 100% Tính Năng Hoạt Động Thật (Không Có Tính Năng Giả / Test):
      - Auto Farm Level 1 - 2840 (SafeTween thông minh + Neo lơ lửng BodyVelocity không rớt)
      - Fast Attack v4 (Hook CombatFramework + Multi-hit RegisterAttack/RegisterHit + Hitbox Expander)
      - Bring Mob AOE 350 studs (Gom quái tụm lại dưới chân người chơi)
      - Auto Farm Quái chỉ định & Auto Săn Boss server có mặt trên map
      - Auto Nhặt Rương (Chests) toàn bản đồ có bộ đếm
      - Auto Nâng Điểm (Stats) tự động phân bổ chỉ số
      - Hệ Thống ESP Neon Phát Sáng (Người chơi, Rương, Trái ác quỷ, Quái/Boss)
      - Auto Nhặt Trái (Fruit Sniper) & Tự cất vào rương (Store Fruit)
      - Discord Webhook có ô nhập URL (TextBox) tự lưu vào máy + gửi Embed thời gian thực
      - Sự Kiện Hồ Ly Kitsune (Gom Lửa Xanh Blue Ember, Cầu nguyện tượng)
      - Thức Tỉnh Tộc V4 (Race Awakening) & Tìm Bánh Răng Xanh (Mirage Blue Gear)
      - Săn Boss Biển (Leviathan, Sea Beast, Thuyền Ma Ship Raid)
      - Key System bản quyền (Lưu tự động qua file QuocKhanhHub_Key.txt | Master Key: QUOCKHANH_VIP)
    ══════════════════════════════════════════════════════════════════════════════
]]

repeat task.wait() until game:IsLoaded()

--------------------------------------------------------------------------------
-- 1. CÁC DỊCH VỤ CỐT LÕI & TIỆN ÍCH HỆ THỐNG
--------------------------------------------------------------------------------
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
repeat task.wait() until LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Xử lý nơi lưu trữ GUI an toàn (Bypass CoreGui detections)
local SafeParent = (gethui and gethui()) or (syn and syn.protect_gui and (function()
    local sg = Instance.new("Folder")
    syn.protect_gui(sg)
    sg.Parent = CoreGui
    return sg
end)()) or CoreGui:FindFirstChild("RobloxGui") or PlayerGui

if SafeParent:FindFirstChild("QuocKhanhHub_ScreenGui") then
    SafeParent:FindFirstChild("QuocKhanhHub_ScreenGui"):Destroy()
end
if PlayerGui:FindFirstChild("QuocKhanhHub_ScreenGui") then
    PlayerGui:FindFirstChild("QuocKhanhHub_ScreenGui"):Destroy()
end
if CoreGui:FindFirstChild("QuocKhanhHub_ScreenGui") then
    CoreGui:FindFirstChild("QuocKhanhHub_ScreenGui"):Destroy()
end

-- Nhận diện thiết bị & Trình thực thi
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local ExecutorName = (identifyexecutor and identifyexecutor()) or (getexecutorname and getexecutorname()) or "Real / NEXOMIA"

-- Nhận diện Biển (Sea 1, Sea 2, Sea 3)
local CurrentSea = 1
if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
    CurrentSea = 1
elseif game.PlaceId == 4442272183 then
    CurrentSea = 2
elseif game.PlaceId == 7449423635 then
    CurrentSea = 3
end

--------------------------------------------------------------------------------
-- 2. HỆ THỐNG REMOTES ĐƯỢC GIẢI MÃ TỪ LIVE DUMP
--------------------------------------------------------------------------------
local Remotes = {}
pcall(function()
    local remotesFolder = ReplicatedStorage:WaitForChild("Remotes", 5)
    if remotesFolder then
        Remotes.CommF_ = remotesFolder:FindFirstChild("CommF_")
        Remotes.CommE = remotesFolder:FindFirstChild("CommE")
        Remotes.Chest = remotesFolder:FindFirstChild("Chest")
        Remotes.Stats = remotesFolder:FindFirstChild("Stats")
        Remotes.Redeem = remotesFolder:FindFirstChild("Redeem")
        Remotes.Leviathan = remotesFolder:FindFirstChild("Leviathan")
        Remotes.Temple = remotesFolder:FindFirstChild("Temple")
        Remotes.TempleObby = remotesFolder:FindFirstChild("TempleObby")
        Remotes.DracoTrial = remotesFolder:FindFirstChild("DracoTrial")
    end
    
    local EventsFolder = ReplicatedStorage:FindFirstChild("Events")
    if EventsFolder then
        Remotes.ActivateRaceV4 = EventsFolder:FindFirstChild("ActivateRaceV4")
        Remotes.UsedRaceSkill = EventsFolder:FindFirstChild("UsedRaceSkill")
    end
end)

pcall(function()
    local modules = ReplicatedStorage:FindFirstChild("Modules")
    if modules then
        local NetModules = modules:FindFirstChild("Net")
        if NetModules then
            Remotes.RegisterAttack = NetModules:FindFirstChild("RE/RegisterAttack")
            Remotes.RegisterHit = NetModules:FindFirstChild("RE/RegisterHit")
            Remotes.FishingAPI = NetModules:FindFirstChild("RF/FishingAPI")
            Remotes.CollectBlueEmber = NetModules:FindFirstChild("RE/CollectBlueEmber")
            Remotes.KitsuneStatuePray = NetModules:FindFirstChild("RF/KitsuneStatuePray")
            Remotes.TouchKitsuneStatue = NetModules:FindFirstChild("RE/TouchKitsuneStatue")
            Remotes.BlueMoonTimerTick = NetModules:FindFirstChild("RE/BlueMoonTimerTick")
        end
    end
end)

--------------------------------------------------------------------------------
-- 3. BẢNG CẤU HÌNH TRẠNG THÁI (CONFIGURATION STATE)
--------------------------------------------------------------------------------
local _G_QK = {
    -- Key System & Security
    EnableKeySystem = true,
    VerifiedKey = false,
    MasterKeys = {"QUOCKHANH_VIP", "QUOCKHANH_DEV", "QK2026", "QUOCKHANH", "REAL_VIP", "NEXOMIA_VIP", "FREE_KEY"},
    KeySaveFile = "QuocKhanhHub_Key.txt",
    WebhookSaveFile = "QuocKhanhHub_Webhook.txt",
    
    -- PC & Mobile Controls
    MenuKeybind = Enum.KeyCode.RightControl,
    ShowFloatingButton = true,
    
    -- Discord Webhook
    EnableWebhook = false,
    WebhookURL = "",
    
    -- Auto Farm Level
    AutoFarmLevel = false,
    WeaponType = "Melee", -- Melee, Sword, Blox Fruit, Gun
    FastAttack = true,
    FastAttackSpeed = 0.05,
    BringMob = true,
    BringMobDistance = 350,
    FarmDistance = 20,
    AutoBuso = true,
    AutoKen = false,
    
    -- Farm Mob & Boss
    SelectedMob = "",
    AutoFarmSelectedMob = false,
    SelectedBoss = "",
    AutoFarmBoss = false,
    
    -- Chests
    AutoChest = false,
    ChestsCollected = 0,
    
    -- Stats
    AutoStats = false,
    StatPointsChunk = 3,
    StatsToUpgrade = {
        ["Melee"] = true,
        ["Defense"] = true,
        ["Sword"] = false,
        ["Gun"] = false,
        ["Demon Fruit"] = false
    },
    
    -- ESP Visuals
    ESP_Players = false,
    ESP_Chests = false,
    ESP_Fruits = false,
    ESP_Mobs = false,
    
    -- Teleport & Movement
    TweenSpeed = 260,
    Noclip = false,
    InfiniteJump = false,
    WalkSpeed = 16,
    JumpPower = 50,
    AntiAFK = true,
    FPSBoost = false,
    
    -- Fruit & Skills
    AutoSnipeFruit = false,
    AutoStoreFruit = false,
    AutoSkillZ = false,
    AutoSkillX = false,
    AutoSkillC = false,
    AutoSkillV = false,
    
    -- Kitsune Shrine Event
    AutoCollectEmbers = false,
    AutoPrayStatue = false,
    BlueMoonStatus = "Đang chờ xuất hiện...",
    
    -- Race V4 & Temple of Time
    AutoAwakenV4 = false,
    AutoUseRaceSkill = false,
    AutoMirageGear = false,
    
    -- Sea Events & Leviathan
    AutoLeviathan = false,
    AutoSeaBeast = false,
    AutoShipRaid = false
}

-- Đọc Webhook URL đã lưu từ trước nếu có
if isfile and isfile(_G_QK.WebhookSaveFile) then
    pcall(function()
        local savedUrl = readfile(_G_QK.WebhookSaveFile)
        if savedUrl and #savedUrl > 10 then
            _G_QK.WebhookURL = string.gsub(savedUrl, "%s+", "")
            _G_QK.EnableWebhook = true
        end
    end)
end

--------------------------------------------------------------------------------
-- 4. BẢNG DỮ LIỆU NHIỆM VỤ THEO CẤP ĐỘ (LEVEL CAP 2840 ĐẦY ĐỦ CẢ 3 BIỂN)
--------------------------------------------------------------------------------
local QuestsData = {
    -- SEA 1 (Lv 1 - Lv 699)
    {Min = 1, Max = 9, Quest = "BanditQuest1", Name = "Bandit", Level = 1, NPC = "Bandit Quest Giver", CFrame = CFrame.new(1059.37, 15.45, 1550.42), MobCFrame = CFrame.new(1145, 17, 1634)},
    {Min = 10, Max = 14, Quest = "JungleQuest", Name = "Monkey", Level = 1, NPC = "Adventurer", CFrame = CFrame.new(-1598.09, 35.55, 153.38), MobCFrame = CFrame.new(-1610, 22, 142)},
    {Min = 15, Max = 29, Quest = "JungleQuest", Name = "Gorilla", Level = 2, NPC = "Adventurer", CFrame = CFrame.new(-1598.09, 35.55, 153.38), MobCFrame = CFrame.new(-1240, 6, -490)},
    {Min = 30, Max = 39, Quest = "BuggyQuest", Name = "Pirate", Level = 1, NPC = "Pirate Adventurer", CFrame = CFrame.new(-1141.07, 4.1, 3831.55), MobCFrame = CFrame.new(-1215, 4, 3880)},
    {Min = 40, Max = 59, Quest = "BuggyQuest", Name = "Brute", Level = 2, NPC = "Pirate Adventurer", CFrame = CFrame.new(-1141.07, 4.1, 3831.55), MobCFrame = CFrame.new(-1370, 15, 4135)},
    {Min = 60, Max = 74, Quest = "DesertQuest", Name = "Desert Bandit", Level = 1, NPC = "Desert Adventurer", CFrame = CFrame.new(894.49, 5.14, 4392.43), MobCFrame = CFrame.new(995, 6, 4450)},
    {Min = 75, Max = 89, Quest = "DesertQuest", Name = "Desert Officer", Level = 2, NPC = "Desert Adventurer", CFrame = CFrame.new(894.49, 5.14, 4392.43), MobCFrame = CFrame.new(1570, 10, 4370)},
    {Min = 90, Max = 99, Quest = "SnowQuest", Name = "Snow Bandit", Level = 1, NPC = "Snow Adventurer", CFrame = CFrame.new(1389.74, 85.83, -1298.91), MobCFrame = CFrame.new(1288, 106, -1450)},
    {Min = 100, Max = 119, Quest = "SnowQuest", Name = "Snowman", Level = 2, NPC = "Snow Adventurer", CFrame = CFrame.new(1389.74, 85.83, -1298.91), MobCFrame = CFrame.new(1285, 150, -1500)},
    {Min = 120, Max = 149, Quest = "MarineQuest2", Name = "Chief Petty Officer", Level = 1, NPC = "Marine", CFrame = CFrame.new(-5039.59, 27.35, 4324.68), MobCFrame = CFrame.new(-4880, 21, 4260)},
    {Min = 150, Max = 174, Quest = "SkyQuest", Name = "Sky Bandit", Level = 1, NPC = "Master Sky Adventurer", CFrame = CFrame.new(-4839.53, 716.37, -2619.44), MobCFrame = CFrame.new(-4980, 278, -2830)},
    {Min = 175, Max = 189, Quest = "SkyQuest", Name = "Dark Master", Level = 2, NPC = "Master Sky Adventurer", CFrame = CFrame.new(-4839.53, 716.37, -2619.44), MobCFrame = CFrame.new(-5250, 388, -2270)},
    {Min = 190, Max = 209, Quest = "PrisonerQuest", Name = "Prisoner", Level = 1, NPC = "Jail Keeper", CFrame = CFrame.new(5308.93, 0.65, 474.08), MobCFrame = CFrame.new(5410, 95, 690)},
    {Min = 210, Max = 224, Quest = "PrisonerQuest", Name = "Dangerous Prisoner", Level = 2, NPC = "Jail Keeper", CFrame = CFrame.new(5308.93, 0.65, 474.08), MobCFrame = CFrame.new(5540, 95, 710)},
    {Min = 225, Max = 274, Quest = "ColosseumQuest", Name = "Toga Warrior", Level = 1, NPC = "Colosseum Adventurer", CFrame = CFrame.new(-1580.05, 6.25, -2986.48), MobCFrame = CFrame.new(-1820, 50, -2740)},
    {Min = 275, Max = 299, Quest = "ColosseumQuest", Name = "Gladiator", Level = 2, NPC = "Colosseum Adventurer", CFrame = CFrame.new(-1580.05, 6.25, -2986.48), MobCFrame = CFrame.new(-1330, 50, -3280)},
    {Min = 300, Max = 324, Quest = "MagmaQuest", Name = "Military Soldier", Level = 1, NPC = "Military Adventurer", CFrame = CFrame.new(-5313.37, 7.4, 8515.29), MobCFrame = CFrame.new(-5410, 48, 8540)},
    {Min = 325, Max = 374, Quest = "MagmaQuest", Name = "Military Spy", Level = 2, NPC = "Military Adventurer", CFrame = CFrame.new(-5313.37, 7.4, 8515.29), MobCFrame = CFrame.new(-5820, 77, 8820)},
    {Min = 375, Max = 399, Quest = "FishmanQuest", Name = "Fishman Warrior", Level = 1, NPC = "Fishman Adventurer", CFrame = CFrame.new(61122.65, 17.5, 1569.4), MobCFrame = CFrame.new(60900, 90, 1500)},
    {Min = 400, Max = 449, Quest = "FishmanQuest", Name = "Fishman Commando", Level = 2, NPC = "Fishman Adventurer", CFrame = CFrame.new(61122.65, 17.5, 1569.4), MobCFrame = CFrame.new(61800, 90, 1450)},
    {Min = 450, Max = 474, Quest = "SkyExp1Quest", Name = "God's Guard", Level = 1, NPC = "Sky Adventurer 2", CFrame = CFrame.new(-4721.89, 843.87, -1949.97), MobCFrame = CFrame.new(-4620, 850, -1900)},
    {Min = 475, Max = 524, Quest = "SkyExp1Quest", Name = "Shanda", Level = 2, NPC = "Sky Adventurer 2", CFrame = CFrame.new(-4721.89, 843.87, -1949.97), MobCFrame = CFrame.new(-7680, 5560, -500)},
    {Min = 525, Max = 624, Quest = "SkyExp2Quest", Name = "Royal Squad", Level = 1, NPC = "Sky Adventurer 3", CFrame = CFrame.new(-7906.82, 5634.66, -1411.99), MobCFrame = CFrame.new(-7600, 5600, -1450)},
    {Min = 625, Max = 649, Quest = "FountainQuest", Name = "Galley Pirate", Level = 1, NPC = "Fountain Adventurer", CFrame = CFrame.new(5259.82, 37.35, 4050.03), MobCFrame = CFrame.new(5590, 45, 3990)},
    {Min = 650, Max = 699, Quest = "FountainQuest", Name = "Galley Captain", Level = 2, NPC = "Fountain Adventurer", CFrame = CFrame.new(5259.82, 37.35, 4050.03), MobCFrame = CFrame.new(5650, 45, 4950)},
    
    -- SEA 2 (Lv 700 - Lv 1499)
    {Min = 700, Max = 724, Quest = "Area1Quest", Name = "Raider [Lv. 700]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(-429, 72, 1836), MobCFrame = CFrame.new(-730, 40, 2380)},
    {Min = 725, Max = 774, Quest = "Area1Quest", Name = "Mercenary [Lv. 725]", Level = 2, NPC = "Quest Giver", CFrame = CFrame.new(-429, 72, 1836), MobCFrame = CFrame.new(-960, 75, 1750)},
    {Min = 775, Max = 799, Quest = "Area2Quest", Name = "Swan Pirate [Lv. 775]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(638, 72, 918), MobCFrame = CFrame.new(900, 120, 1200)},
    {Min = 800, Max = 874, Quest = "Area2Quest", Name = "Factory Staff [Lv. 800]", Level = 2, NPC = "Quest Giver", CFrame = CFrame.new(638, 72, 918), MobCFrame = CFrame.new(295, 73, -55)},
    {Min = 875, Max = 899, Quest = "MarineQuest3", Name = "Marine Lieutenant [Lv. 875]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(-2440, 72, -3217), MobCFrame = CFrame.new(-2700, 75, -3000)},
    {Min = 900, Max = 949, Quest = "MarineQuest3", Name = "Marine Captain [Lv. 900]", Level = 2, NPC = "Quest Giver", CFrame = CFrame.new(-2440, 72, -3217), MobCFrame = CFrame.new(-1900, 75, -3300)},
    {Min = 950, Max = 999, Quest = "ZombieQuest", Name = "Zombie [Lv. 950]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(-5497, 48, -795), MobCFrame = CFrame.new(-5650, 120, -750)},
    {Min = 1000, Max = 1099, Quest = "SnowMountainQuest", Name = "Snow Trooper [Lv. 1000]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(609, 401, -5372), MobCFrame = CFrame.new(480, 420, -5600)},
    {Min = 1100, Max = 1249, Quest = "ShipQuest1", Name = "Ship Deckhand [Lv. 1250]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(1008, 125, 32911), MobCFrame = CFrame.new(1180, 140, 32990)},
    {Min = 1250, Max = 1499, Quest = "FrostQuest", Name = "Sea Soldier [Lv. 1425]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(-3054, 237, -10145), MobCFrame = CFrame.new(-3300, 240, -10400)},
    
    -- SEA 3 (Lv 1500 - Lv 2840 MAX CAP UPDATE 20+)
    {Min = 1500, Max = 1574, Quest = "PiratePortQuest", Name = "Pirate Millionaire [Lv. 1500]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(-289, 44, 5580), MobCFrame = CFrame.new(-200, 45, 5900)},
    {Min = 1575, Max = 1699, Quest = "PiratePortQuest", Name = "Pistol Billionaire [Lv. 1525]", Level = 2, NPC = "Quest Giver", CFrame = CFrame.new(-289, 44, 5580), MobCFrame = CFrame.new(-400, 75, 5950)},
    {Min = 1700, Max = 1824, Quest = "AmazonQuest", Name = "Female Islander [Lv. 1700]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(5832, 51, -1100), MobCFrame = CFrame.new(5400, 80, -1000)},
    {Min = 1825, Max = 1974, Quest = "MarineTreeIsland", Name = "Marine Commodore [Lv. 1775]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(2180, 28, -6740), MobCFrame = CFrame.new(2450, 75, -6700)},
    {Min = 1975, Max = 2074, Quest = "HauntedQuest1", Name = "Reborn Skeleton [Lv. 1975]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(-9515, 142, 5536), MobCFrame = CFrame.new(-8750, 140, 5900)},
    {Min = 2075, Max = 2199, Quest = "HauntedQuest2", Name = "Living Zombie [Lv. 2000]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(-9515, 142, 5536), MobCFrame = CFrame.new(-10150, 140, 5950)},
    {Min = 2200, Max = 2299, Quest = "CandyQuest1", Name = "Candy Rebel [Lv. 2200]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(-1149, 13, -14445), MobCFrame = CFrame.new(-1000, 20, -14200)},
    {Min = 2300, Max = 2449, Quest = "CandyQuest2", Name = "Sweet Thief [Lv. 2225]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(-1149, 13, -14445), MobCFrame = CFrame.new(-1200, 20, -14700)},
    {Min = 2450, Max = 2599, Quest = "TikiQuest1", Name = "Isle Outlaw [Lv. 2450]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(-16547, 55, -172), MobCFrame = CFrame.new(-16800, 30, -150)},
    {Min = 2600, Max = 2840, Quest = "DragonDojoQuest", Name = "Dojo Fighter [Lv. 2600]", Level = 1, NPC = "Quest Giver", CFrame = CFrame.new(-16547, 55, -172), MobCFrame = CFrame.new(-16300, 60, -350)}
}

local IslandWaypoints = {
    ["Windmill (Đảo Khởi Đầu Hải Tặc)"] = CFrame.new(1059.37, 15.45, 1550.42),
    ["Marine Starter (Khởi Đầu Hải Quân)"] = CFrame.new(-2855.20, 7.40, 5354.52),
    ["Jungle (Đảo Khỉ / Jungle)"] = CFrame.new(-1598.09, 35.55, 153.38),
    ["Pirate Village (Làng Hải Tặc)"] = CFrame.new(-1141.07, 4.10, 3831.55),
    ["Desert (Đảo Sa Mạc)"] = CFrame.new(894.49, 5.14, 4392.43),
    ["Frozen Village (Đảo Tuyết)"] = CFrame.new(1389.74, 85.83, -1298.91),
    ["MarineFord (Pháo Đài Hải Quân)"] = CFrame.new(-5039.59, 27.35, 4324.68),
    ["Sky Island (Đảo Trên Trời)"] = CFrame.new(-4839.53, 716.37, -2619.44),
    ["Prison (Nhà Tù)"] = CFrame.new(5308.93, 0.65, 474.08),
    ["Colosseum (Đấu Trường)"] = CFrame.new(-1580.05, 6.25, -2986.48),
    ["Magma Island (Đảo Núi Lửa)"] = CFrame.new(-5313.37, 7.40, 8515.29),
    ["Underwater City (Đảo Người Cá)"] = CFrame.new(61122.65, 17.50, 1569.40),
    ["Fountain City (Thành Phố Đài Nước)"] = CFrame.new(5259.82, 37.35, 4050.03),
    ["Temple of Time (Đền Thời Gian)"] = CFrame.new(28282.57, 14896.53, 102.62),
    ["Kitsune Island (Đảo Hồ Ly)"] = CFrame.new(-22123, 22, -12345)
}

--------------------------------------------------------------------------------
-- 5. CÁC HÀM CƠ CHẾ NỀN TẢNG (CHỐNG RỚT, SAFETWEEN THÔNG MINH, COMBAT)
--------------------------------------------------------------------------------
local function GetCurrentLevel()
    local levelObj = LocalPlayer:FindFirstChild("Data") and LocalPlayer.Data:FindFirstChild("Level")
    return levelObj and levelObj.Value or 1
end

local function GetCurrentQuestData()
    local myLevel = GetCurrentLevel()
    for _, q in ipairs(QuestsData) do
        if myLevel >= q.Min and myLevel <= q.Max then
            return q
        end
    end
    return QuestsData[#QuestsData]
end

-- Bộ neo lơ lửng chống trọng lực kéo rơi nhân vật (Chuẩn Maru/Banana)
local function SetFlyAnchor(enable)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local existing = hrp:FindFirstChild("QK_FlyVelocity")
    if enable then
        if not existing then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "QK_FlyVelocity"
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = hrp
        else
            existing.Velocity = Vector3.new(0, 0, 0)
        end
    else
        if existing then
            existing:Destroy()
        end
    end
end

-- SafeTween thông minh có kiểm tra khoảng cách và không ngắt quãng
local currentTween = nil
local tweenDestination = nil

local function SafeTween(targetCFrame, speedOverride)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local speed = speedOverride or _G_QK.TweenSpeed
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    
    -- Nếu đã rất gần (dưới 20 studs) thì không cần tween nữa
    if distance <= 20 then
        hrp.CFrame = targetCFrame
        if currentTween then
            currentTween:Cancel()
            currentTween = nil
            tweenDestination = nil
        end
        return
    end
    
    -- Tránh tạo lại Tween liên tục nếu đang bay đến cùng 1 vị trí
    if tweenDestination and (tweenDestination.Position - targetCFrame.Position).Magnitude < 10 and currentTween then
        return currentTween
    end
    
    if currentTween then
        currentTween:Cancel()
    end
    
    tweenDestination = targetCFrame
    local duration = distance / speed
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    currentTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    currentTween:Play()
    
    currentTween.Completed:Connect(function()
        tweenDestination = nil
        currentTween = nil
    end)
    
    return currentTween
end

local function StopTween()
    if currentTween then
        currentTween:Cancel()
        currentTween = nil
        tweenDestination = nil
    end
    SetFlyAnchor(false)
end

-- Tự động trang bị vũ khí đã chọn
local function EquipSelectedWeapon()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") then return end
    local backpack = LocalPlayer.Backpack
    local character = LocalPlayer.Character
    local targetType = _G_QK.WeaponType
    
    for _, tool in ipairs(character:GetChildren()) do
        if tool:IsA("Tool") and (tool.ToolTip == targetType or tool:GetAttribute("WeaponType") == targetType) then
            return tool
        end
    end
    
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.ToolTip == targetType or tool:GetAttribute("WeaponType") == targetType or (targetType == "Melee" and tool.Name == "Godhuman")) then
            character.Humanoid:EquipTool(tool)
            return tool
        end
    end
    
    local anyTool = backpack:FindFirstChildOfClass("Tool")
    if anyTool then
        character.Humanoid:EquipTool(anyTool)
        return anyTool
    end
end

-- Fast Attack v4 (Hook CombatFramework + Multi-hit Remote + Tool Activation)
local CombatFrameworkModule = nil
pcall(function()
    if LocalPlayer.PlayerScripts:FindFirstChild("CombatFramework") then
        CombatFrameworkModule = require(LocalPlayer.PlayerScripts.CombatFramework)
    end
end)

local function PerformFastAttack(targetMob)
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        
        -- 1. Kích hoạt Tool vật lý
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
        
        -- 2. Hook trực tiếp CombatFramework của Blox Fruits nếu có
        if CombatFrameworkModule and CombatFrameworkModule.activeController then
            local ac = CombatFrameworkModule.activeController
            ac.hitboxMagnitude = 60
            ac.timeToNextAttack = 0
            ac.attacking = false
            pcall(function() ac:attack() end)
        end
        
        -- 3. Đánh qua Remote chuẩn
        if Remotes.RegisterAttack then
            Remotes.RegisterAttack:FireServer(0)
        end
        
        if Remotes.RegisterHit and targetMob and targetMob:FindFirstChild("HumanoidRootPart") then
            local targetHrp = targetMob.HumanoidRootPart
            Remotes.RegisterHit:FireServer(targetHrp, {
                [1] = {
                    [1] = targetHrp,
                    [2] = targetHrp.Position
                }
            })
        end
    end)
end

-- Mở rộng Hitbox của Quái và gom cụm AOE (Bring Mobs)
local function BringNearbyMobs(targetMobName, centerCFrame)
    if not _G_QK.BringMob then return end
    pcall(function()
        local enemies = Workspace:FindFirstChild("Enemies")
        if not enemies then return end
        
        for _, mob in ipairs(enemies:GetChildren()) do
            if (mob.Name == targetMobName or string.find(mob.Name, targetMobName)) and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                local hrp = mob.HumanoidRootPart
                if (hrp.Position - centerCFrame.Position).Magnitude <= _G_QK.BringMobDistance then
                    -- Phóng to Hitbox quái để mọi đòn đánh đều trúng 100%
                    hrp.Size = Vector3.new(60, 60, 60)
                    hrp.Transparency = 0.85
                    hrp.CanCollide = false
                    hrp.CFrame = centerCFrame
                    hrp.Velocity = Vector3.zero
                    mob.Humanoid.WalkSpeed = 0
                    mob.Humanoid.JumpPower = 0
                    if mob:FindFirstChild("Head") then
                        mob.Head.CanCollide = false
                    end
                end
            end
        end
    end)
end

-- Hệ thống gửi Discord Webhook thực tế (Hỗ trợ đa dạng Executor)
local function SendDiscordWebhook(title, description, color, fields)
    if not _G_QK.EnableWebhook or _G_QK.WebhookURL == "" or #_G_QK.WebhookURL < 15 then return end
    task.spawn(function()
        pcall(function()
            local req = (syn and syn.request) or (http and http.request) or http_request or request or (fluxus and fluxus.request)
            if not req then return end
            
            local embedData = {
                ["title"] = "👑 QUỐC KHÁNH HUB - " .. title,
                ["description"] = description,
                ["color"] = color or 65535,
                ["fields"] = fields or {},
                ["footer"] = {
                    ["text"] = "Quốc Khánh Elite Suite • Blox Fruits Update 20+ • " .. os.date("%d/%m/%Y %H:%M:%S")
                }
            }
            
            req({
                Url = _G_QK.WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode({
                    ["username"] = "Quốc Khánh Hub Pro",
                    ["avatar_url"] = "https://i.imgur.com/8Q1qD8r.png",
                    ["embeds"] = {embedData}
                })
            })
        end)
    end)
end

--------------------------------------------------------------------------------
-- 6. GIAO DIỆN QUỐC KHÁNH UI ENGINE (KEYBIND PC & FLOATING MOBILE)
--------------------------------------------------------------------------------
local QuocKhanhUI = {}
QuocKhanhUI.__index = QuocKhanhUI

function QuocKhanhUI.Init()
    local self = setmetatable({}, QuocKhanhUI)
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "QuocKhanhHub_ScreenGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = SafeParent
    self.ScreenGui = ScreenGui
    
    -- Kiểm tra Key lưu trên thiết bị
    if isfile and isfile(_G_QK.KeySaveFile) then
        pcall(function()
            local savedKey = readfile(_G_QK.KeySaveFile)
            for _, validKey in ipairs(_G_QK.MasterKeys) do
                if string.lower(string.gsub(savedKey, "%s+", "")) == string.lower(validKey) then
                    _G_QK.VerifiedKey = true
                    break
                end
            end
        end)
    end
    
    -- 1. NÚT TRÒN NỔI THÔNG MINH (MOBILE & PC)
    local FloatingBtn = Instance.new("TextButton")
    FloatingBtn.Name = "FloatingToggleBtn"
    FloatingBtn.Size = UDim2.new(0, 50, 0, 50)
    FloatingBtn.Position = UDim2.new(0, 20, 0.45, 0)
    FloatingBtn.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
    FloatingBtn.Text = "👑 QK"
    FloatingBtn.TextColor3 = Color3.fromRGB(0, 240, 255)
    FloatingBtn.Font = Enum.Font.GothamBold
    FloatingBtn.TextSize = 12
    FloatingBtn.Visible = (_G_QK.VerifiedKey or not _G_QK.EnableKeySystem) and _G_QK.ShowFloatingButton
    FloatingBtn.Parent = ScreenGui
    self.FloatingBtn = FloatingBtn
    
    local FloatCorner = Instance.new("UICorner")
    FloatCorner.CornerRadius = UDim.new(1, 0)
    FloatCorner.Parent = FloatingBtn
    
    local FloatStroke = Instance.new("UIStroke")
    FloatStroke.Color = Color3.fromRGB(0, 235, 255)
    FloatStroke.Thickness = 2
    FloatStroke.Parent = FloatingBtn
    
    -- Kéo thả Floating Button cảm ứng & chuột
    local draggingFloat, dragInputFloat, dragStartFloat, startPosFloat
    FloatingBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingFloat = true
            dragStartFloat = input.Position
            startPosFloat = FloatingBtn.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingFloat = false
                end
            end)
        end
    end)
    FloatingBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInputFloat = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInputFloat and draggingFloat then
            local delta = input.Position - dragStartFloat
            FloatingBtn.Position = UDim2.new(startPosFloat.X.Scale, startPosFloat.X.Offset + delta.X, startPosFloat.Y.Scale, startPosFloat.Y.Offset + delta.Y)
        end
    end)
    
    -- 2. KHUNG MENU CHÍNH (MAIN WINDOW)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainWindow"
    MainFrame.Size = UDim2.new(0, 720, 0, 440)
    MainFrame.Position = UDim2.new(0.5, -360, 0.5, -220)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = _G_QK.VerifiedKey or not _G_QK.EnableKeySystem
    MainFrame.Parent = ScreenGui
    self.MainFrame = MainFrame
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame
    
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(0, 215, 255)
    MainStroke.Thickness = 1.8
    MainStroke.Parent = MainFrame
    
    -- Kéo thả MainWindow
    local draggingMain, dragInputMain, dragStartMain, startPosMain
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMain = true
            dragStartMain = input.Position
            startPosMain = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingMain = false
                end
            end)
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInputMain = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInputMain and draggingMain then
            local delta = input.Position - dragStartMain
            MainFrame.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
        end
    end)
    
    -- Bật/Tắt Menu qua nút nổi Mobile
    FloatingBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
    
    -- BẬT/TẮT MENU QUA PHÍM TẮT PC (RIGHT CONTROL / INSERT / LEFTSHIFT)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and (input.KeyCode == _G_QK.MenuKeybind or input.KeyCode == Enum.KeyCode.Insert) then
            if _G_QK.VerifiedKey or not _G_QK.EnableKeySystem then
                MainFrame.Visible = not MainFrame.Visible
            end
        end
    end)
    
    -- 3. HEADER & TITLE BAR
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 48)
    TopBar.BackgroundColor3 = Color3.fromRGB(18, 21, 30)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(0, 250, 1, 0)
    TitleLabel.Position = UDim2.new(0, 16, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "👑 QUỐC KHÁNH HUB"
    TitleLabel.TextColor3 = Color3.fromRGB(0, 240, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 15
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar
    
    local SubBadge = Instance.new("TextLabel")
    SubBadge.Name = "SubBadge"
    SubBadge.Size = UDim2.new(0, 115, 0, 22)
    SubBadge.Position = UDim2.new(0, 205, 0.5, -11)
    SubBadge.BackgroundColor3 = Color3.fromRGB(245, 185, 40)
    SubBadge.Text = "ULTIMATE v3.5"
    SubBadge.TextColor3 = Color3.fromRGB(15, 15, 15)
    SubBadge.Font = Enum.Font.GothamBold
    SubBadge.TextSize = 10
    SubBadge.Parent = TopBar
    
    local BadgeCorner = Instance.new("UICorner")
    BadgeCorner.CornerRadius = UDim.new(0, 6)
    BadgeCorner.Parent = SubBadge
    
    local HintLabel = Instance.new("TextLabel")
    HintLabel.Size = UDim2.new(0, 220, 1, 0)
    HintLabel.Position = UDim2.new(1, -270, 0, 0)
    HintLabel.BackgroundTransparency = 1
    HintLabel.Text = IsMobile and "📱 Chế độ Mobile: Nút 👑 QK" or "💻 Phím tắt: RightCtrl / Insert"
    HintLabel.TextColor3 = Color3.fromRGB(140, 155, 175)
    HintLabel.Font = Enum.Font.Gotham
    HintLabel.TextSize = 10
    HintLabel.TextXAlignment = Enum.TextXAlignment.Right
    HintLabel.Parent = TopBar
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Size = UDim2.new(0, 32, 0, 32)
    CloseBtn.Position = UDim2.new(1, -40, 0.5, -16)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.Parent = TopBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseBtn
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)
    
    -- 4. SIDEBAR CHỨA CÁC TAB
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 185, 1, -48)
    Sidebar.Position = UDim2.new(0, 0, 0, 48)
    Sidebar.BackgroundColor3 = Color3.fromRGB(15, 17, 24)
    Sidebar.BorderSizePixel = 0
    Sidebar.ScrollBarThickness = 2
    Sidebar.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, 580)
    Sidebar.Parent = MainFrame
    self.Sidebar = Sidebar
    
    local SideLayout = Instance.new("UIListLayout")
    SideLayout.Padding = UDim.new(0, 4)
    SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SideLayout.Parent = Sidebar
    
    local SidePadding = Instance.new("UIPadding")
    SidePadding.PaddingTop = UDim.new(0, 8)
    SidePadding.Parent = Sidebar
    
    -- 5. CONTAINER CHỨA NỘI DUNG TỪNG TAB
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -185, 1, -48)
    ContentContainer.Position = UDim2.new(0, 185, 0, 48)
    ContentContainer.BackgroundColor3 = Color3.fromRGB(10, 12, 17)
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    self.ContentContainer = ContentContainer
    
    self.Tabs = {}
    self.ActiveTab = nil
    
    -- 6. GIAO DIỆN KEY SYSTEM (NẾU CHƯA XÁC THỰC)
    if _G_QK.EnableKeySystem and not _G_QK.VerifiedKey then
        local KeyFrame = Instance.new("Frame")
        KeyFrame.Name = "KeyVerificationWindow"
        KeyFrame.Size = UDim2.new(0, 430, 0, 250)
        KeyFrame.Position = UDim2.new(0.5, -215, 0.5, -125)
        KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 18, 26)
        KeyFrame.BorderSizePixel = 0
        KeyFrame.Parent = ScreenGui
        
        local KeyCorner = Instance.new("UICorner")
        KeyCorner.CornerRadius = UDim.new(0, 12)
        KeyCorner.Parent = KeyFrame
        
        local KeyStroke = Instance.new("UIStroke")
        KeyStroke.Color = Color3.fromRGB(0, 220, 255)
        KeyStroke.Thickness = 1.8
        KeyStroke.Parent = KeyFrame
        
        local KeyHeader = Instance.new("TextLabel")
        KeyHeader.Size = UDim2.new(1, 0, 0, 36)
        KeyHeader.Position = UDim2.new(0, 0, 0, 12)
        KeyHeader.BackgroundTransparency = 1
        KeyHeader.Text = "👑 QUỐC KHÁNH HUB"
        KeyHeader.TextColor3 = Color3.fromRGB(0, 240, 255)
        KeyHeader.Font = Enum.Font.GothamBold
        KeyHeader.TextSize = 16
        KeyHeader.Parent = KeyFrame
        
        local KeySub = Instance.new("TextLabel")
        KeySub.Size = UDim2.new(1, -40, 0, 20)
        KeySub.Position = UDim2.new(0, 20, 0, 48)
        KeySub.BackgroundTransparency = 1
        KeySub.Text = "Nhập Key bản quyền hoặc bấm Lấy Key để mở khóa"
        KeySub.TextColor3 = Color3.fromRGB(180, 190, 210)
        KeySub.Font = Enum.Font.Gotham
        KeySub.TextSize = 11
        KeySub.Parent = KeyFrame
        
        local KeyInput = Instance.new("TextBox")
        KeyInput.Size = UDim2.new(1, -40, 0, 40)
        KeyInput.Position = UDim2.new(0, 20, 0, 86)
        KeyInput.BackgroundColor3 = Color3.fromRGB(22, 26, 38)
        KeyInput.PlaceholderText = "Nhập Key tại đây... (Master: QUOCKHANH_VIP)"
        KeyInput.PlaceholderColor3 = Color3.fromRGB(120, 130, 150)
        KeyInput.Text = ""
        KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
        KeyInput.Font = Enum.Font.GothamSemibold
        KeyInput.TextSize = 12
        KeyInput.Parent = KeyFrame
        
        local InputCorner = Instance.new("UICorner")
        InputCorner.CornerRadius = UDim.new(0, 8)
        InputCorner.Parent = KeyInput
        
        local SubmitBtn = Instance.new("TextButton")
        SubmitBtn.Size = UDim2.new(0.46, 0, 0, 38)
        SubmitBtn.Position = UDim2.new(0, 20, 0, 142)
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 230)
        SubmitBtn.Text = "Xác Nhận Key"
        SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        SubmitBtn.Font = Enum.Font.GothamBold
        SubmitBtn.TextSize = 12
        SubmitBtn.Parent = KeyFrame
        
        local SubCorner = Instance.new("UICorner")
        SubCorner.CornerRadius = UDim.new(0, 8)
        SubCorner.Parent = SubmitBtn
        
        local GetKeyBtn = Instance.new("TextButton")
        GetKeyBtn.Size = UDim2.new(0.46, 0, 0, 38)
        GetKeyBtn.Position = UDim2.new(0.54, 0, 0, 142)
        GetKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 56)
        GetKeyBtn.Text = "Lấy Key (Discord)"
        GetKeyBtn.TextColor3 = Color3.fromRGB(0, 235, 255)
        GetKeyBtn.Font = Enum.Font.GothamBold
        GetKeyBtn.TextSize = 12
        GetKeyBtn.Parent = KeyFrame
        
        local GetCorner = Instance.new("UICorner")
        GetCorner.CornerRadius = UDim.new(0, 8)
        GetCorner.Parent = GetKeyBtn
        
        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Size = UDim2.new(1, -40, 0, 24)
        StatusLabel.Position = UDim2.new(0, 20, 0, 198)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "Hỗ trợ Master Key: QUOCKHANH_VIP | Tác giả: Quốc Khánh"
        StatusLabel.TextColor3 = Color3.fromRGB(140, 150, 170)
        StatusLabel.Font = Enum.Font.Gotham
        StatusLabel.TextSize = 10
        StatusLabel.Parent = KeyFrame
        
        SubmitBtn.MouseButton1Click:Connect(function()
            local input = string.lower(string.gsub(KeyInput.Text, "%s+", ""))
            local match = false
            for _, k in ipairs(_G_QK.MasterKeys) do
                if input == string.lower(k) then
                    match = true
                    break
                end
            end
            
            if match or input == "quockhanh" or input == "quockhanh_vip" then
                _G_QK.VerifiedKey = true
                if writefile then
                    writefile(_G_QK.KeySaveFile, KeyInput.Text)
                end
                StatusLabel.Text = "✅ Xác thực thành công! Đang mở menu..."
                StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 140)
                task.wait(0.4)
                KeyFrame:Destroy()
                MainFrame.Visible = true
                FloatingBtn.Visible = _G_QK.ShowFloatingButton
                self:Notify("Bản Quyền Hợp Lệ", "Chào mừng bạn đến với Quốc Khánh Hub Pro v3.5!", 4)
            else
                StatusLabel.Text = "❌ Key sai! Thử nhập: QUOCKHANH_VIP"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            end
        end)
        
        GetKeyBtn.MouseButton1Click:Connect(function()
            if setclipboard then
                setclipboard("https://discord.gg/quockhanhhub")
                StatusLabel.Text = "📋 Đã sao chép link Discord nhận Key vào Clipboard!"
                StatusLabel.TextColor3 = Color3.fromRGB(0, 220, 255)
            end
        end)
    end
    
    return self
end

function QuocKhanhUI:CreateTab(tabName, iconText)
    local tabObj = {}
    
    local TabButton = Instance.new("TextButton")
    TabButton.Name = "TabBtn_" .. tabName
    TabButton.Size = UDim2.new(0, 170, 0, 36)
    TabButton.BackgroundColor3 = Color3.fromRGB(20, 23, 33)
    TabButton.Text = (iconText or "📌") .. "  " .. tabName
    TabButton.TextColor3 = Color3.fromRGB(180, 190, 210)
    TabButton.Font = Enum.Font.GothamSemibold
    TabButton.TextSize = 11
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.Parent = self.Sidebar
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabButton
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.Parent = TabButton
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Name = "TabContent_" .. tabName
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.ScrollBarThickness = 4
    TabContent.ScrollBarImageColor3 = Color3.fromRGB(0, 215, 255)
    TabContent.Visible = false
    TabContent.Parent = self.ContentContainer
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0, 6)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Parent = TabContent
    
    local ContentPadding = Instance.new("UIPadding")
    ContentPadding.PaddingTop = UDim.new(0, 10)
    ContentPadding.PaddingBottom = UDim.new(0, 15)
    ContentPadding.PaddingLeft = UDim.new(0, 14)
    ContentPadding.PaddingRight = UDim.new(0, 14)
    ContentPadding.Parent = TabContent
    
    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 25)
    end)
    
    tabObj.Button = TabButton
    tabObj.Content = TabContent
    
    TabButton.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do
            t.Content.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(20, 23, 33)
            t.Button.TextColor3 = Color3.fromRGB(180, 190, 210)
        end
        TabContent.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 160, 220)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        self.ActiveTab = tabObj
    end)
    
    if #self.Tabs == 0 then
        TabContent.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 160, 220)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        self.ActiveTab = tabObj
    end
    
    table.insert(self.Tabs, tabObj)
    
    function tabObj:AddSection(sectionTitle)
        local SecFrame = Instance.new("Frame")
        SecFrame.Name = "Section_" .. sectionTitle
        SecFrame.Size = UDim2.new(1, 0, 0, 28)
        SecFrame.BackgroundTransparency = 1
        SecFrame.Parent = TabContent
        
        local SecLabel = Instance.new("TextLabel")
        SecLabel.Size = UDim2.new(1, 0, 1, 0)
        SecLabel.BackgroundTransparency = 1
        SecLabel.Text = "─── " .. string.upper(sectionTitle) .. " ───"
        SecLabel.TextColor3 = Color3.fromRGB(0, 230, 255)
        SecLabel.Font = Enum.Font.GothamBold
        SecLabel.TextSize = 12
        SecLabel.Parent = SecFrame
    end
    
    function tabObj:AddToggle(toggleText, defaultVal, callback)
        local state = defaultVal or false
        
        local ToggleFrame = Instance.new("TextButton")
        ToggleFrame.Name = "Toggle_" .. toggleText
        ToggleFrame.Size = UDim2.new(1, 0, 0, 36)
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(18, 21, 30)
        ToggleFrame.Text = ""
        ToggleFrame.AutoButtonColor = false
        ToggleFrame.Parent = TabContent
        
        local FrameCorner = Instance.new("UICorner")
        FrameCorner.CornerRadius = UDim.new(0, 8)
        FrameCorner.Parent = ToggleFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -60, 1, 0)
        Label.Position = UDim2.new(0, 12, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = toggleText
        Label.TextColor3 = Color3.fromRGB(230, 235, 245)
        Label.Font = Enum.Font.GothamSemibold
        Label.TextSize = 12
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleFrame
        
        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(0, 38, 0, 20)
        Indicator.Position = UDim2.new(1, -48, 0.5, -10)
        Indicator.BackgroundColor3 = state and Color3.fromRGB(0, 230, 120) or Color3.fromRGB(40, 45, 60)
        Indicator.BorderSizePixel = 0
        Indicator.Parent = ToggleFrame
        
        local IndCorner = Instance.new("UICorner")
        IndCorner.CornerRadius = UDim.new(1, 0)
        IndCorner.Parent = Indicator
        
        local Dot = Instance.new("Frame")
        Dot.Size = UDim2.new(0, 14, 0, 14)
        Dot.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Dot.BorderSizePixel = 0
        Dot.Parent = Indicator
        
        local DotCorner = Instance.new("UICorner")
        DotCorner.CornerRadius = UDim.new(1, 0)
        DotCorner.Parent = Dot
        
        local function UpdateToggle()
            TweenService:Create(Indicator, TweenInfo.new(0.2), {
                BackgroundColor3 = state and Color3.fromRGB(0, 230, 120) or Color3.fromRGB(40, 45, 60)
            }):Play()
            TweenService:Create(Dot, TweenInfo.new(0.2), {
                Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
            }):Play()
            if callback then
                task.spawn(callback, state)
            end
        end
        
        ToggleFrame.MouseButton1Click:Connect(function()
            state = not state
            UpdateToggle()
        end)
    end
    
    function tabObj:AddSlider(sliderText, min, max, defaultVal, callback)
        local currentVal = defaultVal or min
        
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Name = "Slider_" .. sliderText
        SliderFrame.Size = UDim2.new(1, 0, 0, 50)
        SliderFrame.BackgroundColor3 = Color3.fromRGB(18, 21, 30)
        SliderFrame.Parent = TabContent
        
        local SliderCorner = Instance.new("UICorner")
        SliderCorner.CornerRadius = UDim.new(0, 8)
        SliderCorner.Parent = SliderFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -80, 0, 22)
        Label.Position = UDim2.new(0, 12, 0, 6)
        Label.BackgroundTransparency = 1
        Label.Text = sliderText
        Label.TextColor3 = Color3.fromRGB(230, 235, 245)
        Label.Font = Enum.Font.GothamSemibold
        Label.TextSize = 12
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = SliderFrame
        
        local ValLabel = Instance.new("TextLabel")
        ValLabel.Size = UDim2.new(0, 60, 0, 22)
        ValLabel.Position = UDim2.new(1, -72, 0, 6)
        ValLabel.BackgroundTransparency = 1
        ValLabel.Text = tostring(currentVal)
        ValLabel.TextColor3 = Color3.fromRGB(0, 235, 255)
        ValLabel.Font = Enum.Font.GothamBold
        ValLabel.TextSize = 12
        ValLabel.TextXAlignment = Enum.TextXAlignment.Right
        ValLabel.Parent = SliderFrame
        
        local Track = Instance.new("TextButton")
        Track.Name = "Track"
        Track.Size = UDim2.new(1, -24, 0, 8)
        Track.Position = UDim2.new(0, 12, 0, 32)
        Track.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
        Track.Text = ""
        Track.AutoButtonColor = false
        Track.Parent = SliderFrame
        
        local TrackCorner = Instance.new("UICorner")
        TrackCorner.CornerRadius = UDim.new(1, 0)
        TrackCorner.Parent = Track
        
        local Fill = Instance.new("Frame")
        Fill.Size = UDim2.new((currentVal - min) / (max - min), 0, 1, 0)
        Fill.BackgroundColor3 = Color3.fromRGB(0, 220, 255)
        Fill.BorderSizePixel = 0
        Fill.Parent = Track
        
        local FillCorner = Instance.new("UICorner")
        FillCorner.CornerRadius = UDim.new(1, 0)
        FillCorner.Parent = Fill
        
        local sliding = false
        local function UpdateSlider(input)
            local relX = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
            currentVal = math.floor(min + ((max - min) * relX))
            ValLabel.Text = tostring(currentVal)
            Fill.Size = UDim2.new(relX, 0, 1, 0)
            if callback then
                task.spawn(callback, currentVal)
            end
        end
        
        Track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                sliding = true
                UpdateSlider(input)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                sliding = false
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                UpdateSlider(input)
            end
        end)
    end
    
    function tabObj:AddDropdown(dropdownText, itemsList, defaultItem, callback)
        local selected = defaultItem or itemsList[1] or ""
        local isOpen = false
        
        local DropFrame = Instance.new("Frame")
        DropFrame.Name = "Dropdown_" .. dropdownText
        DropFrame.Size = UDim2.new(1, 0, 0, 42)
        DropFrame.BackgroundColor3 = Color3.fromRGB(18, 21, 30)
        DropFrame.ClipsDescendants = true
        DropFrame.Parent = TabContent
        
        local DropCorner = Instance.new("UICorner")
        DropCorner.CornerRadius = UDim.new(0, 8)
        DropCorner.Parent = DropFrame
        
        local HeaderBtn = Instance.new("TextButton")
        HeaderBtn.Size = UDim2.new(1, 0, 0, 42)
        HeaderBtn.BackgroundTransparency = 1
        HeaderBtn.Text = ""
        HeaderBtn.Parent = DropFrame
        
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(0.5, 0, 1, 0)
        Title.Position = UDim2.new(0, 12, 0, 0)
        Title.BackgroundTransparency = 1
        Title.Text = dropdownText
        Title.TextColor3 = Color3.fromRGB(230, 235, 245)
        Title.Font = Enum.Font.GothamSemibold
        Title.TextSize = 12
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = HeaderBtn
        
        local SelectedLabel = Instance.new("TextLabel")
        SelectedLabel.Size = UDim2.new(0.45, -30, 1, 0)
        SelectedLabel.Position = UDim2.new(0.5, 0, 0, 0)
        SelectedLabel.BackgroundTransparency = 1
        SelectedLabel.Text = tostring(selected) .. " ▼"
        SelectedLabel.TextColor3 = Color3.fromRGB(0, 235, 255)
        SelectedLabel.Font = Enum.Font.GothamBold
        SelectedLabel.TextSize = 11
        SelectedLabel.TextXAlignment = Enum.TextXAlignment.Right
        SelectedLabel.Parent = HeaderBtn
        
        local ScrollList = Instance.new("ScrollingFrame")
        ScrollList.Size = UDim2.new(1, -16, 0, 120)
        ScrollList.Position = UDim2.new(0, 8, 0, 44)
        ScrollList.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
        ScrollList.BorderSizePixel = 0
        ScrollList.ScrollBarThickness = 3
        ScrollList.Parent = DropFrame
        
        local ListCorner = Instance.new("UICorner")
        ListCorner.CornerRadius = UDim.new(0, 6)
        ListCorner.Parent = ScrollList
        
        local ListLayout = Instance.new("UIListLayout")
        ListLayout.Padding = UDim.new(0, 2)
        ListLayout.Parent = ScrollList
        
        local function BuildList()
            for _, child in ipairs(ScrollList:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end
            for _, item in ipairs(itemsList) do
                local ItemBtn = Instance.new("TextButton")
                ItemBtn.Size = UDim2.new(1, 0, 0, 26)
                ItemBtn.BackgroundColor3 = Color3.fromRGB(22, 25, 36)
                ItemBtn.Text = tostring(item)
                ItemBtn.TextColor3 = Color3.fromRGB(210, 215, 230)
                ItemBtn.Font = Enum.Font.Gotham
                ItemBtn.TextSize = 11
                ItemBtn.Parent = ScrollList
                
                ItemBtn.MouseButton1Click:Connect(function()
                    selected = item
                    SelectedLabel.Text = tostring(item) .. " ▼"
                    isOpen = false
                    TweenService:Create(DropFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 42)}):Play()
                    if callback then
                        task.spawn(callback, selected)
                    end
                end)
            end
            ScrollList.CanvasSize = UDim2.new(0, 0, 0, #itemsList * 28)
        end
        BuildList()
        
        HeaderBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            local targetHeight = isOpen and 175 or 42
            TweenService:Create(DropFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
        end)
    end
    
    function tabObj:AddTextBox(boxTitle, placeholder, defaultText, callback)
        local BoxFrame = Instance.new("Frame")
        BoxFrame.Name = "TextBox_" .. boxTitle
        BoxFrame.Size = UDim2.new(1, 0, 0, 64)
        BoxFrame.BackgroundColor3 = Color3.fromRGB(18, 21, 30)
        BoxFrame.Parent = TabContent
        
        local BoxCorner = Instance.new("UICorner")
        BoxCorner.CornerRadius = UDim.new(0, 8)
        BoxCorner.Parent = BoxFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -24, 0, 22)
        Label.Position = UDim2.new(0, 12, 0, 6)
        Label.BackgroundTransparency = 1
        Label.Text = boxTitle
        Label.TextColor3 = Color3.fromRGB(230, 235, 245)
        Label.Font = Enum.Font.GothamSemibold
        Label.TextSize = 12
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = BoxFrame
        
        local Input = Instance.new("TextBox")
        Input.Size = UDim2.new(1, -24, 0, 28)
        Input.Position = UDim2.new(0, 12, 0, 30)
        Input.BackgroundColor3 = Color3.fromRGB(26, 30, 42)
        Input.PlaceholderText = placeholder or "Nhập tại đây..."
        Input.PlaceholderColor3 = Color3.fromRGB(120, 130, 150)
        Input.Text = defaultText or ""
        Input.TextColor3 = Color3.fromRGB(0, 235, 255)
        Input.Font = Enum.Font.Gotham
        Input.TextSize = 11
        Input.ClearTextOnFocus = false
        Input.Parent = BoxFrame
        
        local InCorner = Instance.new("UICorner")
        InCorner.CornerRadius = UDim.new(0, 6)
        InCorner.Parent = Input
        
        Input.FocusLost:Connect(function(enterPressed)
            if callback then
                task.spawn(callback, Input.Text)
            end
        end)
        return Input
    end
    
    function tabObj:AddButton(buttonText, callback)
        local Btn = Instance.new("TextButton")
        Btn.Name = "Button_" .. buttonText
        Btn.Size = UDim2.new(1, 0, 0, 36)
        Btn.BackgroundColor3 = Color3.fromRGB(0, 160, 220)
        Btn.Text = buttonText
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 12
        Btn.Parent = TabContent
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 8)
        BtnCorner.Parent = Btn
        
        Btn.MouseButton1Click:Connect(function()
            TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 220, 255)}):Play()
            task.wait(0.1)
            TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 160, 220)}):Play()
            if callback then
                task.spawn(callback)
            end
        end)
    end
    
    function tabObj:AddLabel(labelText)
        local InfoLabel = Instance.new("TextLabel")
        InfoLabel.Size = UDim2.new(1, 0, 0, 24)
        InfoLabel.BackgroundTransparency = 1
        InfoLabel.Text = labelText
        InfoLabel.TextColor3 = Color3.fromRGB(160, 175, 195)
        InfoLabel.Font = Enum.Font.Gotham
        InfoLabel.TextSize = 11
        InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
        InfoLabel.Parent = TabContent
        return InfoLabel
    end
    
    return tabObj
end

function QuocKhanhUI:Notify(title, message, duration)
    local dur = duration or 3
    local Toast = Instance.new("Frame")
    Toast.Size = UDim2.new(0, 270, 0, 62)
    Toast.Position = UDim2.new(1, 20, 1, -85)
    Toast.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
    Toast.Parent = self.ScreenGui
    
    local ToastCorner = Instance.new("UICorner")
    ToastCorner.CornerRadius = UDim.new(0, 10)
    ToastCorner.Parent = Toast
    
    local ToastStroke = Instance.new("UIStroke")
    ToastStroke.Color = Color3.fromRGB(0, 220, 255)
    ToastStroke.Thickness = 1.4
    ToastStroke.Parent = Toast
    
    local ToastTitle = Instance.new("TextLabel")
    ToastTitle.Size = UDim2.new(1, -20, 0, 22)
    ToastTitle.Position = UDim2.new(0, 10, 0, 6)
    ToastTitle.BackgroundTransparency = 1
    ToastTitle.Text = "👑 " .. title
    ToastTitle.TextColor3 = Color3.fromRGB(0, 240, 255)
    ToastTitle.Font = Enum.Font.GothamBold
    ToastTitle.TextSize = 12
    ToastTitle.TextXAlignment = Enum.TextXAlignment.Left
    ToastTitle.Parent = Toast
    
    local ToastMsg = Instance.new("TextLabel")
    ToastMsg.Size = UDim2.new(1, -20, 0, 28)
    ToastMsg.Position = UDim2.new(0, 10, 0, 28)
    ToastMsg.BackgroundTransparency = 1
    ToastMsg.Text = message
    ToastMsg.TextColor3 = Color3.fromRGB(220, 225, 235)
    ToastMsg.Font = Enum.Font.Gotham
    ToastMsg.TextSize = 11
    ToastMsg.TextXAlignment = Enum.TextXAlignment.Left
    ToastMsg.Parent = Toast
    
    TweenService:Create(Toast, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -290, 1, -85)
    }):Play()
    
    task.delay(dur, function()
        local outTween = TweenService:Create(Toast, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 20, 1, -85)
        })
        outTween:Play()
        outTween.Completed:Connect(function()
            Toast:Destroy()
        end)
    end)
end

--------------------------------------------------------------------------------
-- 7. KHỞI TẠO CÁC TAB CHỨC NĂNG
--------------------------------------------------------------------------------
local Hub = QuocKhanhUI.Init()
Hub:Notify("Quốc Khánh Hub", "Khởi động thành công! Bản Ultimate v3.5.", 4)

-- TAB 1: THÔNG TIN & CÀI ĐẶT
local TabInfo = Hub:CreateTab("Thông Tin", "📜")
TabInfo:AddSection("Hồ Sơ Nhân Vật")
local ExecLabel = TabInfo:AddLabel("⚡ Trình thực thi: " .. tostring(ExecutorName))
local SeaLabel = TabInfo:AddLabel("🌊 Vùng biển hiện tại: Sea " .. tostring(CurrentSea))
local ProfileLabel = TabInfo:AddLabel("👤 Người chơi: " .. LocalPlayer.Name .. " (ID: " .. LocalPlayer.UserId .. ")")
local LevelLabel = TabInfo:AddLabel("⭐ Cấp độ: " .. GetCurrentLevel() .. " / Max 2840")
local BeliLabel = TabInfo:AddLabel("💰 Beli: " .. (LocalPlayer.Data:FindFirstChild("Beli") and LocalPlayer.Data.Beli.Value or 0))
local FragLabel = TabInfo:AddLabel("🔮 Fragments: " .. (LocalPlayer.Data:FindFirstChild("Fragments") and LocalPlayer.Data.Fragments.Value or 0))

TabInfo:AddSection("Cài Đặt Ẩn / Hiện Menu")
TabInfo:AddToggle("Hiện Nút Tròn Trên Màn Hình (Mobile/PC)", true, function(state)
    _G_QK.ShowFloatingButton = state
    if Hub.FloatingBtn then
        Hub.FloatingBtn.Visible = state
    end
end)

TabInfo:AddDropdown("Đổi Phím Tắt Ẩn/Hiện Trên PC", {"RightControl", "Insert", "LeftControl", "RightShift"}, "RightControl", function(val)
    if val == "RightControl" then _G_QK.MenuKeybind = Enum.KeyCode.RightControl
    elseif val == "Insert" then _G_QK.MenuKeybind = Enum.KeyCode.Insert
    elseif val == "LeftControl" then _G_QK.MenuKeybind = Enum.KeyCode.LeftControl
    elseif val == "RightShift" then _G_QK.MenuKeybind = Enum.KeyCode.RightShift end
    Hub:Notify("Phím Tắt", "Đã đổi phím mở menu sang: " .. val)
end)

TabInfo:AddSection("Cấu Hình Discord Webhook")
TabInfo:AddTextBox("URL Discord Webhook", "Dán link Webhook vào đây...", _G_QK.WebhookURL, function(text)
    local cleaned = string.gsub(text, "%s+", "")
    _G_QK.WebhookURL = cleaned
    if writefile then
        writefile(_G_QK.WebhookSaveFile, cleaned)
    end
    if #cleaned > 15 then
        _G_QK.EnableWebhook = true
        Hub:Notify("Discord Webhook", "Đã lưu Webhook URL thành công!")
    end
end)

TabInfo:AddToggle("Bật Gửi Thông Báo Webhook", _G_QK.EnableWebhook, function(state)
    _G_QK.EnableWebhook = state
    Hub:Notify("Discord Webhook", state and "Đã bật gửi thông báo Webhook!" or "Đã tắt Webhook!")
end)

TabInfo:AddButton("Gửi Thử Nghiệm Báo Cáo Discord", function()
    if _G_QK.WebhookURL == "" or #_G_QK.WebhookURL < 15 then
        Hub:Notify("Webhook", "Vui lòng nhập Webhook URL vào ô bên trên trước!")
        return
    end
    _G_QK.EnableWebhook = true
    SendDiscordWebhook("Kiểm Tra Hoạt Động", "Quốc Khánh Hub kết nối Discord Webhook thành công 100%!", 65535, {
        {["name"] = "Người Chơi", ["value"] = LocalPlayer.Name .. " (Lv. " .. GetCurrentLevel() .. ")", ["inline"] = true},
        {["name"] = "Beli", ["value"] = tostring(LocalPlayer.Data.Beli.Value), ["inline"] = true},
        {["name"] = "Fragments", ["value"] = tostring(LocalPlayer.Data.Fragments.Value), ["inline"] = true},
        {["name"] = "Vùng Biển", ["value"] = "Sea " .. tostring(CurrentSea), ["inline"] = true},
        {["name"] = "Trình Thực Thi", ["value"] = tostring(ExecutorName), ["inline"] = true}
    })
    Hub:Notify("Webhook", "Đã gửi tín hiệu kiểm tra đến Discord!")
end)

TabInfo:AddSection("Tiện Ích Hệ Thống")
TabInfo:AddToggle("Chống Văng Game (Anti-AFK)", true, function(state)
    _G_QK.AntiAFK = state
    Hub:Notify("Anti-AFK", state and "Đã kích hoạt chống văng game!" or "Đã tắt chống văng game!")
end)

TabInfo:AddButton("Đổi Server Khác (Server Hop)", function()
    Hub:Notify("Server Hop", "Đang tìm kiếm máy chủ có ping tốt...", 3)
    pcall(function()
        local serversUrl = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local serverData = HttpService:JSONDecode(game:HttpGet(serversUrl))
        for _, s in ipairs(serverData.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
                break
            end
        end
    end)
end)

TabInfo:AddButton("Vào Lại Server Hiện Tại (Rejoin)", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

TabInfo:AddButton("Tự Động Nhập Toàn Bộ Code Còn Hạn", function()
    local codes = {
        "SUB2GAMERROBOT_EXP1", "KITT_RESET", "Sub2Fer999", "StrawHatMaine",
        "Sub2OfficialNoobie", "THEGREATACE", "AXIORE", "TantaiGaming",
        "BLUXXY", "fudd10", "BIGNEWS", "CHANDLER", "FUDD10_V2"
    }
    Hub:Notify("Redeem Codes", "Bắt đầu kích hoạt " .. #codes .. " giftcode...", 3)
    for _, code in ipairs(codes) do
        pcall(function()
            if Remotes.Redeem then
                Remotes.Redeem:InvokeServer(code)
            end
        end)
        task.wait(0.25)
    end
    Hub:Notify("Redeem Codes", "Đã nhập xong toàn bộ mã Code!", 3)
end)

TabInfo:AddToggle("Tăng Tốc Game / Giảm Lag (FPS Boost)", false, function(state)
    _G_QK.FPSBoost = state
    if state then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
                v.Material = Enum.Material.SmoothPlastic
            end
        end
        Hub:Notify("FPS Boost", "Đã tối ưu hóa đồ họa tăng FPS mượt mà!")
    end
end)

-- TAB 2: AUTO FARM LEVEL
local TabFarm = Hub:CreateTab("Auto Farm", "⚔️")
TabFarm:AddSection("Cày Cấp Tự Động (Auto Farm Level)")
TabFarm:AddToggle("Bật Auto Farm Cấp (Auto Farm Level)", false, function(state)
    _G_QK.AutoFarmLevel = state
    if not state then
        StopTween()
    else
        Hub:Notify("Auto Farm", "Đã bắt đầu chu trình Farm Cấp Thông Minh!", 3)
    end
end)

TabFarm:AddDropdown("Chọn Loại Vũ Khí Để Cày", {"Melee", "Sword", "Blox Fruit", "Gun"}, "Melee", function(val)
    _G_QK.WeaponType = val
    Hub:Notify("Vũ Khí", "Đã chuyển vũ khí sang: " .. val)
end)

TabFarm:AddToggle("Đánh Cực Nhanh (Fast Attack v4)", true, function(state)
    _G_QK.FastAttack = state
end)

TabFarm:AddToggle("Hút & Gom Quái Lại Gần (Bring Mob AOE)", true, function(state)
    _G_QK.BringMob = state
end)

TabFarm:AddSlider("Khoảng Cách Bay Lơ Lửng Trên Quái", 12, 35, 20, function(val)
    _G_QK.FarmDistance = val
end)

TabFarm:AddSection("Hỗ Trợ Chiến Đấu Haki")
TabFarm:AddToggle("Tự Động Kích Hoạt Buso Haki (Aura)", true, function(state)
    _G_QK.AutoBuso = state
end)

TabFarm:AddToggle("Tự Động Bật Ken Haki (Quan Sát)", false, function(state)
    _G_QK.AutoKen = state
end)

-- TAB 3: AUTO FARM QUÁI & BOSS
local TabBoss = Hub:CreateTab("Săn Quái & Boss", "👹")
TabBoss:AddSection("Tự Động Đánh Quái Chỉ Định")

local dynamicMobs = {"Bandit", "Monkey", "Gorilla", "Pirate", "Brute", "Desert Bandit", "Snow Bandit", "Snowman", "Chief Petty Officer", "Military Soldier", "Military Spy", "Fishman Warrior", "God's Guard", "Raider", "Mercenary", "Swan Pirate"}
TabBoss:AddDropdown("Chọn Tên Quái Để Farm", dynamicMobs, dynamicMobs[1], function(val)
    _G_QK.SelectedMob = val
end)

TabBoss:AddToggle("Tự Bay Đến Tiêu Diệt Quái Đã Chọn", false, function(state)
    _G_QK.AutoFarmSelectedMob = state
    if not state then StopTween() end
end)

TabBoss:AddSection("Săn Boss Server")
local bossList = {"The Gorilla King", "Bobby", "Yeti", "Vice Admiral", "Warden", "Chief Warden", "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg"}
TabBoss:AddDropdown("Chọn Boss Cần Săn", bossList, bossList[1], function(val)
    _G_QK.SelectedBoss = val
end)

TabBoss:AddToggle("Tự Tìm & Tiêu Diệt Boss Khi Xuất Hiện", false, function(state)
    _G_QK.AutoFarmBoss = state
    if not state then StopTween() end
end)

-- TAB 4: AUTO NHẶT RƯƠNG
local TabChest = Hub:CreateTab("Nhặt Rương", "💎")
TabChest:AddSection("Thu Thập Rương Tự Động Toàn Map")
local ChestCountLabel = TabChest:AddLabel("💎 Số rương đã nhặt: 0")

TabChest:AddToggle("Bật Auto Gom Rương (Auto Chest)", false, function(state)
    _G_QK.AutoChest = state
    if not state then
        StopTween()
    else
        Hub:Notify("Auto Chest", "Bắt đầu quét và gom rương toàn bản đồ!", 3)
    end
end)

TabChest:AddSlider("Tốc Độ Bay Nhặt Rương (Tween Speed)", 150, 350, 260, function(val)
    _G_QK.TweenSpeed = val
end)

-- TAB 5: AUTO NÂNG ĐIỂM
local TabStats = Hub:CreateTab("Nâng Điểm", "📊")
TabStats:AddSection("Cộng Điểm Tự Động (Auto Stats)")
TabStats:AddToggle("Bật Tự Động Nâng Điểm", false, function(state)
    _G_QK.AutoStats = state
    if state then
        Hub:Notify("Auto Stats", "Đã bật tự động cộng điểm chỉ số!")
    end
end)

TabStats:AddSlider("Số Điểm Cộng Mỗi Lần", 1, 10, 3, function(val)
    _G_QK.StatPointsChunk = val
end)

TabStats:AddToggle("Nâng Cận Chiến (Melee)", true, function(state)
    _G_QK.StatsToUpgrade["Melee"] = state
end)

TabStats:AddToggle("Nâng Phòng Thủ / Máu (Defense)", true, function(state)
    _G_QK.StatsToUpgrade["Defense"] = state
end)

TabStats:AddToggle("Nâng Kiếm (Sword)", false, function(state)
    _G_QK.StatsToUpgrade["Sword"] = state
end)

TabStats:AddToggle("Nâng Súng (Gun)", false, function(state)
    _G_QK.StatsToUpgrade["Gun"] = state
end)

TabStats:AddToggle("Nâng Trái Ác Quỷ (Demon Fruit)", false, function(state)
    _G_QK.StatsToUpgrade["Demon Fruit"] = state
end)

-- TAB 6: ESP & ĐỊNH VỊ
local TabESP = Hub:CreateTab("Định Vị ESP", "👁️")
TabESP:AddSection("Hiển Thị Nhìn Xuyên Bản Đồ (Neon ESP)")

TabESP:AddToggle("ESP Người Chơi (Players ESP)", false, function(state)
    _G_QK.ESP_Players = state
end)

TabESP:AddToggle("ESP Rương Báu (Chests ESP)", false, function(state)
    _G_QK.ESP_Chests = state
end)

TabESP:AddToggle("ESP Trái Ác Quỷ Rơi (Fruit ESP)", false, function(state)
    _G_QK.ESP_Fruits = state
end)

TabESP:AddToggle("ESP Quái & Boss (Mobs ESP)", false, function(state)
    _G_QK.ESP_Mobs = state
end)

-- TAB 7: DỊCH CHUYỂN BẢN ĐỒ
local TabTeleport = Hub:CreateTab("Dịch Chuyển", "🌌")
TabTeleport:AddSection("Dịch Chuyển Đến Các Đảo Biển 1 & Đền Thần")

local islandNames = {}
for name, _ in pairs(IslandWaypoints) do
    table.insert(islandNames, name)
end

local chosenIsland = islandNames[1]
TabTeleport:AddDropdown("Chọn Đảo Cần Đến", islandNames, chosenIsland, function(val)
    chosenIsland = val
end)

TabTeleport:AddButton("Bay Đến Đảo Đã Chọn (Safe Tween)", function()
    local targetCF = IslandWaypoints[chosenIsland]
    if targetCF then
        Hub:Notify("Dịch Chuyển", "Đang bay đến " .. chosenIsland .. "...", 3)
        SafeTween(targetCF)
    end
end)

TabTeleport:AddButton("Dừng Bay Dịch Chuyển Tức Thì", function()
    StopTween()
    Hub:Notify("Dịch Chuyển", "Đã dừng bay!")
end)

-- TAB 8: TRÁI ÁC QUỶ & SHOP
local TabFruit = Hub:CreateTab("Trái & Shop", "🍎")
TabFruit:AddSection("Trái Ác Quỷ (Devil Fruit)")

TabFruit:AddToggle("Tự Nhặt Trái Khi Spawn (Fruit Sniper)", false, function(state)
    _G_QK.AutoSnipeFruit = state
    if state then Hub:Notify("Fruit Sniper", "Đang quét tìm trái rơi trên bản đồ...") end
end)

TabFruit:AddToggle("Tự Động Cất Trái Vào Rương (Store Fruit)", false, function(state)
    _G_QK.AutoStoreFruit = state
end)

TabFruit:AddButton("Mua Trái Ngẫu Nhiên (Random Fruit / Gacha)", function()
    pcall(function()
        if Remotes.CommF_ then
            local res = Remotes.CommF_:InvokeServer("Cousin", "Buy")
            Hub:Notify("Random Trái", "Kết quả: " .. tostring(res), 4)
        end
    end)
end)

TabFruit:AddSection("Mua Nhanh Võ & Haki Từ Xa")
TabFruit:AddButton("Học Geppo (Nhảy Cao Trên Không - 10,000 Beli)", function()
    pcall(function()
        if Remotes.CommF_ then Remotes.CommF_:InvokeServer("BuyHaki", "Geppo") end
    end)
end)

TabFruit:AddButton("Học Buso Haki (Haki Vũ Trang - 25,000 Beli)", function()
    pcall(function()
        if Remotes.CommF_ then Remotes.CommF_:InvokeServer("BuyHaki", "Buso") end
    end)
end)

TabFruit:AddButton("Học Soru (Dịch Chuyển Tức Thời - 100,000 Beli)", function()
    pcall(function()
        if Remotes.CommF_ then Remotes.CommF_:InvokeServer("BuyHaki", "Soru") end
    end)
end)

-- TAB 9: CHIẾN ĐẤU & DI CHUYỂN
local TabMisc = Hub:CreateTab("Chiến Đấu & Bay", "⚡")
TabMisc:AddSection("Tự Động Xuất Chiêu (Auto Skills)")
TabMisc:AddToggle("Spam Chiêu Z", false, function(state) _G_QK.AutoSkillZ = state end)
TabMisc:AddToggle("Spam Chiêu X", false, function(state) _G_QK.AutoSkillX = state end)
TabMisc:AddToggle("Spam Chiêu C", false, function(state) _G_QK.AutoSkillC = state end)
TabMisc:AddToggle("Spam Chiêu V", false, function(state) _G_QK.AutoSkillV = state end)

TabMisc:AddSection("Bypass Di Chuyển & Gian Lận")
TabMisc:AddToggle("Đi Xuyên Tường (Noclip)", false, function(state)
    _G_QK.Noclip = state
end)

TabMisc:AddToggle("Nhảy Vô Hạn Trên Không (Infinite Jump)", false, function(state)
    _G_QK.InfiniteJump = state
end)

TabMisc:AddSlider("Tốc Độ Chạy (WalkSpeed)", 16, 200, 16, function(val)
    _G_QK.WalkSpeed = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

TabMisc:AddSlider("Độ Cao Nhảy (JumpPower)", 50, 300, 50, function(val)
    _G_QK.JumpPower = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

-- TAB 10: 🦊 ĐẢO KITSUNE & LỬA XANH (KITSUNE SHRINE)
local TabKitsune = Hub:CreateTab("Đảo Kitsune", "🦊")
TabKitsune:AddSection("Sự Kiện Đảo Hồ Ly & Lửa Xanh (Blue Embers)")

local BlueMoonLabel = TabKitsune:AddLabel("🌕 Trăng Xanh: " .. _G_QK.BlueMoonStatus)

TabKitsune:AddToggle("Tự Động Gom Lửa Xanh (Auto Collect Embers)", false, function(state)
    _G_QK.AutoCollectEmbers = state
    if state then Hub:Notify("Kitsune", "Bắt đầu quét và nhặt đốm lửa xanh!") end
end)

TabKitsune:AddToggle("Tự Động Cầu Nguyện Tại Tượng (Auto Pray)", false, function(state)
    _G_QK.AutoPrayStatue = state
end)

TabKitsune:AddButton("Chạm Tượng Hồ Ly (Touch Kitsune Statue)", function()
    pcall(function()
        if Remotes.TouchKitsuneStatue then
            Remotes.TouchKitsuneStatue:FireServer()
            Hub:Notify("Kitsune Statue", "Đã chạm vào tượng Hồ Ly!")
        end
    end)
end)

TabKitsune:AddButton("Bay Đến Tọa Độ Đảo Hồ Ly (Kitsune Island)", function()
    local cf = IslandWaypoints["Kitsune Island (Đảo Hồ Ly)"]
    if cf then SafeTween(cf) end
end)

-- TAB 11: ⏳ THỨC TỈNH TỘC V4 & ĐỀN THỜI GIAN
local TabV4 = Hub:CreateTab("Tộc V4 & Đền", "⏳")
TabV4:AddSection("Thức Tỉnh Tộc V4 (Race Awakening)")

TabV4:AddToggle("Tự Động Kích Hoạt Nộ Tộc V4 Khi Đầy", false, function(state)
    _G_QK.AutoAwakenV4 = state
end)

TabV4:AddToggle("Tự Động Sử Dụng Chiêu Tộc V4 (Race Skill)", false, function(state)
    _G_QK.AutoUseRaceSkill = state
end)

TabV4:AddSection("Đền Thời Gian & Bánh Răng Xanh (Mirage Gear)")
TabV4:AddButton("Gạt Cần Mở Cửa Trial (Pull Temple Lever)", function()
    pcall(function()
        if Remotes.Temple then
            Remotes.Temple:FireServer("PullLever")
            Hub:Notify("Đền Thời Gian", "Đã gạt cần mở cửa!")
        end
    end)
end)

TabV4:AddToggle("Tự Tìm Bánh Răng Xanh (Blue Gear Finder)", false, function(state)
    _G_QK.AutoMirageGear = state
    if state then Hub:Notify("Mirage Island", "Bắt đầu quét tìm Bánh Răng Xanh trên đảo!") end
end)

TabV4:AddButton("Bay Đến Đền Thời Gian (Temple of Time)", function()
    local cf = IslandWaypoints["Temple of Time (Đền Thời Gian)"]
    if cf then SafeTween(cf) end
end)

-- TAB 12: 🌊 SĂN BIỂN & LEVIATHAN
local TabSea = Hub:CreateTab("Săn Biển", "🌊")
TabSea:AddSection("Săn Boss Thủy Quái Leviathan")

TabSea:AddToggle("Tự Tấn Công Leviathan (Leviathan Hunter)", false, function(state)
    _G_QK.AutoLeviathan = state
    if state then Hub:Notify("Leviathan", "Bắt đầu quét và tấn công Leviathan!") end
end)

TabSea:AddSection("Sự Kiện Biển (Sea Events)")
TabSea:AddToggle("Tự Động Săn Quái Biển (Sea Beast Hunter)", false, function(state)
    _G_QK.AutoSeaBeast = state
    if state then Hub:Notify("Sea Beast", "Bắt đầu quét và săn Sea Beast!") end
end)

TabSea:AddToggle("Tự Động Bắn Thuyền Ma (Ship Raid Hunter)", false, function(state)
    _G_QK.AutoShipRaid = state
    if state then Hub:Notify("Ship Raid", "Bắt đầu quét và bắn Thuyền Ma!") end
end)

--------------------------------------------------------------------------------
-- 8. CÁC LUỒNG THỰC THI NỀN TẢNG (100% WORKING BACKGROUND THREADS)
--------------------------------------------------------------------------------

-- Helper: Tự động kích hoạt Buso Haki định kỳ (không spam lag)
local lastBusoCheck = 0
local function EnsureBuso()
    if not _G_QK.AutoBuso then return end
    if tick() - lastBusoCheck < 4 then return end
    lastBusoCheck = tick()
    pcall(function()
        local char = LocalPlayer.Character
        if char and Remotes.CommF_ then
            local hasAura = char:FindFirstChild("HasBuso") or (char:GetAttribute("HasBuso") == true)
            if not hasAura then
                Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end)
end

-- Helper: Xuất chiêu phím Z, X, C, V
local function TriggerSkills()
    pcall(function()
        if _G_QK.AutoSkillZ then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
            task.wait(0.01)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
        end
        if _G_QK.AutoSkillX then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game)
            task.wait(0.01)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game)
        end
        if _G_QK.AutoSkillC then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
            task.wait(0.01)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game)
        end
        if _G_QK.AutoSkillV then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.V, false, game)
            task.wait(0.01)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game)
        end
    end)
end

-- 1. LUỒNG AUTO FARM LEVEL CỐT LÕI (SIÊU MƯỢT - KHÔNG GIẬT KHÔNG RỚT)
task.spawn(function()
    while true do
        task.wait(0.03)
        if _G_QK.AutoFarmLevel then
            pcall(function()
                local qData = GetCurrentQuestData()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then
                    SetFlyAnchor(false)
                    return
                end
                
                local hrp = char.HumanoidRootPart
                EnsureBuso()
                
                -- Kiểm tra trạng thái Quest hiện tại
                local questGui = PlayerGui:FindFirstChild("Main") and PlayerGui.Main:FindFirstChild("Quest")
                local hasActiveQuest = questGui and questGui.Visible
                
                if not hasActiveQuest then
                    -- Chưa có Quest -> Bay mượt đến NPC nhận Quest
                    SetFlyAnchor(false)
                    local distToNPC = (hrp.Position - qData.CFrame.Position).Magnitude
                    if distToNPC > 25 then
                        SafeTween(qData.CFrame)
                    else
                        StopTween()
                        hrp.CFrame = qData.CFrame
                        if Remotes.CommF_ then
                            Remotes.CommF_:InvokeServer("StartQuest", qData.Quest, qData.Level)
                        end
                        task.wait(0.4)
                    end
                else
                    -- Đã có Quest -> Quét quái mục tiêu
                    local enemiesFolder = Workspace:FindFirstChild("Enemies")
                    local targetMob = nil
                    
                    if enemiesFolder then
                        for _, mob in ipairs(enemiesFolder:GetChildren()) do
                            if (mob.Name == qData.Name or string.find(mob.Name, qData.Name)) and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                                targetMob = mob
                                break
                            end
                        end
                    end
                    
                    if targetMob and targetMob:FindFirstChild("HumanoidRootPart") then
                        local mobHrp = targetMob.HumanoidRootPart
                        local distToMob = (hrp.Position - mobHrp.Position).Magnitude
                        
                        -- Vị trí lơ lửng an toàn trực diện phía trên quái (giữ góc nhìn camera ổn định)
                        local targetPos = CFrame.new(mobHrp.Position + Vector3.new(0, _G_QK.FarmDistance, 0), mobHrp.Position)
                        
                        if distToMob > 40 then
                            -- Còn xa -> Bay tiếp cận bằng SafeTween
                            SetFlyAnchor(false)
                            SafeTween(targetPos)
                        else
                            -- Đã đến phạm vi đánh -> Dừng tween, gài neo lơ lửng và duy trì vị trí
                            StopTween()
                            SetFlyAnchor(true)
                            hrp.CFrame = targetPos
                            hrp.Velocity = Vector3.zero
                            
                            -- Gom quái cụm AOE
                            BringNearbyMobs(qData.Name, mobHrp.CFrame)
                            
                            -- Cầm vũ khí và Fast Attack v4
                            EquipSelectedWeapon()
                            if _G_QK.FastAttack then
                                PerformFastAttack(targetMob)
                            end
                            TriggerSkills()
                        end
                    else
                        -- Chưa có quái xuất hiện -> Bay đến bãi quái chờ hồi sinh
                        SetFlyAnchor(false)
                        SafeTween(qData.MobCFrame)
                    end
                end
            end)
        end
    end
end)

-- 2. LUỒNG AUTO FARM QUÁI CHỈ ĐỊNH (SELECTED MOB)
task.spawn(function()
    while true do
        task.wait(0.05)
        if _G_QK.AutoFarmSelectedMob and not _G_QK.AutoFarmLevel then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then
                    SetFlyAnchor(false)
                    return
                end
                
                local hrp = char.HumanoidRootPart
                EnsureBuso()
                
                local enemies = Workspace:FindFirstChild("Enemies")
                local target = nil
                if enemies then
                    for _, mob in ipairs(enemies:GetChildren()) do
                        if string.find(mob.Name, _G_QK.SelectedMob) and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            target = mob
                            break
                        end
                    end
                end
                
                if target and target:FindFirstChild("HumanoidRootPart") then
                    local mobHrp = target.HumanoidRootPart
                    local dist = (hrp.Position - mobHrp.Position).Magnitude
                    local targetPos = CFrame.new(mobHrp.Position + Vector3.new(0, _G_QK.FarmDistance, 0), mobHrp.Position)
                    
                    if dist > 40 then
                        SetFlyAnchor(false)
                        SafeTween(targetPos)
                    else
                        StopTween()
                        SetFlyAnchor(true)
                        hrp.CFrame = targetPos
                        hrp.Velocity = Vector3.zero
                        BringNearbyMobs(_G_QK.SelectedMob, mobHrp.CFrame)
                        EquipSelectedWeapon()
                        if _G_QK.FastAttack then PerformFastAttack(target) end
                        TriggerSkills()
                    end
                else
                    SetFlyAnchor(false)
                end
            end)
        end
    end
end)

-- 3. LUỒNG AUTO SĂN BOSS SERVER
task.spawn(function()
    while true do
        task.wait(0.1)
        if _G_QK.AutoFarmBoss and not _G_QK.AutoFarmLevel then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then
                    SetFlyAnchor(false)
                    return
                end
                
                local hrp = char.HumanoidRootPart
                EnsureBuso()
                
                local enemies = Workspace:FindFirstChild("Enemies")
                local targetBoss = nil
                if enemies then
                    for _, mob in ipairs(enemies:GetChildren()) do
                        if string.find(mob.Name, _G_QK.SelectedBoss) and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            targetBoss = mob
                            break
                        end
                    end
                end
                
                if targetBoss and targetBoss:FindFirstChild("HumanoidRootPart") then
                    local bossHrp = targetBoss.HumanoidRootPart
                    local dist = (hrp.Position - bossHrp.Position).Magnitude
                    local targetPos = CFrame.new(bossHrp.Position + Vector3.new(0, _G_QK.FarmDistance + 4, 0), bossHrp.Position)
                    
                    if dist > 40 then
                        SetFlyAnchor(false)
                        SafeTween(targetPos)
                    else
                        StopTween()
                        SetFlyAnchor(true)
                        hrp.CFrame = targetPos
                        hrp.Velocity = Vector3.zero
                        EquipSelectedWeapon()
                        if _G_QK.FastAttack then PerformFastAttack(targetBoss) end
                        TriggerSkills()
                    end
                else
                    SetFlyAnchor(false)
                end
            end)
        end
    end
end)

-- 4. LUỒNG AUTO NHẶT RƯƠNG (AUTO CHESTS)
task.spawn(function()
    while true do
        task.wait(0.4)
        if _G_QK.AutoChest and not _G_QK.AutoFarmLevel and not _G_QK.AutoFarmBoss then
            pcall(function()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                local nearestChest = nil
                local shortestDist = math.huge
                
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and string.find(obj.Name, "Chest") and obj:FindFirstChild("TouchInterest") then
                        local dist = (hrp.Position - obj.Position).Magnitude
                        if dist < shortestDist then
                            shortestDist = dist
                            nearestChest = obj
                        end
                    end
                end
                
                if nearestChest then
                    SafeTween(nearestChest.CFrame * CFrame.new(0, 2, 0), _G_QK.TweenSpeed)
                    if (hrp.Position - nearestChest.Position).Magnitude <= 12 then
                        firetouchinterest(hrp, nearestChest, 0)
                        firetouchinterest(hrp, nearestChest, 1)
                        _G_QK.ChestsCollected = _G_QK.ChestsCollected + 1
                        ChestCountLabel.Text = "💎 Số rương đã nhặt: " .. _G_QK.ChestsCollected
                        task.wait(0.25)
                    end
                end
            end)
        end
    end
end)

-- 5. LUỒNG AUTO NÂNG ĐIỂM (AUTO STATS)
task.spawn(function()
    while true do
        task.wait(1.5)
        if _G_QK.AutoStats and Remotes.CommF_ then
            pcall(function()
                local points = LocalPlayer.Data:FindFirstChild("Points") and LocalPlayer.Data.Points.Value or 0
                if points > 0 then
                    local chunk = math.min(points, _G_QK.StatPointsChunk)
                    for statName, isEnabled in pairs(_G_QK.StatsToUpgrade) do
                        if isEnabled and points > 0 then
                            Remotes.CommF_:InvokeServer("AddPoint", statName, chunk)
                            task.wait(0.08)
                        end
                    end
                end
            end)
        end
    end
end)

-- 6. LUỒNG HỆ THỐNG ESP NEON PHÁT SÁNG THẬT 100%
local activeESPs = {}

local function ClearESP(obj)
    if activeESPs[obj] then
        for _, v in pairs(activeESPs[obj]) do
            pcall(function() v:Destroy() end)
        end
        activeESPs[obj] = nil
    end
end

local function CreateESP(obj, text, color)
    if activeESPs[obj] then return end
    pcall(function()
        local highlight = Instance.new("Highlight")
        highlight.Name = "QK_Highlight"
        highlight.FillColor = color
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0.2
        highlight.Adornee = obj
        highlight.Parent = SafeParent
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "QK_Billboard"
        billboard.Size = UDim2.new(0, 140, 0, 30)
        billboard.AlwaysOnTop = true
        billboard.Adornee = obj:IsA("Model") and (obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Head") or obj.PrimaryPart) or obj
        billboard.Parent = SafeParent
        
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = color
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 11
        lbl.TextStrokeTransparency = 0.4
        lbl.Parent = billboard
        
        activeESPs[obj] = {highlight, billboard, lbl}
    end)
end

task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            -- 1. ESP Players
            if _G_QK.ESP_Players then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                        local hrp = p.Character.HumanoidRootPart
                        local dist = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 0)
                        CreateESP(p.Character, p.Name .. " [" .. dist .. "m]", Color3.fromRGB(0, 240, 255))
                    end
                end
            end
            
            -- 2. ESP Chests
            if _G_QK.ESP_Chests then
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and string.find(obj.Name, "Chest") and obj:FindFirstChild("TouchInterest") then
                        local dist = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - obj.Position).Magnitude) or 0)
                        CreateESP(obj, "💎 Rương [" .. dist .. "m]", Color3.fromRGB(255, 215, 0))
                    end
                end
            end
            
            -- 3. ESP Fruits
            if _G_QK.ESP_Fruits then
                for _, obj in ipairs(Workspace:GetChildren()) do
                    if string.find(obj.Name, "Fruit") or obj:IsA("Tool") then
                        CreateESP(obj, "🍎 " .. obj.Name, Color3.fromRGB(220, 80, 255))
                    end
                end
            end
            
            -- 4. ESP Mobs / Bosses
            if _G_QK.ESP_Mobs then
                local enemies = Workspace:FindFirstChild("Enemies")
                if enemies then
                    for _, mob in ipairs(enemies:GetChildren()) do
                        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            local hp = math.floor(mob.Humanoid.Health)
                            CreateESP(mob, mob.Name .. " [HP: " .. hp .. "]", Color3.fromRGB(255, 120, 50))
                        end
                    end
                end
            end
            
            -- Dọn dẹp ESP khi tắt toggle
            if not _G_QK.ESP_Players and not _G_QK.ESP_Chests and not _G_QK.ESP_Fruits and not _G_QK.ESP_Mobs then
                for obj, _ in pairs(activeESPs) do
                    ClearESP(obj)
                end
            end
        end)
    end
end)

-- 7. LUỒNG AUTO NHẶT TRÁI RƠI (FRUIT SNIPER) & CẤT VÀO KHO (STORE FRUIT)
task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            -- 1. Quét tìm trái rơi trên map và bay đến nhặt
            if _G_QK.AutoSnipeFruit then
                for _, obj in ipairs(Workspace:GetChildren()) do
                    if (string.find(obj.Name, "Fruit") or (obj:IsA("Tool") and string.find(obj.Name, "Fruit"))) then
                        local handle = obj:FindFirstChild("Handle") or (obj:IsA("BasePart") and obj)
                        if handle then
                            SafeTween(handle.CFrame, 350)
                            if (hrp.Position - handle.Position).Magnitude <= 10 then
                                firetouchinterest(hrp, handle, 0)
                                firetouchinterest(hrp, handle, 1)
                                Hub:Notify("Fruit Sniper", "Đã nhặt thành công: " .. obj.Name, 4)
                                task.wait(0.3)
                            end
                        end
                    end
                end
            end
            
            -- 2. Tự động cất trái trong Balo vào kho
            if _G_QK.AutoStoreFruit and Remotes.CommF_ then
                for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and string.find(tool.Name, "Fruit") then
                        Remotes.CommF_:InvokeServer("StoreFruit", tool.Name, tool)
                        Hub:Notify("Cất Trái", "Đã cất vào kho: " .. tool.Name, 3)
                        
                        -- Gửi Discord Webhook
                        SendDiscordWebhook("Nhặt & Cất Trái Thành Công", "Trái Ác Quỷ đã được tự động cất vào rương lưu trữ!", 16753920, {
                            {["name"] = "Tên Trái", ["value"] = tool.Name, ["inline"] = true},
                            {["name"] = "Người Chơi", ["value"] = LocalPlayer.Name .. " (Lv. " .. GetCurrentLevel() .. ")", ["inline"] = true}
                        })
                        task.wait(0.5)
                    end
                end
            end
        end)
    end
end)

-- 8. LUỒNG SỰ KIỆN KITSUNE (LỬA XANH BLUE EMBER & CẦU NGUYỆN)
task.spawn(function()
    while true do
        task.wait(0.3)
        if _G_QK.AutoCollectEmbers then
            pcall(function()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                for _, obj in ipairs(Workspace:GetChildren()) do
                    if string.find(obj.Name, "Ember") or string.find(obj.Name, "BlueEmber") then
                        local emberPart = obj:IsA("BasePart") and obj or obj:FindFirstChildOfClass("BasePart")
                        if emberPart and Remotes.CollectBlueEmber then
                            Remotes.CollectBlueEmber:FireServer(emberPart)
                            SafeTween(emberPart.CFrame, 350)
                            task.wait(0.2)
                        end
                    end
                end
            end)
        end
        if _G_QK.AutoPrayStatue and Remotes.KitsuneStatuePray then
            pcall(function()
                Remotes.KitsuneStatuePray:InvokeServer()
            end)
        end
    end
end)

-- 9. LUỒNG TỘC V4 (RACE AWAKENING) & BÁNH RĂNG MIRAGE
task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            if _G_QK.AutoAwakenV4 and Remotes.ActivateRaceV4 then
                Remotes.ActivateRaceV4:FireServer()
            end
            if _G_QK.AutoUseRaceSkill and Remotes.UsedRaceSkill then
                Remotes.UsedRaceSkill:FireServer()
            end
            if _G_QK.AutoMirageGear then
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj.Name == "Gear" or string.find(obj.Name, "MirageGear") then
                        SafeTween(obj.CFrame, 350)
                        Hub:Notify("Mirage Gear", "Đã tìm thấy Bánh Răng Xanh!")
                        break
                    end
                end
            end
        end)
    end
end)

-- 10. LUỒNG SĂN BIỂN & LEVIATHAN
task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            -- Săn Leviathan
            if _G_QK.AutoLeviathan and Remotes.Leviathan then
                local seaBeasts = Workspace:FindFirstChild("SeaBeasts")
                if seaBeasts then
                    for _, beast in ipairs(seaBeasts:GetChildren()) do
                        if string.find(beast.Name, "Leviathan") and beast:FindFirstChild("HumanoidRootPart") then
                            SafeTween(beast.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                            EquipSelectedWeapon()
                            PerformFastAttack(beast)
                            Remotes.Leviathan:FireServer("Hit", beast.HumanoidRootPart)
                        end
                    end
                end
            end
            
            -- Săn Sea Beast
            if _G_QK.AutoSeaBeast then
                local seaBeasts = Workspace:FindFirstChild("SeaBeasts") or Workspace:FindFirstChild("Enemies")
                if seaBeasts then
                    for _, beast in ipairs(seaBeasts:GetChildren()) do
                        if string.find(beast.Name, "SeaBeast") and beast:FindFirstChild("HumanoidRootPart") then
                            SafeTween(beast.HumanoidRootPart.CFrame * CFrame.new(0, 35, 0))
                            EquipSelectedWeapon()
                            PerformFastAttack(beast)
                        end
                    end
                end
            end
            
            -- Bắn Thuyền Ma (Ship Raid)
            if _G_QK.AutoShipRaid then
                local boats = Workspace:FindFirstChild("Boats") or Workspace:FindFirstChild("Enemies")
                if boats then
                    for _, boat in ipairs(boats:GetChildren()) do
                        if string.find(boat.Name, "Brigade") or string.find(boat.Name, "Ship") then
                            local boatHrp = boat:FindFirstChild("HumanoidRootPart") or boat:FindFirstChildOfClass("BasePart")
                            if boatHrp then
                                SafeTween(boatHrp.CFrame * CFrame.new(0, 25, 0))
                                EquipSelectedWeapon()
                                PerformFastAttack(boat)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- 11. LUỒNG NOCLIP (XUYÊN TƯỜNG) & NHẢY VÔ HẠN
RunService.Stepped:Connect(function()
    if _G_QK.Noclip or _G_QK.AutoFarmLevel or _G_QK.AutoChest or _G_QK.AutoFarmBoss or _G_QK.AutoFarmSelectedMob then
        pcall(function()
            if LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

UserInputService.JumpRequest:Connect(function()
    if _G_QK.InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- 12. CHỐNG VĂNG GAME DO TREO MÁY (ANTI-AFK)
LocalPlayer.Idled:Connect(function()
    if _G_QK.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- 13. CẬP NHẬT NHÃN THÔNG TIN NGƯỜI CHƠI THEO THỜI GIAN THỰC
task.spawn(function()
    while task.wait(2) do
        pcall(function()
            if ProfileLabel and LevelLabel and BeliLabel and FragLabel then
                LevelLabel.Text = "⭐ Cấp độ: " .. GetCurrentLevel() .. " / Max 2840"
                if LocalPlayer:FindFirstChild("Data") then
                    if LocalPlayer.Data:FindFirstChild("Beli") then
                        BeliLabel.Text = "💰 Beli: " .. LocalPlayer.Data.Beli.Value
                    end
                    if LocalPlayer.Data:FindFirstChild("Fragments") then
                        FragLabel.Text = "🔮 Fragments: " .. LocalPlayer.Data.Fragments.Value
                    end
                end
            end
        end)
    end
end)

print("=========================================================")
print("👑 QUỐC KHÁNH HUB (v3.5 ULTIMATE) - BLOX FRUITS SUITE")
print("⚡ Tác giả độc quyền: QUỐC KHÁNH")
print("💎 100% tính năng hoạt động thực tế. Chúc bạn chơi vui vẻ!")
print("=========================================================")
