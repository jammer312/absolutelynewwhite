var/datum/space_exploration_config/pod/pod_config

/datum/space_exploration_config/pod
	category = "Pod"

//костылю сюда все значения так как конфиг.тхт не работает походу

	var/damage_notice_cooldown = 10
	var/damage_overlay_threshold = 40
	var/ex_act_damage = 50
	var/blob_act_damage = 25
	var/emp_act_attachment_toggle_chance = 60
	var/emp_act_power_absorb_percent = 30
	var/emp_act_duration = 300
	var/emp_sparkchance = 5
	var/fire_damage = 5
	var/fire_damage_cooldown = 20
	var/fire_oxygen_consumption_percent = 0.1
	var/fire_damage_oxygen_cutoff = 0.9
	var/pod_pullout_delay = 80
	var/list/drivable = list(/turf/space) //не используется нигде вроде, оно не давало ехать по станции и я разнерфал
	var/metal_repair_threshold_percent = 75
	var/metal_repair_amount = 5
	var/welding_repair_amount = 15
	var/movement_cost = 2
	var/alien_damage_lower = 10
	var/alien_damage_upper = 20
	var/paw_damage_lower = 2
	var/paw_damage_upper = 8
	var/handcuffed_exit_delay = 1200

	// Clickable debug object
	var/obj/effect/statclick/statclick

	proc/AddToStat()
		if(!statclick)
			statclick = new/obj/effect/statclick/debug("Edit", src)

		stat("Space Pod Config:", statclick)