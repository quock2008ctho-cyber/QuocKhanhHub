--[[
    ══════════════════════════════════════════════════════════════════════════════
    👑 QUỐC KHÁNH HUB - UNIVERSAL ONLINE LOADER (v2.8)
    ══════════════════════════════════════════════════════════════════════════════
    • Tác giả độc quyền: QUỐC KHÁNH
    • Hỗ trợ đa nền tảng: PC (Real, NEXOMIA, Wave, Synapse Z, Solara) & Mobile (Delta, Codex, Hydrogen)
    • Cách dùng 1 dòng:
      loadstring(game:HttpGet("https://raw.githubusercontent.com/quock2008ctho-cyber/QuocKhanhHub/main/Loader.lua"))()
    ══════════════════════════════════════════════════════════════════════════════
]]

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Banner bản quyền trên Console của Executor
local Banner = [[
   ___  _   _  ___   ____   _  __ _   _    _    _   _ _   _   _   _ _   _ ____  
  / _ \| | | |/ _ \ / ___| | |/ /| | | |  / \  | \ | | | | | | | | | | | | __ ) 
 | | | | | | | | | | |     | ' / | |_| | / _ \ |  \| | |_| | | |_| | | | |  _ \ 
 | |_| | |_| | |_| | |___  | . \ |  _  |/ ___ \| |\  |  _  | |  _  | |_| | |_) |
  \__\_\\___/ \___/ \____| |_|\_\|_| |_/_/   \_\_| \_|_| |_| |_| |_|\___/|____/ 
                                                                                  
  >> PHIÊN BẢN: v2.8 (EXCLUSIVE EDITION)
  >> TÁC GIẢ: QUỐC KHÁNH
  >> ĐANG KHỞI ĐỘNG HỆ THỐNG...
]]
print(Banner)

-- Hàm hiển thị thông báo hệ thống
local function SendNotification(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "👑 " .. title,
            Text = text,
            Duration = duration or 5
        })
    end)
end

-- Nhận diện Executor đang chạy
local ExecutorName = (identifyexecutor and identifyexecutor()) 
    or (getexecutorname and getexecutorname()) 
    or "Real / NEXOMIA"

SendNotification("Quốc Khánh Hub", "Đang kết nối qua " .. ExecutorName .. "...", 3)
print("[Quốc Khánh Hub] Executor phát hiện được: " .. tostring(ExecutorName))

-- Bảng ID các game được Quốc Khánh Hub hỗ trợ
local SupportedGames = {
    -- Blox Fruits: Sea 1, Sea 2, Sea 3 và Test Dump Place
    [2753915549] = "Blox Fruits (First Sea)",
    [4442272183] = "Blox Fruits (Second Sea)",
    [7449423635] = "Blox Fruits (Third Sea)",
    [85211729168715] = "Blox Fruits (Live Place)",
    
    -- Các game mở rộng sau này
    [4520749081] = "King Legacy",
    [13772394625] = "Blade Ball",
    [1537690962] = "Bee Swarm Simulator"
}

local PlaceId = game.PlaceId
local GameTitle = SupportedGames[PlaceId] or "Blox Fruits"

print("[Quốc Khánh Hub] Game PlaceId: " .. tostring(PlaceId) .. " (" .. GameTitle .. ")")

-- Đường dẫn nguồn trực tuyến (Bạn có thể thay bằng link GitHub raw thật của bạn)
local GitHub_Repo = "https://raw.githubusercontent.com/quock2008ctho-cyber/QuocKhanhHub/main"
local ScriptUrl = GitHub_Repo .. "/QuocKhanh_Hub.lua"

-- Tự động tải Module theo Game
local success, err = pcall(function()
    -- Kiểm tra nếu có file cục bộ trong Real / NEXOMIA workspace
    local localPath = "RobloxRootDumps/Tr__i_c__y_Blox_85211729168715/QuocKhanh_Hub.lua"
    if isfile and isfile(localPath) then
        print("[Quốc Khánh Hub] Đang tải từ bộ nhớ Workspace...")
        loadstring(readfile(localPath))()
    elseif isfile and isfile("QuocKhanh_Hub.lua") then
        print("[Quốc Khánh Hub] Đang tải từ tệp QuocKhanh_Hub.lua...")
        loadstring(readfile("QuocKhanh_Hub.lua"))()
    else
        print("[Quốc Khánh Hub] Đang tải bản mới nhất từ máy chủ đám mây...")
        loadstring(game:HttpGet(ScriptUrl))()
    end
end)

if success then
    SendNotification("Quốc Khánh Hub", "Tải thành công! Chào mừng bạn đến với v2.8!", 5)
else
    warn("[Quốc Khánh Hub] Lỗi khi tải script: " .. tostring(err))
    SendNotification("Lỗi Tải Script", "Vui lòng kiểm tra lại kết nối mạng hoặc thử lại!", 6)
end
