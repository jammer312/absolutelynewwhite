/obj/machinery/deployable/barrier
	name = "deployable barrier"
	desc = "A deployable barrier. Swipe your ID card to lock/unlock it."
	icon = 'icons/obj/objects.dmi'
	anchored = 0
	density = 1
	icon_state = "barrier0"
	var/health = 100
	var/maxhealth = 100
	var/locked = 0
//	req_access = list(access_maint_tunnels)

/obj/machinery/deployable/barrier/New()
	..()

	src.icon_state = "barrier[src.locked]"

/obj/machinery/deployable/barrier/proc/take_damage(damage)
	health -= damage
	if(health <= 0)
		explode()

/obj/machinery/deployable/barrier/attackby(obj/item/weapon/W, mob/user, params)
	if (W.GetID())
		if (src.allowed(user))
			if	(emagged < 2)
				locked = !locked
				anchored = !anchored
				icon_state = "barrier[locked]"
				if ((locked == 1) && (emagged < 2))
					user << "Barrier lock toggled on."
					return
				else if ((locked == 0) && (emagged < 2))
					user << "Barrier lock toggled off."
					return
			else
				var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
				s.set_up(2, 1, src)
				s.start()
				visible_message("<span class='danger'>BZZzZZzZZzZT</span>")
				return
		return
	else if (istype(W, /obj/item/weapon/wrench))
		if (health < maxhealth)
			health = maxhealth
			emagged = 0
			req_access = list(access_security)
			visible_message("<span class='danger'>[user] repairs \the [src]!</span>")
			return
		else if (src.emagged > 0)
			emagged = 0
			req_access = list(access_security)
			visible_message("<span class='danger'>[user] repairs \the [src]!</span>")
			return
		return
	else
		..()
		var/damage = 0
		switch(W.damtype)
			if("fire")
				damage = W.force * 0.75
			if("brute")
				damage = W.force * 0.5
		take_damage(damage)

/obj/machinery/deployable/emag_act(mob/user)
	if (src.emagged == 0)
		src.emagged = 1
		src.req_access = null
		user << "<span class='notice'>You break the ID authentication lock on \the [src].</span>"
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(2, 1, src)
		s.start()
		visible_message("<span class='danger'>BZZzZZzZZzZT</span>")
		return
	else if (src.emagged == 1)
		src.emagged = 2
		user << "<span class='notice'>You short out the anchoring mechanism on \the [src].</span>"
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(2, 1, src)
		s.start()
		visible_message("<span class='danger'>BZZzZZzZZzZT</span>")
		return

/obj/machinery/deployable/barrier/ex_act(severity)
	switch(severity)
		if(1)
			explode()
		if(2)
			take_damage(25)


/obj/machinery/deployable/barrier/emp_act(severity)
	if(stat & (BROKEN|NOPOWER))
		return
	if(prob(50/severity))
		locked = !locked
		anchored = !anchored
		icon_state = "barrier[src.locked]"

/obj/machinery/deployable/barrier/blob_act()
	take_damage(25)

/obj/machinery/deployable/barrier/CanPass(atom/movable/mover, turf/target, height=0)//So bullets will fly over and stuff.
	if(height==0)
		return 1
	if(istype(mover, /obj/item/projectile))
		if(!anchored)
			return 1
		var/obj/item/projectile/proj = mover
		if(proj.firer && Adjacent(proj.firer))
			return 1
		if(prob(20))
			return 1
		return 0
	else
		return 0

/obj/machinery/deployable/barrier/proc/explode()

	visible_message("<span class='danger'>[src] blows apart!</span>")
	var/turf/Tsec = get_turf(src)

/*	var/obj/item/stack/rods/ =*/
	new /obj/item/stack/rods(Tsec)

	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()

	explosion(src.loc,-1,-1,0)
	if(src)
		qdel(src)
