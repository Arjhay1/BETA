-- Minimal GUI test
local Players = game:GetService("Players")
local player  = Players.LocalPlayer
local gui     = Instance.new("ScreenGui")
gui.Name      = "TestGui"
gui.ResetOnSpawn = false
gui.Parent    = player:WaitForChild("PlayerGui")

local frame   = Instance.new("Frame", gui)
frame.Size    = UDim2.new(0,200,0,200)
frame.Position= UDim2.new(0.5,-100,0.5,-100)
frame.BackgroundColor3 = Color3.new(1,0,0)
