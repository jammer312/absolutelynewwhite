/*
* Fabricator Circuit Board
*/

/obj/item/weapon/circuitboard/mechfab/podfab
	name = "circuit board (Pod Fabricator)"
	build_path = /obj/machinery/mecha_part_fabricator/pod
	origin_tech = "programming=3;engineering=3"
/*
* Pod Fabricator
*/

/obj/machinery/mecha_part_fabricator/pod
	name = "space pod fabricator"
	icon = 'icons/obj/podfab.dmi'
	icon_state = "pod-fab"
	production_type = PODFAB
	req_access = list()

	part_sets = list(
					"Weapons",
					"Utility",
					"Ammunition",
					"Shield",
					"Engine",
					"Cargo Hold",
					"Construction",
					"Secondary",
					"Sensor"
					)

/obj/machinery/mecha_part_fabricator/pod/New()
	..()
	component_parts = list()
	component_parts += new /obj/item/weapon/circuitboard/mechfab/podfab(null)
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(null)
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(null)
	component_parts += new /obj/item/weapon/stock_parts/manipulator(null)
	component_parts += new /obj/item/weapon/stock_parts/micro_laser(null)
	component_parts += new /obj/item/weapon/stock_parts/console_screen(null)
	RefreshParts()
	files = new /datum/research(src)

/*	GetPartSets()
		var/list/categories = list()

		for(var/datum/design/D in files.possible_designs)
			if(D.build_type & PODFAB)
				categories |= D.category

		return categories*/

/*
* RnD Console
*/

/obj/machinery/computer/rdconsole/podbay
	name = "Pod Manufacturing R&D Console"
	id = 3
	req_access = list()

/*/obj/machinery/mecha_part_fabricator/proc/GetPartSets()
	return list(
								"Cyborg",
								"Ripley",
								"Firefighter",
								"Odysseus",
								"Gygax",
								"Durand",
								"H.O.N.K",
								"Phazon",
								"Exosuit Equipment",
								"Cyborg Upgrade Modules",
								"Misc"
								)*/