extends Label

#stores exp data and shows to user
func update_text(experience, experienceReq):
	text = """Experience: %s / %s
	""" % [experience, experienceReq]
