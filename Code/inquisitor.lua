local xBase = 32
local yBase = 36

local sprIdle = Sprite.new("InquisitorIdle", path.combine(PATH, "Sprites/idleNew.png"), 1, xBase, yBase)
local sprWalk = Sprite.new("InquisitorWalk", path.combine(PATH, "Sprites/walk.png"), 8, xBase, yBase)
local sprWalkBack = Sprite.new("InquisitorWalkBack", path.combine(PATH, "Sprites/walk_back.png"), 8, xBase, yBase)
local sprJump = Sprite.new("InquisitorJump", path.combine(PATH, "Sprites/jump.png"), 1, xBase, yBase)
local sprJumpPeak = Sprite.new("InquisitorJumpPeak", path.combine(PATH, "Sprites/jump_peak.png"), 1, xBase, yBase)
local sprFall = Sprite.new("InquisitorFall", path.combine(PATH, "Sprites/Fall.png"), 1, xBase, yBase)
local sprClimb = Sprite.new("InquisitorClimb", path.combine(PATH, "Sprites/climb.png"), 6, xBase, yBase)

local sprLog = Sprite.new("InquisitorLog", path.combine(PATH, "Sprites/log.png"), 1)
local sprPortrait = Sprite.new("InquisitorPortrait", path.combine(PATH, "Sprites/portrait.png"), 3)
local sprPortraitTiny = Sprite.new("InquisitorPortraitTiny", path.combine(PATH, "Sprites/portraitTiny.png"))
local sprPalette = Sprite.new("InquisitorPalette", path.combine(PATH, "Sprites/palette.png"))
local sprSelect = Sprite.new("InquisitorSelect", path.combine(PATH, "Sprites/select.png"), 11, 28, 0)

local sprSkills = Sprite.new("InquisitorSkills", path.combine(PATH, "Sprites/skills.png"), 6)
local sprDeath = Sprite.new("InquisitorDeath", path.combine(PATH, "Sprites/death.png"), 5, xBase, yBase)
local sprCredits = Sprite.new("InquisitorCredits", path.combine(PATH, "Sprites/credits.png"), 1, xBase, yBase)

local sprDecoy
if Util.chance(0.12) then
	sprDecoy = Sprite.new("InquisitorDecoy", path.combine(PATH, "Sprites/decoy.png"), 1, 20, 28)
else
	sprDecoy = Sprite.new("InquisitorSecretDecoy", path.combine(PATH, "Sprites/decoysecret.png"), 1, 20, 28)
end

local sprShoot1_1 = Sprite.new("InquisitorShoot1_1", path.combine(PATH, "Sprites/shoot1_1alt.png"), 8, xBase, yBase)
local sprShoot1_2 = Sprite.new("InquisitorShoot1_2", path.combine(PATH, "Sprites/shoot1_2alt.png"), 6, xBase, yBase)
local sprShoot1_3 = Sprite.new("InquisitorShoot1_3", path.combine(PATH, "Sprites/shoot1_3alt.png"), 5, xBase, yBase)
local sprShoot1_4 = Sprite.new("InquisitorShoot1_4", path.combine(PATH, "Sprites/shoot1_4.png"), 8, xBase, yBase)
local sprShoot1_5 = Sprite.new("InquisitorShoot1_5", path.combine(PATH, "Sprites/shoot1_5.png"), 7, xBase, yBase)

local sprShoot2 = Sprite.new("InquisitorShoot2", path.combine(PATH, "Sprites/shoot2alt1.png"), 9, xBase * 2, yBase)
local sprShoot2_1 = Sprite.new("InquisitorShoot2_1", path.combine(PATH, "Sprites/knee.png"), 5, xBase, yBase)
local sprShoot2_2 = Sprite.new("InquisitorShoot2_2", path.combine(PATH, "Sprites/tetsuzankoNoFX.png"), 10, xBase * 2 + 2, yBase * 2 - 4)
local sprShoot2Afterimage = Sprite.new("InquisitorShoot2Afterimage", path.combine(PATH, "Sprites/shoot2after.png"), 1, xBase * 2, yBase)

local sprStep1 = Sprite.new("InquisitorStep1", path.combine(PATH, "Sprites/step1.png"), 3, xBase, yBase)
local sprStep2 = Sprite.new("InquisitorStep2", path.combine(PATH, "Sprites/step2.png"), 3, xBase, yBase)
local sprStep3 = Sprite.new("InquisitorStep3", path.combine(PATH, "Sprites/step3.png"), 9, xBase, yBase)

local sprShoot4_1 = Sprite.new("InquisitorShoot4_1", path.combine(PATH, "Sprites/shoot4_1.png"), 42, xBase * 2 - 2, yBase * 2 - 4)

local sShoot1 = Sound.new("InquisitorShoot1SFX", path.combine(PATH, "Sprites/shoot1.ogg"))

local inquisitor = Survivor.new("inquisitor")

inquisitor:set_stats_base({
	health = 120,
	damage = 14,
	regen = 1.5 / 60,
	armor = 10,
})

inquisitor:set_stats_level({
	health = 38,
	damage = 4,
	regen = 0.2 / 60,
	armor = 3,
})

local inquisitor_log = SurvivorLog.new_from_survivor(inquisitor)
inquisitor_log.portrait_id = sprLog
inquisitor_log.sprite_id = sprWalk
inquisitor_log.sprite_icon_id = sprPortrait

inquisitor.primary_color = Color.from_hex(0xFFEBA8)

inquisitor.sprite_portrait = sprPortrait
inquisitor.sprite_portrait_small = sprPortraitTiny
inquisitor.sprite_loadout = sprSelect

inquisitor.sprite_idle = sprIdle
inquisitor.sprite_title = sprWalk
inquisitor.sprite_credits = sprCredits

inquisitor.sprite_palette = sprPalette
inquisitor.sprite_portrait_palette = sprPalette
inquisitor.sprite_loadout_palette = sprPalette

inquisitor.select_sound_id = sShoot1

Callback.add(inquisitor.on_init, function(actor)
	actor.sprite_idle_half = Array.new({sprIdle, nil, 0})
	actor.sprite_walk_half = Array.new({sprWalk, nil, 0, sprWalkBack})
	actor.sprite_jump_half = Array.new({sprJump, nil, 0})
	actor.sprite_jump_peak_half = Array.new({sprJumpPeak, nil, 0})
	actor.sprite_fall_half = Array.new({sprFall, nil, 0})
	
	actor.sprite_idle = sprIdle
	actor.sprite_walk = sprWalk
	actor.sprite_jump = sprJump
	actor.sprite_jump_peak = sprJumpPeak
	actor.sprite_fall = sprFall
	actor.sprite_climb = sprClimb
	actor.sprite_death = sprDeath
	actor.sprite_decoy = sprDecoy
	--actor.sprite_drone_idle = sprite_drone_idle
	--actor.sprite_drone_shoot = sprite_drone_shoot
	
	local data = Instance.get_data(actor)
	data.z = 1
	data.zTimer = -1
	data.buffer = 0
	data.hasInputs = true
	data.overhead = false
	data.resonance = false
	data.antiSpam = 0

	actor:survivor_util_init_half_sprites()
end)

-- default skills
local primary = inquisitor:get_skills(Skill.Slot.PRIMARY)[1]
local secondary = inquisitor:get_skills(Skill.Slot.SECONDARY)[1]
local utility = inquisitor:get_skills(Skill.Slot.UTILITY)[1]
local special = inquisitor:get_skills(Skill.Slot.SPECIAL)[1]
local specialS = Skill.new("inquisitorVBoosted")

primary.sprite = sprSkills
primary.subimage = 2
primary.cooldown = 20
primary.damage = 1

local statePrimaryA = ActorState.new("inquisitorPunchA")
local statePrimaryB = ActorState.new("inquisitorPunchB")
local statePrimaryC = ActorState.new("inquisitorPunchC")
local statePrimaryD = ActorState.new("inquisitorPunchD")
local statePrimaryE = ActorState.new("inquisitorPunchE")

local function handle_primary_code(actor, data, condition1)
	if condition1 then
		data.sound = data.sound + 1
		actor:sound_play(sShoot1.value, 1, 0.9 + math.random() * 0.2)
	end
	
	
end

Callback.add(primary.on_activate, function(actor, skill, slot)
	local data = Instance.get_data(actor)
	if data.z == 0 then
		actor:set_state(statePrimaryA)
	elseif data.z == 1 then
		actor:set_state(statePrimaryB)
	elseif data.z == 2 then
		actor:set_state(statePrimaryC)
	elseif data.z == 3 then
		actor:set_state(statePrimaryD)
	elseif data.z == 4 then
		actor:set_state(statePrimaryE)
	end
end)

Callback.add(statePrimaryA.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(statePrimaryA.on_step, function(actor, data)
	local get_data = Instance.get_data(actor)
	handle_primary_code(actor, data, ((actor.image_index >= 2 and data.sound == 0) or (actor.image_index >= 4 and data.sound == 1)), sprShoot1_1)
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(statePrimaryA.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 2 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	else
		return ActorState.InterruptPriority.PRIORITY_SKILL
	end
end)

Callback.add(statePrimaryB.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(statePrimaryB.on_step, function(actor, data)
	local get_data = Instance.get_data(actor)
	handle_primary_code(actor, data, (actor.image_index >= 2 and data.sound == 0), sprShoot1_2)
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(statePrimaryB.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 2 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	else
		return ActorState.InterruptPriority.PRIORITY_SKILL
	end
end)

Callback.add(statePrimaryC.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(statePrimaryC.on_step, function(actor, data)
	local get_data = Instance.get_data(actor)
	handle_primary_code(actor, data, (actor.image_index >= 2 and data.sound == 0), sprShoot1_3)
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(statePrimaryC.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 2 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	else
		return ActorState.InterruptPriority.PRIORITY_SKILL
	end
end)

Callback.add(statePrimaryD.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(statePrimaryD.on_step, function(actor, data)
	local get_data = Instance.get_data(actor)
	handle_primary_code(actor, data, (actor.image_index >= 3 and data.sound == 0), sprShoot1_4)
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(statePrimaryD.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 2 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	else
		return ActorState.InterruptPriority.PRIORITY_SKILL
	end
end)

Callback.add(statePrimaryE.on_enter, function(actor, data)
	actor.image_index = 0
	data.fired = 0
end)

Callback.add(statePrimaryE.on_step, function(actor, data)
	local get_data = Instance.get_data(actor)
	handle_primary_code(actor, data, (actor.image_index >= 3 and data.sound == 0), sprShoot1_5)
	actor:skill_util_exit_state_on_anim_end()
end)

Callback.add(statePrimaryE.on_get_interrupt_priority, function(actor, data)
	if actor.image_index >= 2 then
		return ActorState.InterruptPriority.SKILL_INTERRUPT_PERIOD
	else
		return ActorState.InterruptPriority.PRIORITY_SKILL
	end
end)

secondary.sprite = sprSkills
secondary.subimage = 3
secondary.cooldown = 4 * 60
secondary.damage = 1

utility.sprite = sprSkills
utility.subimage = 4
utility.cooldown = 2 * 60
utility.damage = 1

special.sprite = sprSkills
special.subimage = 5
special.cooldown = 8 * 60
special.damage = 1