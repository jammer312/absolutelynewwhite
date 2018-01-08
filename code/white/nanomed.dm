/obj/machinery/vending/wallmed/emergency
	name = "\improper NanoMed"
	desc = "Wall-mounted Medical Equipment dispenser for emergency use."
	icon_state = "wallmed"
	icon_deny = "wallmed-deny"
	req_access_txt = "0"
	density = 0
	products = list(/obj/item/weapon/reagent_containers/pill/patch/styptic = 5,
					/obj/item/weapon/reagent_containers/pill/patch/silver_sulf = 5,
					/obj/item/weapon/reagent_containers/glass/bottle/diphenhydramine = 2,/obj/item/weapon/reagent_containers/glass/bottle/potass_iodide = 2,
					/obj/item/weapon/reagent_containers/glass/bottle/atropine = 2,/obj/item/weapon/reagent_containers/syringe/antiviral = 3,
					/obj/item/weapon/reagent_containers/pill/salbutamol = 5,
					/obj/item/device/healthanalyzer = 2, /obj/item/device/sensor_device = 3)
	contraband = list(/obj/item/weapon/reagent_containers/pill/tox = 2,/obj/item/weapon/reagent_containers/pill/morphine = 2,/obj/item/weapon/reagent_containers/pill/charcoal = 3)
