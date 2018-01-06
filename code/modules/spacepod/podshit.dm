
//я суда просто копипастил код которово нихвотает

/obj/item/weapon/circuitboard/mecha/pod
	name = "circuit board (Space Pod Mainboard)"
	icon_state = "mainboard"

#define state_next "next"
#define state_prev "prev"

/datum/construction/reversible2
	var/index
	var/base_icon = "durand"

	New(atom)
		..()
		index = 1
		return

	proc/update_index(diff as num, mob/user as mob)
		index-=diff
		if(index==steps.len+1)
			spawn_result(user)
		else
			set_desc(index)
		return

	proc/update_icon()
		holder.icon_state="[base_icon]_[index]"

	is_right_key(mob/user as mob,atom/used_atom) // returns index step
		var/list/state = steps[index]
		if(state_next in state)
			var/list/step = state[state_next]
			if(istype(used_atom, step["key"]))
				//if(L["consume"] && !try_consume(used_atom,L["consume"]))
				//	return 0
				return FORWARD //to the first step -> forward
		else if(state_prev in state)
			var/list/step = state[state_prev]
			if(istype(used_atom, step["key"]))
				//if(L["consume"] && !try_consume(used_atom,L["consume"]))
				//	return 0
				return BACKWARD //to the first step -> forward
		return 0

	check_step(atom/used_atom,mob/user as mob)
		var/diff = is_right_key(user,used_atom)
		if(diff)
			if(custom_action(index, diff, used_atom, user))
				update_index(diff,user)
				update_icon()
				return 1
		return 0

	proc/fixText(text,user)
		text = replacetext(text,"{USER}","[user]")
		text = replacetext(text,"{HOLDER}","[holder]")
		return text

	custom_action(index, diff, used_atom, var/mob/user)
		if(!..(index,used_atom,user))
			return 0

		var/list/step = steps[index]
		var/list/state = step[diff==FORWARD ? state_next : state_prev]
		user.visible_message(fixText(state["vis_msg"],user),fixText(state["self_msg"],user))

		if("delete" in state)
			qdel(used_atom)
		else if("spawn" in state)
			var/spawntype=state["spawn"]
			var/atom/A = new spawntype(holder.loc)
			if("amount" in state)
				if(istype(A,/obj/item/stack/cable_coil))
					var/obj/item/stack/cable_coil/C=A
					C.amount=state["amount"]
				if(istype(A,/obj/item/stack))
					var/obj/item/stack/S=A
					S.amount=state["amount"]

		return 1
	action(used_atom,user)
		return check_step(used_atom,user)

/mob/proc/put_in_any_hand_if_possible(obj/item/W as obj, del_on_fail = 0, disable_warning = 1, redraw_mob = 1)
	if(equip_to_slot_if_possible(W, 4, del_on_fail, disable_warning, redraw_mob))
		return 1
	return 0

/obj/item/projectile/proc/dumbfire(var/dir)
	current = get_ranged_target_turf(src, dir, world.maxx)
	fire()