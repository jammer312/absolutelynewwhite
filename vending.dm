/obj/machinery/vending/ammo
	name = "Sgt. Robust's Munition Supply"
	desc = "An ammunition vending machine."
	icon_state = "ammo"
	icon = 'icons/ammo.dmi'
	product_slogans = "Kill 'em all!;Any caliber or filling!;Get your clip!;I've got pills that cure defiance!"
	vend_reply = "Don't spend all at once!"
	req_access_txt = "2"
	products = list(/obj/item/weapon/storage/box/lethalshot = 5,/obj/item/weapon/storage/box/rubbershot = 5, /obj/item/ammo_box/magazine/m45 = 5, /obj/item/ammo_box/magazine/m556 = 5,
					/obj/item/ammo_box/c38 = 6, /obj/item/ammo_box/c9mm = 5, /obj/item/ammo_box/c45 = 4, /obj/item/ammo_box/c10mm = 4)
	contraband = list(/obj/item/ammo_casing/shotgun/incendiary/dragonsbreath = 5, /obj/item/ammo_box/magazine/m762 = 3, /obj/item/ammo_box/magazine/smgm45 = 3)
	premium = list(/obj/item/ammo_box/magazine/m50 = 3, /obj/item/ammo_box/magazine/m75 = 2)

/obj/item/ammo_box/magazine/m762
	name = "box magazine (7.62mm)"
	icon_state = "a762-50"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/a762
	caliber = "a762"
	max_ammo = 50

/obj/item/ammo_box/magazine/m762/update_icon()
	..()
	icon_state = "a762-[round(ammo_count(),10)]"